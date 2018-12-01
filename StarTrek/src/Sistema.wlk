import Nave.*
import Tripulante.*
import Dispositivo.*

class Sistema
{
	const property tripulantes = []
	var property fabricante
	var property cantMinTripulantes
	
	method estaFuncionando() = self.tripulantes().size() >= self.cantMinTripulantes()   
	
	method estanTodosLosTripCapacitados() = self.tripulantes().all({tripulante => tripulante.estaCapacitado()})
	
	method agregaTripulante(tripulante) 
	{
		self.tripulantes().add(tripulante)
	}
	
	method elMasViejo() = self.tripulantes().max({tripulante => tripulante.edad()})
}

