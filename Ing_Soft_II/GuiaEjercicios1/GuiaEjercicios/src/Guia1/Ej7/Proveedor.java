package Guia1.Ej7;

public class Proveedor extends Persona{
	
	

	private String telefono;

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	
	public Proveedor(int edad, String nombre, String apellido,String telefono) {
		super(edad, nombre, apellido);
		this.telefono=telefono;
	}

}
