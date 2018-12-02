import Pocion.*
import Ejercito.*
import Legion.*

class Persona
{
	var property fuerza
	var property resistencia
	const property pocion = []
	
	// 1 a. Conocer el poder de una persona, que se calcula como el producto entre su fuerza y su resistencia
	method poder() = self.fuerza() * self.resistencia()  
	
	// 1 b. Hacer que una persona reciba una cantidad de daño, disminuyendo su resistencia en esa cantidad. El mínimo de resistencia que puede tener una persona es 0, quedando fuera de combate
	method recibi(danio)
	{
		self.disminuiResistencia(danio)
	}
	
	method disminuiResistencia(unaResistencia)
	{
		self.resistencia((self.resistencia() - unaResistencia).max(0))
	}
	
	method aumentaResistencia(unaResistencia)
	{
		self.resistencia(self.resistencia() + unaResistencia)
	}
	method estasFueraDeCombate() = self.resistencia() == 0	
	
	method aumentaTuFuerza(fuerzaAumentar)
	{
		self.fuerza(self.fuerza() + fuerzaAumentar)
	}
	
	method revivi()
	{
		self.aumentaResistencia(2)
	}
	
	method toma() = self.pocion().forEach({pocionn => pocionn.afectaA(self)}) 
		
	method multiplicaResistencia(multiplicador)
	{
		self.resistencia(self.resistencia() * multiplicador)
	} 
}
