import java.net.*;
import java.io.*;
import java.util.*;

class Client {
    public static void main(String[] args) throws Exception {

        Socket s = new Socket("localhost", 3333);

        DataInputStream in = new DataInputStream(s.getInputStream());
        DataOutputStream out = new DataOutputStream(s.getOutputStream());
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.print("Client: ");
            String msg = sc.nextLine();

            out.writeUTF(msg);

            if (msg.equals("stop"))
                break;

            System.out.println("Server: " + in.readUTF());
        }

        s.close();
    }
}