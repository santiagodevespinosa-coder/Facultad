package Guia1;
import java.util.Scanner;

public class Ejercicio1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new Ejercicio1();
	}
	
	
	public Ejercicio1()
	{
		int num1,num2;
		Scanner sc=new Scanner(System.in);
		
		System.out.println("Ingrese el primer numero");
		num1=sc.nextInt();
		System.out.println("Ingrese el segundo numero");
		num2=sc.nextInt();
		
		System.out.println("Usted ingresó los numeros "+num1 +" y "+num2);
		sc.close();
	}

}
