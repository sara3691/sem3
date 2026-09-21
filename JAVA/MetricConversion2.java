import javax.swing.*;

public class MetricConversion2 {
    public static void main(String[] args) {

        JFrame f = new JFrame("Metric Conversion");

        JLabel l1 = new JLabel("Centimeter:");
        JTextField t1 = new JTextField();

        JLabel l2 = new JLabel("Inches:");
        JTextField t2 = new JTextField();

        JButton b = new JButton("Convert");

        l1.setBounds(30, 30, 100, 30);
        t1.setBounds(120, 30, 100, 30);

        l2.setBounds(30, 70, 100, 30);
        t2.setBounds(120, 70, 100, 30);

        b.setBounds(80, 110, 100, 30);

        b.addActionListener(e -> {
            double cm = Double.parseDouble(t1.getText());
            double inch = cm / 2.54;
            t2.setText(String.format("%.2f", inch));
        });

        f.add(l1);
        f.add(t1);
        f.add(l2);
        f.add(t2);
        f.add(b);

        f.setSize(270, 200);
        f.setLayout(null);
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.setVisible(true);
    }
}
