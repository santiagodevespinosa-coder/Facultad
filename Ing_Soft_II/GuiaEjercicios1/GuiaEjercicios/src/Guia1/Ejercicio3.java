package Guia1;
import java.util.Scanner;

public class Ejercicio3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new Ejercicio3();
	}

	
	public Ejercicio3()
	{
		int numero;
		System.out.println("Ingrese un numero");
		Scanner sc=new Scanner(System.in);
		
		numero=sc.nextInt();
		
		System.out.println("Sobre el numero ingresado "+numero+ "su doble es: "+
		numero*2 +" y su triple es: "+numero*3);
		sc.close();
	}
}
