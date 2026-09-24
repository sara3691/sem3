import java.rmi.*;
import java.rmi.server.*;

public class ServerImpl extends UnicastRemoteObject
        implements MyRemote {

    ServerImpl() throws RemoteException {
        super();
    }

    public String sayHello() {
        return "Hello from RMI Server";
    }
}