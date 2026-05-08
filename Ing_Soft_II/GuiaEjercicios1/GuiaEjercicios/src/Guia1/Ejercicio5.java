package Guia1;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Ejercicio5 {
	
	
	List<Integer>lista;
	
	public static void main(String[] args) {
		new Ejercicio5();
	}
	
	/*public Ejercicio5()
	{
		Random aleatorio = new Random(System.currentTimeMillis());
		lista=new ArrayList<Integer>();
		
		for(int i=0;i<50;i++)
		{
			lista.add((int) (Math.random() * 100) + 1);
			lista.add(aleatorio.nextInt(100));
		}*/
	
		/*public Ejercicio5()
		{
			//Random aleatorio = new Random(System.currentTimeMillis());
			lista=new ArrayList<Integer>();
			
			for(int i=0;i<50;i++)
			{
				int numero=(int) (Math.random() * 100) + 1;
				if(lista.stream().filter(n->n.equals(numero)).findFirst().isEmpty())
				{
					lista.add(numero);
			}
		}*/
			
			public Ejercicio5()
			{
				//Random aleatorio = new Random(System.currentTimeMillis());
				lista=new ArrayList<Integer>();
				
				for(int i=0;i<50;i++)
				{
					int numero=(int) (Math.random() * 100) + 1;
					if(!lista.contains(numero))
					{
						lista.add(numero);
				}
			}
				
			for(Integer i:lista)
			{
				System.out.println(i);
			}
	}

}
