
import java.sql.*;

public class javasql {
    public static void main(String[] args) {

        try {
            
            Connection c = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/emp",
                "root",
                ""
            );
            System.out.println("Database Connected Successfully!");

            Statement stmt = c.createStatement();

            ResultSet rs = stmt.executeQuery(
                "SELECT * FROM emp_detail"
            );

            while (rs.next()) {
                System.out.println("ID = " + rs.getInt("eid"));
                System.out.println("NAME = " + rs.getString("ename"));
                System.out.println("AGE = " + rs.getInt("eage"));
                System.out.println();
            }

            rs.close();
            stmt.close();
            c.close();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
