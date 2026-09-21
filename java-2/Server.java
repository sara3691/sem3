import java.net.*;
import java.io.*;
import java.util.*;

class Server {
    public static void main(String[] args) throws Exception {

        ServerSocket ss = new ServerSocket(3333);
        Socket s = ss.accept();

        DataInputStream in = new DataInputStream(s.getInputStream());
        DataOutputStream out = new DataOutputStream(s.getOutputStream());
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.println("Client: " + in.readUTF());

            System.out.print("Server: ");
            String msg = sc.nextLine();

            out.writeUTF(msg);

            if (msg.equals("stop"))
                break;
        }

        s.close();
        ss.close();
    }
}