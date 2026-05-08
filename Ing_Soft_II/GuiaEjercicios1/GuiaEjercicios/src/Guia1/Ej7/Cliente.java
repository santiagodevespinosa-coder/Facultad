package Guia1.Ej7;

public class Cliente extends Persona{
	
	

	private String direccion;

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	
	public Cliente(int edad, String nombre, String apellido,String direccion) {
		super(edad, nombre, apellido);
		this.direccion=direccion;
	}
}
