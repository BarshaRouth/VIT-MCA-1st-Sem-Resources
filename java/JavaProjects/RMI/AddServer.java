package RMI;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;

public class AddServer {
    public static void main(String[] args) {
        try {
            // Start the RMI registry on port 1099 (default RMI port)
            LocateRegistry.createRegistry(1099);

            // Create the remote object and bind it to the registry
            AddImpi ad = new AddImpi();
            Naming.rebind("Addition", ad);

            System.out.println("Server is ready.");
        } catch (RemoteException e) {
            System.err.println("RemoteException: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Exception: " + e.getMessage());
        }
    }
}
