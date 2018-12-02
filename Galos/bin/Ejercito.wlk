import Persona.*
import Pocion.*
import Legion.*

class Ejercito 
{
	const property integrantes = []
	
	method agregaIntegrante(nuevoIntegrante) { self.integrantes().add(nuevoIntegrante) }
	
	method removeIntegrante(chauIntegrante) { self.integrantes().remove(chauIntegrante)} 
	
	method integrantesQueNoEstanFueraDeCombate() = self.integrantes().filter({integrante => integrante.estasFueraDeCombate().negate()})
	
	method poder() = self.integrantesQueNoEstanFueraDeCombate().sum({integrante => integrante.poder()})
	
	method recibi(danio)
	{
		self.losQueVanAdelante().forEach({integrante => integrante.recibi(danio/10)})
	}
	
	method losQueVanAdelante() = self.integrantes().sortBy({integrante => integrante.poder()}).take(10)
	
	method peleaContra(enemigo)
	{
		if (self.todosTusIntegrantesEstanFueraDeCombate())
		{
			throw new ExcepcionPorNoPoderLuchar ("No se puede luchar si no tenes ningun integrante en pie!")
		}
		self.elMenosPoderoso().recibiDanio(enemigo)
	}
	
	method todosTusIntegrantesEstanFueraDeCombate() = self.integrantes().all({integrante => integrante.todosTusIntegrantesEstanFueraDeCombate()})
	
	method recibiDanio(enemigo)
	{
		self.recibi(enemigo.poder() - self.poder())
	}
	
	method elMenosPoderoso() = self.integrantes().sortBy({integrante => integrante.poder()}).take(integrantes.last()) 
}

class ExcepcionPorNoPoderLuchar inherits Exception {}
