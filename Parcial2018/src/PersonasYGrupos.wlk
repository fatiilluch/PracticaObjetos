import Eventos.*
import PropuestaYCatalogo.*

class Grupo
{
	const property personas = #{}
	
	method queFelizTeHaceLaPropuesta(propuesta) = self.personas().sum({persona => persona.felicidad(propuesta)})
	
	method agregaPersona(persona) {self.personas().add(persona)}
	
	method sosPequenio() = self.personas().size() < 5
	
	method cantidadDePersonasQuePuedenAprender() = self.personasQuePuedenAprender().size()
	
	method personasQuePuedenAprender() = self.personas().filter({persona => self.lePuedeEnseniarA(persona)})
	
	method lePuedeEnseniarA(persona) = self.personas().any({educador => educador.leEnsenia(persona)})
	
	method asisteA(evento) = self.personas().forEach({persona => persona.asisteA(evento)})
} 

class Persona
{
	const property temas = []
	
	const property eventosAsistidos = #{}
	
	var property personalidad
	
	method felicidad(propuesta) = personalidad.felicidad(propuesta)
	
	method sabes(tema) = self.temas().contains(tema)
	
	method noSabes(tema) = self.sabes(tema).negate()
	
	method leEnsenia(persona) = self.temas().any({tema => persona.noSabes(tema)})
	
	method agregaEvento(evento) { self.eventosAsistidos().add(evento)}
	
	method yaAsististe(evento) = self.eventosAsistidos().contains(evento)
	
	method asisteA(evento)
	{
		if (self.yaAsististe(evento))
		{
			throw new ExcepcionPorYaHaberAsistido("Ya asististe, no podes volver a ir")
		}
		self.agregaEvento(evento)
	}	
}

class ExcepcionPorYaHaberAsistido inherits Exception {}

object introvertido
{
	method felicidad(propuesta) = propuesta.conocimiento().min(propuesta.interaccion())
}

object extrovertido
{
	method felicidad(propuesta) = 
		if (self.teSatisfaceLa(propuesta).negate())
			0
		else
			2 * propuesta.interaccion()
			
	method teSatisfaceLa(propuesta) = propuesta.interaccion() > 5
}