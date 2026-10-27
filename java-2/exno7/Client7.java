import java.rmi.*;

public class Client7 {
    public static void main(String[] args) throws Exception {

        MyRemote obj =
            (MyRemote) Naming.lookup("rmi://localhost/Hello");

        System.out.println(obj.sayHello());
    }
}