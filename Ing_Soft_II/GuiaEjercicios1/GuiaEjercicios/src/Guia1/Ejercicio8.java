package Guia1;

import java.util.ArrayList;
import java.util.Scanner;

import Guia1.Ej8.Coche;

public class Ejercicio8 {
	
	ArrayList<Coche>lista;
	Scanner sc;
	
	public static void main(String[] args) {
		new Ejercicio8();
	}
	
	public Ejercicio8()
	{
		lista=new ArrayList<Coche>();
		sc=new Scanner(System.in);
		int op;
		do
		{
			System.out.println("Ingrese una opcion:");
			System.out.println("1 - Agregar coche");
			System.out.println("2 - Listar coches");
			System.out.println("3 - Listar coches por marca");
			System.out.println("4 - Listar coches menores a kilometros");
			System.out.println("5 - Mostrar coche con mas kilometros");
			System.out.println("6 - Ordenar listado por kilometros");
			System.out.println("0 - Salir");
			op=Integer.parseInt(sc.nextLine());
			switch(op)
			{
			case 1:
				agregarCoche();
				break;
			case 2:
				listarCoches();
				break;
			case 3:
				listarCochesMarca();
				break;
			case 4:
				listarCochesKilometros();
				break;
			case 5:
				mostrarMayorKilometros();
				break;
			case 6:
				ordenarListado();
				break;
			case 0:
				break;
				default:
					System.out.println("Opcion incorrecta");
					break;
				
			}
		}while(op!=0);
	}
	
	public void agregarCoche()
	{
		String marca;
		int modelo;
		int kilometros;
		System.out.print("Ingrese la marca del coche: ");
		marca=sc.nextLine();
		System.out.print("Ingrese el modelo del coche(Año de fabricacion): ");
		modelo=Integer.parseInt(sc.nextLine());
		System.out.print("Ingrese los kilometros: ");
		kilometros=Integer.parseInt(sc.nextLine());
		Coche c1=new Coche(marca, kilometros, modelo);
		lista.add(c1);
	}
	
	public void listarCoches()
	{
		for(Coche c:lista)
		{
			System.out.println(c);
		}
	}
	
	public void listarCochesMarca()
	{
		String marca;
		System.out.println("Ingrese una marca para buscar");
		marca=sc.nextLine();
		for(Coche c:lista)
		{
			if(c.getMarca().equals(marca))
				System.out.println(c);
		}
	}
	
	public void listarCochesKilometros()
	{
		int km;
		System.out.println("Ingrese kilometros para buscar");
		km=Integer.parseInt(sc.nextLine());
		for(Coche c:lista)
		{
			if(c.getKilometros()<km)
				System.out.println(c);
		}
	}
	
	public void mostrarMayorKilometros()
	{
		Coche c1=lista.get(0);
		for(Coche c:lista)
		{
			if(c.getKilometros()>c1.getKilometros())
				c1=c;
		}
		System.out.println("El coche con mayor cantidad de kilometros es: "+c1);
	}
	
	public void ordenarListado()
	{
		lista.sort(null);
		for(Coche c:lista)
		{
			System.out.println(c);
		}
	}
	
	

}
