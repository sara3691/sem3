public class JavaBean {
public static void main(String[] args) {
PersonBean person = new PersonBean();
person.setName("Mr.V");
person.setAge(21);
person.setAddress("SALEM ");
System.out.println("Name: " + person.getName());
System.out.println("Age: " + person.getAge());
System.out.println("Address: " + person.getAddress());
}
}