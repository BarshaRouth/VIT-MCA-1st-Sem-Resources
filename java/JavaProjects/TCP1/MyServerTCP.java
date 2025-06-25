package TCP1;

import java.io.DataOutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class MyServerTCP {
    public static void main(String[] args) {
        try (ServerSocket ss = new ServerSocket(6666)) {
            System.out.println("Server is waiting for a client...");
            Socket s = ss.accept();
            try (DataOutputStream dos = new DataOutputStream(s.getOutputStream())) {
                dos.writeUTF("Hello");
                System.out.println("Message sent to the client.");
            } catch (Exception e) {
                System.err.println("Error sending data: " + e.getMessage());
            }
        } catch (Exception e) {
            System.err.println("Server error: " + e.getMessage());
        }
    }
}