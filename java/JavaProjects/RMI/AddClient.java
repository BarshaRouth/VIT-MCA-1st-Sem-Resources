package RMI;

import java.rmi.Naming;

public class AddClient {
    public static void main(String[] args) {
        try {
            // URL where the server's remote object is bound
            String url = "rmi://127.0.0.1/Addition";
            AddImpf ai = (AddImpf) Naming.lookup(url);

            // Call the remote method
            int result = ai.doAddition(10, 80);
            System.out.println("Result: " + result);
        } catch (Exception e) {
            System.err.println("Client exception: " + e.getMessage());
        }
    }
}