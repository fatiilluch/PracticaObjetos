import Sistema.*
import Nave.*
import Tripulante.*

class Dispositivo
{
	const property fabricante
	var property peso
	var property puntosTactica
}

// a.	Torpedos de fotones, son uno de los ataques más poderosos. El daño que causa un torpedo es igual a la cantidad de fotones vivos que contiene. 
// Los puntos de tácticas de persecución se obtienen multiplicando el peso del torpedo por el ángulo máximo de desvío instantáneo (un valor medido en grados de circunsferencia que varía de un torpedo de fotones a otro)
class TorpedoDeFotones inherits Dispositivo
{
	var property fotones
	var property anguloDesvio
	
	method danioCausante() = self.fotones()
	
	override method puntosTactica() = self.peso() * self.anguloDesvio() 
}

// b.	Torpedos de neutrinos, sus puntos de tácticas de persecución se obtienen sumando la adaptabilidad al medio más un plus que es el resultado de la programación individual de cada torpedo. 
// Son el arma más avanzada y poderosa con la que puedan llegar a contar las naves estelares, su nivel de daño resulta de multiplicar su peso quince veces y sumar el daño mínimo que es un valor común a todos los torpedos de neutrinos.
class TorpedoDeNeutrinos inherits Dispositivo
{
	var property adaptabilidadAlMedio 
	var property programacionIndividual
	var property danioMinimo
	
	override method puntosTactica() = self.adaptabilidadAlMedio() + self.programacionIndividual()
	
	method danioCausante() = self.peso() * 15 + self.danioMinimo()	
}

// c.	Faisers no tienen tácticas de persecución por el momento, 
//quizás en un par de años luz cambie. El daño que irradian es constante en 230 puntos.
class Faisers inherits Dispositivo
{
	override method puntosTactica() = 0
	
	method danioCausante() = 230
}

//Cuando se usa un dispositivo de ataque se consume; p.ej. si en un momento una nave 
//cuenta con dos 2 torpedos de fotones que irradian un daño de 100 y 500 puntos respectivamente, 
//si dispara el de 500 solamente le quedará el de 100.
