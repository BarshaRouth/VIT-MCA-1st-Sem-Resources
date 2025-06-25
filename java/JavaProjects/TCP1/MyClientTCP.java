package TCP1;

import java.io.DataInputStream;
import java.net.Socket;

public class MyClientTCP {
    public static void main(String[] args) {
        try (Socket s = new Socket("127.0.0.1", 6666)) {
            try (DataInputStream dis = new DataInputStream(s.getInputStream())) {
                String st = dis.readUTF();
                System.out.println("Received: " + st);
            } catch (Exception e) {
                System.err.println("Error receiving data: " + e.getMessage());
            }
        } catch (Exception e) {
            System.err.println("Client error: " + e.getMessage());
        }
    }
}
