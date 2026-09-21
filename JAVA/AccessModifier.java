class Employee{
 public String name ="sarath";
 protected int id = 101;
 private double salary = 20000.0;

 public void display()
 {
    System.out.println("name : "+name);
    System.out.println("id : "+id);
    System.out.println("salary : "+ salary);

 }

}

class AccessModifier{
    public static void main(String[] args){
        Employee e =new Employee();
        e.display();

        System.out.println("public : "+e.name);
        System.out.println("protected : "+e.id);

    }


}