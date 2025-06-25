package TCPChat;

import java.io.*;
import java.net.*;
import java.util.Scanner;

public class MyServerTCP {
    public static void main(String[] args) {
        try (ServerSocket ss = new ServerSocket(6666)) {
            System.out.println("Server is waiting for a client...");
            Socket s = ss.accept();
            System.out.println("Client connected.");
            // Start thread to read messages from client
            new Thread(new ReceiveTask(s)).start();
            // Start thread to send messages to client
            new Thread(new SendTask(s)).start();
        } catch (Exception e) {
            System.err.println("Server error: " + e.getMessage());
        }
    }
}

// Runnable class to handle receiving messages
class ReceiveTask implements Runnable {
    private Socket socket;

    public ReceiveTask(Socket s) {
        this.socket = s;
    }

    public void run() {
        try (DataInputStream dis = new DataInputStream(socket.getInputStream())) {
            while (true) {
                System.out.println("Client: " + dis.readUTF());
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

    public void run() {
        try (DataOutputStream dos = new DataOutputStream(socket.getOutputStream())) {
            while (true) {
                dos.writeUTF(scanner.nextLine());
                dos.flush();
            }
        } catch (IOException e) {
            System.err.println("Error sending data: " + e.getMessage());
        }
    }
}
