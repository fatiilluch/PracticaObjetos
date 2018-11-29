// Minions
class Empleado
{
	var property rol 
	var property estamina
	const property tareas = []
	const property herramientasPropias = #{}
	
	method hacerTarea() = self.tareas().forEach({tarea => tarea.hacerTarea(self)})
	
	method esMucama() = self.rol().soyMucama()
	
	method fuerza() =  self.estamina()/2 + 2 
	
	method sosSoldado() = self.rol().sosSoldado()
}

class ArreglarMaquina
{
	var property maquina 
	method hacerTarea(empleado) 
	{
		empleado.estamina(-maquina.complejidad())
		return empleado.estamina() == maquina.complejidad() && self.tieneLasHerramientas(empleado)	
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
		if(empleado.esMucama() && empleado.fuerza() < self.amenaza().gradoDeAmenaza())
		{
			throw new ExcepcionPorNoPoderDefender("El empleado no debe ser mucama y la fuerza debe ser igual o mayor al grado de amenaza")
		}
		if(empleado.sosSoldado().negate())
		{
			empleado.estamina(-empleado.estamina()/2)
		}
	}
	
	method dificultad(empleado) =  
		if (empleado.sosBiclope())
			return self.amenaza().gradoDeAmenaza() 
		else
			return 2 * self.amenaza().gradoDeAmenaza()	
}
class Amenaza
{
	var property gradoDeAmenaza
}

class ExcepcionPorNoPoderDefender inherits Exception {}

class LimpiarSector
{
	
}


class Biclope inherits Empleado
{
	const property ojos = 2
	
	override method estamina() = super().min(10)
	
	method sosBiclope() = true
}

class Ciclope inherits Empleado
{
	const property ojos = 1
	 
	method acertar(disparos) = disparos / 2
	
	override method fuerza() = super() + self.rol().fuerza()
	
	method sosBiclope() = false
}

class Soldado
{
	var property arma
	var property practica
	
	method usaArma(sector) 
	{
		self.practica(self.practica() + 1 )
		self.arma().danioCausante(2)
	}
	method soyMucama() = false
	method soySoldado() = true
	
	method fuerza() = self.practica()
	//Si por algún motivo el soldado cambia de rol, toda la práctica ganada se pierde.
}

class Arma
{
	var property danioCausante
}

class Obrero
{
	var property cinturon = []
	
	method agregaHerramientas(unaHerramienta) 
	{
		self.cinturon().add(unaHerramienta)
	}
	
	method soyMucama() = false
	method soySoldado() = false
	
	method fuerza() = 0
}

class Mucama
{
	method defender(sector) = false
	
	method soyMucama() = true
	method soySoldado() = false
	
	method fuerza() = 0
}



