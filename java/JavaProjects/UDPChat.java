import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.io.IOException;

public class UDPChat {
    private static final byte[] buffer = new byte[1024];

    public static void startSender(DatagramSocket socket, InetAddress address, int port) {
        try {
            int pos = 0;
            while (true) {
                int ch = System.in.read();
                switch (ch) {
                    case '\n':
                        // Send the typed message to the other end
                        socket.send(new DatagramPacket(buffer, pos, address, port));
                        pos = 0; // Reset position after sending
                        break;
                    default:
                        if (pos < buffer.length) {
                            buffer[pos++] = (byte) ch;
                        } else {
                            System.err.println("Input too long for buffer size!");
                        }
                        break;
                }
            }
        } catch (IOException e) {
            System.err.println("Sender error: " + e.getMessage());
        }
    }

    public static void startReceiver(DatagramSocket socket) {
        try {
            while (true) {
                DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
                socket.receive(packet);
                String receivedMessage = new String(packet.getData(), 0, packet.getLength());
                System.out.println("Received: " + receivedMessage);
            }
        } catch (IOException e) {
            System.err.println("Receiver error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        if (args.length != 1 || (!args[0].equals("server") && !args[0].equals("client"))) {
            System.out.println("Usage: java UDPChat <server/client>");
            return;
        }

        try {
            DatagramSocket socket;
            InetAddress address;
            int port;

            if (args[0].equals("server")) {
                socket = new DatagramSocket(5555); // Server listens on port 5555
                address = InetAddress.getLocalHost(); // Server's address
                port = 6666; // Client's port to send messages to
                System.out.println("Server started on port 5555...");
            } else {
                socket = new DatagramSocket(6666); // Client listens on port 6666
                address = InetAddress.getLocalHost(); // Server's address
                port = 5555; // Server's port to send messages to
                System.out.println("Client started on port 6666...");
            }

            // Start sender and receiver threads for two-way communication
            Thread senderThread = new Thread(() -> startSender(socket, address, port));
            Thread receiverThread = new Thread(() -> startReceiver(socket));
            
            senderThread.start();
            receiverThread.start();

            // Wait for both threads to complete before closing the socket
            senderThread.join();
            receiverThread.join();
            
        } catch (SocketException e) {
            System.err.println("Socket error: " + e.getMessage());
        } catch (InterruptedException e) {
            System.err.println("Thread interruption error: " + e.getMessage());
        }catch(Exception e){
            System.err.println("huh");
        }
    }
}
