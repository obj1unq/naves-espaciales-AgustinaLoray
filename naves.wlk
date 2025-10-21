class Nave {
	var property velocidad = 0
	
	method recibirAmenaza() {}

	method propulsar() {
		if (velocidad + 20000 < 300000)
			{velocidad += 20000}
		else {velocidad = 300000 }
	}

	method prepararParaViajar() {
		if (velocidad +15000 < 300000)
			{velocidad += 15000}
		else {velocidad = 300000}
	}

	method meEncontreConUnEnemigo() {
	  self.recibirAmenaza()
	  self.propulsar()
	}


}

class NaveDeCarga inherits Nave{
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	
	override method recibirAmenaza() {
		carga = 0
	}

}

class NaveCargaResiduosRadioactivos inherits NaveDeCarga {

	var  property sellado = false 

	method sellarAlVacio() {
		sellado = true
	}

	override method recibirAmenaza() {
		if (sellado)
			{velocidad = 0}
		else {carga = 0}
	}

	override method prepararParaViajar() {
		super() //se ejecuta el codigo de nave 
		self.sellarAlVacio() //se ejecuta lo que corresponde con la nave de residuos radioactivos
	}
  
}

class NaveDePasajeros inherits Nave{
	
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave{
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method prepararParaViajar() {
		super()
		if (modo == ataque)
			{self.emitirMensaje("Volviendo a la base")}
		else {self.emitirMensaje("Saliendo en mision")
				modo = ataque}
	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

}
