class exception {  
    public static void main(String args[]) {         
    try {  
            int a = 30, b = 0;  int c = a / b;  
            System.out.println("Result = " + c);  
        } catch (ArithmeticException e) {  
            System.out.println("Can't divide a number by 0");  
        }   
    try {  
            int num = Integer.parseInt("20");  
            System.out.println(num);  
        } catch (NumberFormatException e) {  
            System.out.println("Number format exception");  
        }    
     try {  
            int a[] = new int[5];              
a[6] = 9;  
        } catch (ArrayIndexOutOfBoundsException e) {  
            System.out.println("Array Index is Out Of Bounds");  
        }  
     try {  
            Object[] objArray = new Integer[10];  
            objArray[0] = "String";   
        } catch (ArrayStoreException e) {  
            System.out.println("ArrayStoreException: " + e.getMessage());  
        }  
               try {  
            String a = null;   
            System.out.println(a.charAt(0));         
        } catch (NullPointerException e) {  
            System.out.println("NullPointerException: " + e.getMessage());  
        } 
    }  
}  
  