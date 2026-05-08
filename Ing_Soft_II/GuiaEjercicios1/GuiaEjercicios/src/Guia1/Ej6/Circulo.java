package Guia1.Ej6;

public class Circulo extends Figura implements IFigura{

	private int radio;
	
	
	public int getRadio() {
		return radio;
	}

	public void setRadio(int radio) {
		this.radio = radio;
	}

	public Circulo(String nombre,int radio) {
		super(nombre);
		this.radio=radio;
	}

	@Override
	public float perimetro() {
		return 2*3.14f*radio;
	}

	@Override
	public float superficie() {
		return 3.14f*radio*radio;
	}

}
