import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Calculator extends JFrame implements ActionListener {

    JTextField t;
    double a, b;
    char op;

    Calculator() {

        t = new JTextField();
        t.setEditable(false);

        String[] buttons = {
            "7","8","9","+",
            "4","5","6","-",
            "1","2","3","*",
            "C","0","=","/"
        };

        JPanel p = new JPanel();
        p.setLayout(new GridLayout(4,4));

        for(String s : buttons) {
            JButton b = new JButton(s);
            b.addActionListener(this);
            p.add(b);
        }

        add(t, BorderLayout.NORTH);
        add(p);

        setTitle("Simple Calculator");
        setSize(300,400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);
    }

    public void actionPerformed(ActionEvent e) {

        String s = e.getActionCommand();

        if(s.equals("+") || s.equals("-") ||
           s.equals("*") || s.equals("/")) {

            a = Double.parseDouble(t.getText());
            op = s.charAt(0);
            t.setText("");
        }

        else if(s.equals("=")) {

            b = Double.parseDouble(t.getText());

            if(op == '+')
                t.setText("" + (a+b));

            else if(op == '-')
                t.setText("" + (a-b));

            else if(op == '*')
                t.setText("" + (a*b));

            else if(op == '/')
                t.setText("" + (a/b));
        }

        else if(s.equals("C")) {
            t.setText("");
        }

        else {
            t.setText(t.getText() + s);
        }
    }

    public static void main(String[] args) {
        new Calculator();
    }
}
