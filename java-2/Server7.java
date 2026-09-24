import java.rmi.*;
import java.rmi.registry.*;

public class Server7 {
    public static void main(String[] args) throws Exception {

        MyRemote obj = new ServerImpl();

        LocateRegistry.createRegistry(1099);

        Naming.rebind("Hello", obj);

        System.out.println("Server is running...");
    }
}