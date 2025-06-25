import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.io.IOException;

public class UDPDemo {
    private static DatagramSocket ds;
    private static final byte[] buffer = new byte[1024];

    public static void startServer() {
        try {
            int pos = 0;
            while (true) {
                int ch = System.in.read();
                switch (ch) {
                    case '\n':
                        ds.send(new DatagramPacket(buffer, pos, InetAddress.getLocalHost(), 6666));
                        pos = 0;
                        break;
                    default:
                            buffer[pos++] = (byte) ch;
                        break;
                }
            }
        } catch (IOException e) {
            System.err.println("Server error: " + e.getMessage());
        } finally {
            if (ds != null && !ds.isClosed()) {
                ds.close();
            }
        }
    }

    public static void startClient() {
        try {
            while (true) {
                DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
                ds.receive(packet);
                System.out.println("Received: " + new String(packet.getData(), 0, packet.getLength()));
            }
        } catch (IOException e) {
            System.err.println("Client error: " + e.getMessage());
        } finally {
            if (ds != null && !ds.isClosed()) {
                ds.close();
            }
        }
    }

    public static void main(String[] args) {
        try {
            if (args.length == 1 && args[0].equals("server")) {
                ds = new DatagramSocket(5555);
                startServer();
            } else if (args.length == 1 && args[0].equals("client")) {
                ds = new DatagramSocket(6666);
                startClient();
            } else {
                System.out.println("Usage: java UDPDemo <server/client>");
            }
        } catch (SocketException e) {
            System.err.println("Socket error: " + e.getMessage());
        }
    }
}