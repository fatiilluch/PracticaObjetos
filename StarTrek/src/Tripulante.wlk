import Sistema.*
import Nave.*
import Dispositivo.*

class Tripulante
{
	var property sistemaCapacitado = null
	var property estaAsignado = false
	var property edad
	var property nave
	
	method estaCapacitado() = self.sistemaCapacitado() != null
	
	method estasAsignado() = self.estaAsignado()
	
	method cualEsTuSistema() = self.sistemaCapacitado()
	
	method dejaLaNave() 
	{
		self.estaAsignado(false)
	}
	//Cada tripulante es capacitado por uno o varios fabricantes de sistemas; en principio está capacitado para operar únicamente los sistemas hechos por los fabricantes que lo han capacitado
	
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
