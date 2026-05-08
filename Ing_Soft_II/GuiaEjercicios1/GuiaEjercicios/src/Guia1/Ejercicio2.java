package Guia1;
import java.util.Scanner;

public class Ejercicio2 {
	
	public static void main(String[] args) {
		new Ejercicio2();
	}
	
	public Ejercicio2()
	{
		String nombre;
		Scanner sc=new Scanner(System.in);
		
		System.out.println("Ingrese su nombre");
		nombre=sc.nextLine();
		System.out.println("Buenos dias "+nombre);
		
		sc.close();
	}

}
