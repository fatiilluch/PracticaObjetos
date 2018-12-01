import Sistema.*
import Tripulante.*
import Dispositivo.*

class Nave
{
	var property nivelDeEscudos = 100
	const property cantDeDispositivosMax = 100
	const property sistemas = []
	const property tripulantes = []
	const property maniobrasEvasivas = []
	const property dispositivos = []
	var property capitan 
	
	// 1 a.	Saber el conjunto de sistemas de una nave que no está funcionando.
	method conjuntoDeSistemasNoFuncionando() = self.sistemas().filter({sistema => sistema.estaFuncionando().negate()})
	
	// 1 b.	Obtener el conjunto de los tripulantes más viejos para cada sistema de una nave (el más viejo de los de refrigeración, el más viejo de los de navegación, etc.).	
	method tripulantesMasViejos() = self.sistemas().filter({sistema => sistema.elMasViejo()})

	// 1 c.	Saber el nivel de robustez que tiene una nave estelar; que es la suma de los indicadores detallados arriba dividido tres
	method nivelDeRobustez() = (self.nivelDeEscudos() + self.cantidadDispositivosDisponibles() + self.porcentajeSistemasFuncionando())/ 3
	
	method cantidadDispositivosDisponibles() = self.dispositivos().size()   
	
	method porcentajeSistemasFuncionando() = self.cantidadDeSistemasFuncionando() / self.cantTotalSistemas() * 100
	
	method cantTotalSistemas() = self.sistemas().size()
	
	method cantidadDeSistemasFuncionando() = self.sistemas().filter({sistema => sistema.estaFuncionando()}).size()
	
	// 1 d.	Saber si una nave es holgazana, o sea, hay más tripulantes desasignados que tripulantes asignados a un sistema.
	method sosHolgazana() = self.tripulantesDesasignados() > self.tripulantesTotales()/2
	
	method tripulantesDesasignados() = self.tripulantes().filter({tripulante => tripulante.estasAsignado().negate()})
	
	method tripulantesTotales() = self.tripulantes().size()
	
	// 1 e.	Saber si una nave está bien organizada, o sea, todos sus sistemas están funcionando, y no hay ningún tripulante asignado a un sistema que no está capacitado para operar.
	method estasOrganizada() = self.todosTusSistemasFuncionan()
	
	method todosTusSistemasFuncionan() = self.sistemas().all({sistema => sistema.estaFuncionando()})
	
	// 2 a.	Poder evacuar una nave, evacuar consiste en disparar la alerta de evacuación lo cual implica que todos los tripulantes dejan la nave. 
	method evacua() 
	{
		self.tripulantes().forEach({tripulante => tripulante.dejaLaNave(self)})
		self.vaciaTripulantes()
	}
	
	method vaciaTripulantes() 
	{
		self.tripulantes().removeAll()
	}
	
	method cambiaCapitan(unCapitan) 
	{
		capitan = unCapitan
	}
	
	// 2 b.	Modelar la incorporación de un conjunto de tripulantes a una nave; se destina a cada uno a un sistema que no esté funcionando y para el que el tripulante esté capacitado. Los tripulantes que se incorporan y que no pueden ser asignados a ningún sistema según lo descripto, quedan desasignados.
	method incorporaTripulantes(muchosTripulantes)
	{
		self.agregaTripulantes(muchosTripulantes)
		self.noEstaAsignadoAAlgunSistema().forEach({tripulante => tripulante.cualEsTuSistema().agregaTripulante(tripulante)})
	}	
	
	method agregaTripulantes(muchosTripulantes) 
	{
		self.tripulantes().addAll(muchosTripulantes)
	}
	
	method noEstaAsignadoAAlgunSistema() = self.tripulantes().filter({tripulante => tripulante.estaAsignado().negate()})
	
	// 3 b.	Saber si una nave estelar puede evadir un dispositivo de ataque.
	method evadi(ataque) = self.maniobrasEvasivas().any({maniobras => maniobras.esquiva(ataque)})
	
	// 4 a. 
	method registraDanio()
	{
		if (self.nivelDeRobustez() < self.capitan().nivelMinimoRobustezNave())
			self.evacua()
	}
	
	// 4 b. recibir impacto 
	method recibi(impacto)
	{
		self. reduciEscudos(impacto)
		if (self.nivelDeEscudos() < 20) 
			self.registraDanio()
	}

	method reduciEscudos(nuevoEscudo)
	{
		self.nivelDeEscudos(self.nivelDeEscudos() - nuevoEscudo)
	}
	
	// 5
	method ataca(algo, ataque)
	{
		algo.sosAtacadoPor(self)
		self.removeDispositivo(ataque)
	}
	
	method elMejorAtaque() = self.dispositivos().max({dispositivo => dispositivo.danioCausante()})
	
	method removeDispositivo(ataque) 
	{
		self.dispositivos().remove(ataque)
	}
	
	method sosAtacadoPor(nave, ataque)
	{
		if(nave.evade(self.elMejorAtaque()).negate())
		{
			nave.recibi(ataque.danioCausante()/15)
		}
	}
}

class ManiobraEvasiva
{
	var property nivelDeEfectividad
	var property fabricante = []
	
	// a.	Saber si una maniobra evasiva puede esquivar un dispositivo de ataque determinado. 	
	method esquivar(ataque) = (ataque.puntosTactica() < self.nivelDeEfectividad()) && self.fabricante().contains(ataque.fabricante())
}

class Ciudad
{
	var property poblacion
	
	method sosAtacadoPor(nave, ataque)
	{
		self.disminuiPoblacion(200 * ataque.danioCausante())
	}
	
	method disminuiPoblacion(nuevaPoblacion)
	{
		self.poblacion(self.poblacion() - nuevaPoblacion)
	}
}
 
