package Guia1;
import java.util.ArrayList;
import java.util.Scanner;

public class Ejercicio4 {
	
	public static void main(String[] args) {
		new Ejercicio4();
	}
	
	public Ejercicio4()
	{
		int total=0;
		ArrayList<Integer>lista=new ArrayList<Integer>();
		System.out.println("Ingrese 10 numeros");
		Scanner sc=new Scanner(System.in);
		for(int i=0;i<10;i++)
		{
			System.out.println("Ingrese el numero "+(i+1));
			int numero=sc.nextInt();
			lista.add(numero);
			total+=numero;
		}
		
		System.out.println("El promedio de los valores ingresados es "+(total/10f));
		total=0;
		int cantidad=0;
		for(Integer i:lista)
		{
			if(i%2==0)
			{
				total+=i;
				cantidad++;
			}
		}
		System.out.println("El promedio de los valores pares es "+((float)total/cantidad));
		
		total=0;
		cantidad=0;
		for(Integer i:lista)
		{
			if(i%2!=0)
			{
				total+=i;
				cantidad++;
			}
		}
		
		System.out.println("El promedio de los valores impares es "+((float)total/cantidad));
		sc.close();
	}

}
