package Guia1.Ej8;

public class Coche implements Comparable<Coche>{
	
	private String marca;
	private int kilometros;
	private int modelo;
	public String getMarca() {
		return marca;
	}
	public void setMarca(String marca) {
		this.marca = marca;
	}
	public int getKilometros() {
		return kilometros;
	}
	public void setKilometros(int kilometros) {
		this.kilometros = kilometros;
	}
	public int getModelo() {
		return modelo;
	}
	public void setModelo(int modelo) {
		this.modelo = modelo;
	}
	public Coche(String marca, int kilometros, int modelo) {
		super();
		this.marca = marca;
		this.kilometros = kilometros;
		this.modelo = modelo;
	}
	@Override
	public String toString() {
		
		return "Marca: "+this.marca+" - Modelo: "+this.modelo+" - Kilometros: "+this.kilometros;
	}
	@Override
	public int compareTo(Coche o) {
		if(this.getKilometros()<o.getKilometros())
			return -1;
		if(this.getKilometros()>o.getKilometros())
			return 1;
		return 0;
	}
	
	

}
