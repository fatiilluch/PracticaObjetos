class Nave
{
	var property nivelDeEstado
	const property cantDePMax
	var property capitan
	
	method cantidadDisponible() {}
	
	method porcentajeSistemasFuncionando() {}
	
	method esHolgazana(){}
	
	method estaOrganizada(){}
	
	method evacuar(){}
	
	method nivelDeRobustez() {}
	
	method evadir(ataque) {}
	
	method incorporarTripulantes(){}	
}

class Tripulante
{
	var property sistemaCapacitado
	var property estaAsignado
	
	method estaCapacitado(){}
	
	method estasAsignado(){}
	
	method cualEsTuSistema(){}
}

class Capitan inherits Tripulante
{
	var property teSacrificas	
}

class ManiobraEvasiva
{
	var property nivelDeEfectividad
	
	method esquivar(ataque){}
}

class Sistema
{
	const property tripulantes
	var property fabricante
	var property cantMinTripulantes
	
	method estaFuncionando(){}
	
	method estanTodosLosTripCapacitados() {}
	
	method agregaTripulante() {}
}

class Dispositivo
{
	var property fabricante
	var property peso
	var property puntosTactica
}


class TorpedoDeFotones inherits Dispositivo
{
	
}

class TorpedoDeNeutrinos inherits Dispositivo
{
	
}
class Faisers inherits Dispositivo
{
	
}
