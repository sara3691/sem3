import java.io.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/hello")
public class HelloServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("username");
        if (name == null || name.isEmpty())
            name = "Guest";

        out.println("<h2>Hello, " + name + "! Welcome to Servlet.</h2>");
    }
}
