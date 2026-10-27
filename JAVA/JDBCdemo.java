
import java.sql.*;

public class JDBCdemo {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/emp",
                "root",
                ""
            );

            System.out.println("Database Connected Successfully");

            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery(
                "SELECT * FROM emp_detail"
            );

            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("eid"));
                System.out.println("Name: " + rs.getString("ename"));
                System.out.println("Age: " + rs.getInt("eage"));
            
                System.out.println();
            }

            rs.close();
            st.close();
            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
