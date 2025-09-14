import java.util.Scanner;

class SalaryException extends RuntimeException {
    SalaryException(String message) {
        super(message);
    }
}

public class A3
{
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.print("Enter Salary: ");
		int salary = sc.nextInt();
		
		if (salary < 2100) {
		    throw new SalaryException("you need to work hard");
		} else if (salary < 5000) {
		    throw new SalaryException("your salary is somehow good");
		} else if (salary >= 5100 && salary <= 9000) {
		    throw new SalaryException("salary is very good");
		}
	}
}
