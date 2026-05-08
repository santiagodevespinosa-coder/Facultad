package Guia1.Ej6;

public class Rectangulo extends Figura implements IFigura{
	
	
	private int base;
	private int altura;
	
	public Rectangulo(String nombre,int base,int altura) {
		super(nombre);
		this.altura=altura;
		this.base=base;
	}
	
	public int getBase() {
		return base;
	}
	public void setBase(int base) {
		this.base = base;
	}
	public int getAltura() {
		return altura;
	}
	public void setAltura(int altura) {
		this.altura = altura;
	}

	@Override
	public float perimetro() {
		return base*2+base*2;
	}

	@Override
	public float superficie() {
		return base*altura;
	}

}
