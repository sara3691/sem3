class employee{
    public String name = "meow";
    private double salary= 50000;
    protected int id = 1;

    public void display(){
        System.out.println("name:"+name);
        System.out.println("salary:"+salary);
        System.out.println("id:"+id);
    }
}
public class AccessModifier{
    public static void main(String[]args){
        employee e=new employee();
        e.display();

        System.out.println("public:"+ e.name);
        System.out.println("protected:"+ e.id);
    }
}
