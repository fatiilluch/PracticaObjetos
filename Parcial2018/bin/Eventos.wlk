import PersonasYGrupos.*
import PropuestaYCatalogo.*

class Evento
{	  
	method felicidadPara(grupo) = grupo.queFelizTeHaceLaPropuesta(self.propuestaPara(grupo))
	
	method propuestaPara(grupo)
}

class Museo inherits Evento
{
	var property tenesDinosaurios = false
	
	method propuesta() = new Propuesta(conocimiento = 5, interaccion = 10)  
	
	override method propuestaPara(grupo) = (self.propuesta() + self.esPequenio(grupo)) * self.siTenesDinosaurios()
		
		method esPequenio(grupo) = 
			if (grupo.sosPequenio())
				new Propuesta(conocimiento = 5, interaccion = 0)
			else
				new Propuesta()

	method siTenesDinosaurios() = 
		if (self.tenesDinosaurios())
			2 
		else 
			1	
}

class Recital inherits Evento
{	
	method propuesta() = new Propuesta(conocimiento = 0, interaccion = 10)  
	
	override method propuestaPara(grupo) = self.propuesta()
}

class Rock inherits Recital
{
	override method propuestaPara(grupo) = super(grupo) * 3 
}

class Reggaeton inherits Recital
{
	override method propuestaPara(grupo) = super(grupo) * (-1)
}

class Reunion inherits Evento
{
	override method propuestaPara(grupo) = new Propuesta(conocimiento = grupo.cantidadDePersonasQuePuedenAprender(), interaccion = 20)  
}

class Maraton inherits Evento
{
	const property eventos = #{}
	
	override method propuestaPara(grupo) = self.eventos().sum({evento => evento.propuestaPara(grupo)})
}

class Viaje inherits Maraton
{
	var property diasDeViaje
	
  	override method propuestaPara(grupo) = super(grupo) + new Propuesta(conocimiento = 0, interaccion = 10 * self.diasDeViaje())
}