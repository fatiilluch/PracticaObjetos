import Eventos.*
import PersonasYGrupos.*

class Propuesta
{
	const property conocimiento = 0
	const property interaccion = 0
	
	method *(multiplicador) = new Propuesta
		(
			conocimiento =  self.conocimiento() * multiplicador,
			interaccion = self.interaccion() * multiplicador
		)
	
	method +(unaPropuesta) = new Propuesta 
		(
			conocimiento = self.conocimiento() + unaPropuesta.conocimiento(),
			interaccion = self.interaccion() + unaPropuesta.interaccion()
		)  					
}

class Catalogo
{
	const property eventos = #{}
	
	method mejorEventoPara(grupo) = self.eventos().max({evento => evento.felicidadPara(grupo)})
}
