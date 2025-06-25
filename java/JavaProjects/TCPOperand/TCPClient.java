package TCPOperand;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.Socket;
import java.util.Scanner;

public class TCPClient {
    public static void main(String[] args) {

        try (Socket socket = new Socket("localhost", 1234);
             DataInputStream dis = new DataInputStream(socket.getInputStream());
             DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
             Scanner scanner = new Scanner(System.in)) {

            System.out.println("Enter an operation in the format 'A + B':");
            String operation = scanner.nextLine();
            dos.writeUTF(operation);

            System.out.println("Server response: " + dis.readUTF());
        } catch (Exception e) {
            System.out.println("Client exception: " + e.getMessage());
        }
    }
}
