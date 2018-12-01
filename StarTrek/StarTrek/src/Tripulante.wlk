import Sistema.*
import Nave.*
import Dispositivo.*

class Tripulante
{
	var property edad
	var property nave
	var property sistemaAsignado
		
	method cualEsTuSistema() = self.sistemaAsignado()
	
	method estaAsignado() = 
		self.sistemaAsignado() != null
	 	
	method dejaLaNave() 
	{
		self.nuevoSistemaAsignado(null)
	}
	
	method nuevoSistemaAsignado(nuevoSistema)
	{
		self.sistemaAsignado(nuevoSistema)
	}
	
	method estaCapacitado(sistema) = sistema.tripulantes().contains(self)
}


class Capitan inherits Tripulante
{
	var property teSacrificas
	var property nivelMinimoRobustezNave
	
	override method dejaLaNave()
	{
		if(self.consideroQueRequiereDeAccionHeroica(nave))
		{
			nave.cambiaCapitan(null)
		}
	} 	
	
	method consideroQueRequiereDeAccionHeroica(nave) = self.teSacrificas() && nave.nivelDeRobustez() < 5
}
