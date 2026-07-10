import java.lang.*;

public interface exam {

    void percent_cal();
}

class Student{

String name;
int rno,mark1,mark2;

Student(String n, int r,int m1,int m2){

    name=n; rno=r;mark1=m1;mark2=m2;
}

void display()
{
System.out.println("------student details-------------" );
System.out.println("name of the student "+ name);
System.out.println("regno "+rno);
System.out.println("mark 1 "+mark1);
System.out.println("mark 2 "+mark2);
}

public static void main(String[] args) {
    Result R=new Result("MR.SK",23,90,98);
    R.display();
    R.percent_cal();
}
}


class Result extends Student implements exam{

    Result(String n, int r,int m1,int m2){

    super(n,r,m1,m2);
    }

    public void percent_cal(){
        int total =(mark1 + mark2);
        float percent=(total*100)/200;
        System.err.println("percentage "+percent+"%");


    }
void display(){

super.display();  

}

}



