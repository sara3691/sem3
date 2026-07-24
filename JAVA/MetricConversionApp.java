import javax.swing.*;  
import java.awt.*;  
  
public class MetricConversionApp extends JFrame { 
     private JLabel cmLabel;      
     private JTextField cmTextField;     
     private JLabel inchLabel;     
     private JTextField inchTextField;      
     private JButton convertButton;  
  
     public MetricConversionApp() {          
        setTitle("Metric Conversion");  
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);          
        setSize(300, 150);          
        setLayout(new FlowLayout());  
  
        cmLabel = new JLabel("Centimeters:");          
        cmTextField = new JTextField(10);          
         inchLabel = new JLabel("Inches:");         
         inchTextField = new JTextField(10);          
         convertButton = new JButton("Convert");  
  
        convertButton.addActionListener(e -> {             
            try {  
                double centimeters = Double.parseDouble(cmTextField.getText());  
                double inches = centimeters / 2.54;  
                inchTextField.setText(String.format("%.2f", inches));  
            } catch (NumberFormatException ex) {  
 
 
 
                JOptionPane.showMessageDialog(null, "Invalid input. Please enter a valid number.");  
            }  
        });  
  
        add(cmLabel);         
        add(cmTextField);         
        add(inchLabel);          
        add(inchTextField);          
        add(convertButton);  
    }  
  
    public static void main(String[] args) {  
        SwingUtilities.invokeLater(() -> {  
            MetricConversionApp app = new MetricConversionApp();                        
            app.getRootPane().setDefaultButton(app.convertButton);              
            app.setVisible(true);  
        });  
    }  
}  
  