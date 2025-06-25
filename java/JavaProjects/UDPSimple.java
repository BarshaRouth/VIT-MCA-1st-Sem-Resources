import java.net.*;
import java.io.IOException;

public class UDPSimple {
    private static DatagramSocket ds;
    public static void startServer(){
        try {
            ds = new DatagramSocket(5555);
            DatagramPacket packet = new DatagramPacket(new byte[100], 100);
            ds.receive(packet); // Receive one message
            System.out.println("Received: " + new String(packet.getData(), 0, packet.getLength()));

            String response = "Message received"; // Create response message
            byte[] responseBytes = response.getBytes();
            ds.send(new DatagramPacket(responseBytes, responseBytes.length, InetAddress.getLocalHost(), 6666));// Send response
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
            ds = new DatagramSocket();
            String message = "Hello from client"; // Define the message to send
            byte[] messageBytes = message.getBytes();
            ds.send(new DatagramPacket(messageBytes, messageBytes.length, InetAddress.getLocalHost(), 5555));// Send one message

            DatagramPacket responsePacket = new DatagramPacket(new byte[100], 100);
            ds.receive(responsePacket); // Receive response
            System.out.println("Server response: " + new String(responsePacket.getData(), 0, responsePacket.getLength()));
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
                if (args.length > 0) 
                    startServer();
                else
                    startClient();
            } catch (Exception e) {
            System.err.println("Socket error: " + e.getMessage());
        }
    }
}