package Guia1;

import Guia1.Ej6.Circulo;
import Guia1.Ej6.Rectangulo;

public class Ejercicio6 {
	
	public static void main(String[] args) {
		new Ejercicio6();
	}
	
	
	public Ejercicio6()
	{
		Circulo c1=new Circulo("Circulo 1", 3);
		System.out.println("La figura llamada "+c1.getNombre()+" tiene una superficie de "+
		c1.superficie()+ " y un perimetro de "+c1.perimetro());
		Rectangulo r1=new Rectangulo("Rectangulo 1", 4, 5);
		
		System.out.println("La figura llamada "+r1.getNombre()+" tiene una superficie de "+
				r1.superficie()+ " y un perimetro de "+r1.perimetro());
	}

}
