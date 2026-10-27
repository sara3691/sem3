import java.sql.*;

class Exno9
 {
    public static void main(String[] args) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/emp",
                "root",
                ""
            );

            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM emp_detail");

            while (rs.next()) {
                System.out.println(rs.getInt(1) + " "
                    + rs.getString(2) + " "
                    + rs.getInt(3));
            }

            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}