// Minions
class Empleado
{
	var property rol 
	var property estamina
	const property tareas = []
	const property herramientasPropias = #{}
	
	method agregaTarea(nuevaTarea)
	{
		self.tareas().add(nuevaTarea)
	}
	
	method hacerTarea() = self.tareas().forEach({tarea => tarea.hacerTarea(self)})
	
	method esMucama() = true
	
	method fuerza() =  self.estamina()/2 + 2
	
	method reduciEstamina() 
	{
		self.rol().reduciEstamina(self)
	}
	
	method come(fruta)
	{
		self.recuperaEstamina(fruta.puntos())
	} 
	
	method recuperaEstamina(nuevaEstamina)
	{
		self.estamina(self.estamina() + nuevaEstamina)
	}
	
	method experiencia() = self.cantidadDeTareasRealizadas() * self.sumarDificultades()
	
	method sumarDificultades() = self.tareas().sum({tarea => tarea.dificultad(self)})
	
	method cantidadDeTareasRealizadas() = self.tareas().size()	
}

object banana
{
	method puntos() = 10
}

object manzana
{
	method puntos() = 5 
}

object uva
{
	method puntos() = 1.1
}

class ArreglarMaquina
{
	var property maquina 
	method hacerTarea(empleado) 
	{
		empleado.estamina(-maquina.complejidad())
		return empleado.estamina() >= maquina.complejidad() && self.tieneLasHerramientas(empleado)	
	}

	method tieneLasHerramientas(empleado) = maquina.herramientasParaArreglarla().all({herramienta => empleado.herramientasPropias().contains(herramienta)})
	
	method dificultad(empleado) = 2 * maquina.complejidad()
}

class Maquina
{
	var property complejidad
	const property herramientasParaArreglarla = #{}
}

class DefenderSector
{
	var property amenaza
	
	method hacerTarea(empleado)
	{
		if(empleado.defender(self).negate() && empleado.fuerza() < self.amenaza().gradoDeAmenaza())
		{
			throw new ExcepcionPorNoPoderDefender("El empleado no debe ser mucama y la fuerza debe ser igual o mayor al grado de amenaza")
		}
		empleado.reduciEstamina()
	}
	
	method dificultad(empleado) = empleado.multiplicadorDeAmenaza() * self.amenaza().gradoDeAmenaza()
}

class Amenaza
{
	var property gradoDeAmenaza
}

class ExcepcionPorNoPoderDefender inherits Exception {}

class LimpiarSector
{
	var property sectorALimpiar
	var property nivelDificultad
	
	method hacerTarea(empleado) 
	{
		if(self.puedeSerLlevadaACabo(empleado))
		{
			self.hacerQuePierdaEstamina(empleado)	
		}
	}
	
	method puedeSerLlevadaACabo(empleado) = self.sectorALimpiar().estamina() < empleado.estamina()
	
	method hacerQuePierdaEstamina(empleado) 
	{
		if(empleado.rol() != "mucama")
		{
			empleado.estamina(empleado.estamina() - self.sectorALimpiar().estamina())			
		}
	}	
	method dificultad(empleado) = self.nivelDificultad()
}

//Para limpiar se requiere tener al menos 4 puntos de estamina si el sector es grande y 1 en cualquier otro caso 
object sectorGrande {
	method estamina() = 4
}

object otroSector {
	method estamina() = 1 
}

class Biclope inherits Empleado
{
	const property ojos = 2
	
	override method estamina() = super().min(10)
	
	method multiplicadorDeAmenaza() = 1
}

class Ciclope inherits Empleado
{
	const property ojos = 1
	 
	method acertar(disparos) = disparos / 2
	
	override method fuerza() = super() + self.rol().fuerza()
	
	method multiplicadorDeAmenaza() = 2
}

class Soldado
{
	var property danioDelArma
	var property practica
	
	method usaArma(sector) 
	{
		self.practica(self.practica() + 1 )
		self.danioDelArma(2)
	}
	method defender(sector) = true
	
	method fuerza() = self.practica()
	
	method reduciEstamina(empleado) {}
	//Si por algún motivo el soldado cambia de rol, toda la práctica ganada se pierde.
}

class Obrero
{
	var property cinturon = []
	
	method agregaHerramientas(unaHerramienta) 
	{
		self.cinturon().add(unaHerramienta)
	}
	method defender(sector) = true
	
	method fuerza() = 0
	
	method reduciEstamina(empleado)
	{
		empleado.estamina(empleado.estamina() - empleado.estamina()/2)
	}
}

class Mucama
{
	method defender(sector) = false
	
	method fuerza() = 0
	
	method reduciEstamina(empleado)
	{
		empleado.estamina(empleado.estamina() - empleado.estamina()/2)
	}
}

class Capataz
{
	method fuerza() = 0
	method defender(sector) = true
}





