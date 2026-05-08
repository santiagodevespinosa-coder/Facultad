package Guia1;

import Guia1.Ej7.Cliente;
import Guia1.Ej7.Proveedor;

public class Ejercicio7 {
	
	public static void main(String[] args) {
		new Ejercicio7();
	}
	
	public Ejercicio7()
	{
		Cliente c1=new Cliente(25,"Juan","Perez","Casa 1234");
		Proveedor p1=new Proveedor(38, "Carlos", "Gomez", "Puerto 456");
		System.out.println("La persona de mayor edad es: ");
		if(c1.getEdad()>p1.getEdad())
		{
			System.out.println(c1.getApellido()+" "+c1.getNombre());
		}
		else
		{
			System.out.println(p1.getApellido()+" "+p1.getNombre());
		}
	}

}
