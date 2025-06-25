package RMI;


import java.rmi.Remote;
import java.rmi.RemoteException;

public interface AddImpf extends Remote {
    int doAddition(int x, int y) throws RemoteException;
}