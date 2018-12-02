import Persona.*
import Ejercito.*
import Pocion.*

class Legion inherits Ejercito 
{
	var property formacion = enCuadro
	var property minimo
	
	override method poder() = self.formacion().poder(super()) 
	
	override method recibi(danio)
	{
		self.formacion().recibi(danio, self)
		if (self.poder() < self.minimo())
			self.formacion(tortuga)
	} 
	
	method repartiALaMitad(danio)
	{
		self.integrantes().take(self.integrantes().size().div(2)).forEach({integrante => integrante.recibi(danio * 2)})
	}
}

object tortuga
{
	method poder(poder) = 0
	
	method recibi(danio, legion) {} 
}

object enCuadro
{
	method poder(poder) = poder
	
	method recibi(danio, legion) 
	{
		legion.reparti(danio)
	}
}

object frotem
{
	method poder(poder) = poder * 1.1
	
	method recibi(danio, legion)
	{
		legion.repartiALaMitad(danio)
	}
}



