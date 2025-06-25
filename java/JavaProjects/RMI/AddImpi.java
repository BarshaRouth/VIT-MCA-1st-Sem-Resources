package RMI;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class AddImpi extends UnicastRemoteObject implements AddImpf {
    
    // Constructor to handle RemoteException
    protected AddImpi() throws RemoteException {
        super();
    }

    // Implement the remote method
    @Override
    public int doAddition(int x, int y) throws RemoteException {
        return x + y;
    }
}