package TCPChat;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Scanner;
public class MyClientTCP {
    public static void main(String[] args) {
        try (Socket s = new Socket("127.0.0.1", 6666)) {
            System.out.println("Connected to the server.");

            // Start thread to read messages from server
            new Thread(new ReceiveTask(s)).start();
            // Start thread to send messages to server
            new Thread(new SendTask(s)).start();
        } catch (Exception e) {
            System.err.println("Client error: " + e.getMessage());
        }
    }
}

// Runnable class to handle receiving messages
class ReceiveTask implements Runnable {
    private Socket socket;

    public ReceiveTask(Socket socket) {
        this.socket = socket;
    }

    @Override
    public void run() {
        try (DataInputStream dis = new DataInputStream(socket.getInputStream())) {
            while (true) {
                String receivedMessage = dis.readUTF();
                System.out.println("Server: " + receivedMessage);
            }
        } catch (IOException e) {
            System.err.println("Error receiving data: " + e.getMessage());
        }
    }
}

// Runnable class to handle sending messages
class SendTask implements Runnable {
    private Socket socket;
    private Scanner scanner;

    public SendTask(Socket socket) {
        this.socket = socket;
        this.scanner = new Scanner(System.in);
    }

    @Override
    public void run() {
        try (DataOutputStream dos = new DataOutputStream(socket.getOutputStream())) {
            while (true) {
                String message = scanner.nextLine();
                dos.writeUTF(message);
                dos.flush();
            }
        } catch (IOException e) {
            System.err.println("Error sending data: " + e.getMessage());
        }
    }
}
