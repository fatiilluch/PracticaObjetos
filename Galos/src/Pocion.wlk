import Persona.*
import Legion.*
import Ejercito.*

class Pocion 
{
	const property ingredientes = []
	
	method agregaIngrediente(unIngrediente)
	{
		self.ingredientes().add(unIngrediente)
	}
	
	method removeIngrediente(unIngrediente)
	{
		self.ingredientes().remove(unIngrediente)
	}
	
	method afectaA(unaPersona)
	{
		self.ingredientes().forEach({ingrediente => ingrediente.afectaA(unaPersona)})
	}
	
	method cantidadDeIngredientes() = self.ingredientes().size()
}

// Dulce de leche: aumenta la fuerza en 10 unidades. 
// Si la persona estaba fuera de combate, la revive con 2 puntos de resistencia.
class DulceDeLeche
{
	method afectaA(persona, pocion)
	{
		persona.aumentaTuFuerza(10)
		if (persona.estasMuerto())
			persona.revivi()
	}	
}

// - Puñado de hongos silvestres: aumenta la fuerza en tantas unidades como 
// hongos haya en el puñado. Si son más de 5 además le disminuye a la mitad la resistencia.
class HongosSilvestres
{
	var property hongos
	
	method afectaA(persona, pocion)
	{	
		persona.aumentaTuFuerza(self.hongos())
		if(self.hongos() > 5)
		{
			persona.disminuiResistencia(0.5 * persona.resistencia())
		}
	}
}

// - Grog: vuelve a quien la ingiera tantas veces más fuerte como ingredientes tenga la poción.
class Grog
{
	method afectaA(persona, pocion)
	{
		persona.aumentaFuerza(pocion.cantidadDeIngredientes())
	}
}

//- Grog XD: mismo efecto que el Grog pero además duplica la resistencia
class GrogXD inherits Grog
{
	override method afectaA(persona, pocion)
	{
		super(persona, pocion)
		persona.multiplicaResistencia(2) 
	}	
}


