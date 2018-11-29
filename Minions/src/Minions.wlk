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
	
	method reduciEstamina() 
	{
		self.rol().reduciEstamina(self)
	} 
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
	var property arma
	var property practica
	
	method usaArma(sector) 
	{
		self.practica(self.practica() + 1 )
		self.arma().danioCausante(2)
	}
	method soyMucama() = false
	
	method fuerza() = self.practica()
	
	method reduciEstamina(empleado) {}
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
	
	method fuerza() = 0
	
	method reduciEstamina(empleado)
	{
		empleado.estamina(-empleado.estamina()/2)
	}
}

class Mucama
{
	method defender(sector) = false
	
	method soyMucama() = true
	
	method fuerza() = 0
	
	method reduciEstamina(empleado)
	{
		empleado.estamina(-empleado.estamina()/2)
	}
}




