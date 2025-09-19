object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bultos() = 1 
	method accidente() {
	}
}

object arenaAGranel {
	var peso = 10 

	method bultos() = 1 
	method nivelPeligrosidad() { return 1}
	method cambiarPeso(_peso) {
		peso = _peso 
	}
	method peso() { return peso }
	method accidente() {self.cambiarPeso(peso + 20)}
}

object bumblebee{
	var esAuto = true

	method esAuto() = esAuto
	method modificarSiEsAuto(_bool) {
		esAuto = _bool
	}
	method nivelPeligrosidad() {
		if (esAuto){
			return 15
		}
		else { //asume que está convertido en robot
			return 30 
		}
	}

	method bultos() = 2
	method peso() { return 800}
	method accidente() {
		if (esAuto){self.modificarSiEsAuto(false)}
		else{self.modificarSiEsAuto(true)}
	}
}

object paqueteDeLadrillos {
	var cantidadDeLadrillos = 20

	method cantidadDeLadrillos() = cantidadDeLadrillos
	method peso() { return (cantidadDeLadrillos * 2)}
	method modificarCantidadDeLadrillos(_cantidad) {
		cantidadDeLadrillos = _cantidad
	}
	method bultos() {
		if (cantidadDeLadrillos.between(1, 100)){return 1}
			else{if (cantidadDeLadrillos.between(101, 300)){return 2}
					else{return 3}
			}
	} 
	method nivelPeligrosidad(){
		return 2
	}
	method accidente() {
		if(cantidadDeLadrillos > 12){ self.modificarCantidadDeLadrillos(cantidadDeLadrillos - 12)}
		else{ self.modificarCantidadDeLadrillos(0)}
	}
}

object bateriaAntiAerea {
	var llevaMisiles = true

	method llevaMisiles() = llevaMisiles 
	method modificarSiLlevaMisiles(_bool) {
		llevaMisiles = _bool
	}
	method peso() {
		if (llevaMisiles){return 300 } 
		else {return 200}
	} 
	method nivelPeligrosidad() {
		if (llevaMisiles){return 100}
		else{return 0}
	}
	method bultos() {
		if (llevaMisiles){return 2}
		else {return 1}
	} 
	method accidente(){
		if(llevaMisiles){self.modificarSiLlevaMisiles(false)}
	}
}

object residuosRadioactivos {
	var peso = 100

	method bultos() = 1
	method modificarPeso(_peso){
		peso = _peso
	}

	method peso() { return peso}

	method nivelPeligrosidad() { return 200}
	method accidente() {self.modificarPeso(peso + 15)}
}

object contenedorPortuario {
	const property cosas = #{}
	method peso() =  100 + cosas.sum({cosa => cosa.peso()}) 
	method nivelPeligrosidad() {       
		const listaDePeligrosidad =  self.cosas().map({cosa => cosa.nivelPeligrosidad()})
		return listaDePeligrosidad.maxIfEmpty({0})
	}
	method cargar(unaCosa) {
		self.verificarCarga(unaCosa)
		cosas.add(unaCosa)
	}

	method verificarCarga(unaCosa){
		if (cosas.contains(unaCosa)){
			self.error("No se puede cargar algo que ya contiene el contenedor")
		}
	}
	method vaciarContenedor() {
		cosas.forEach({cosaEnContenedor => self.descargar(cosaEnContenedor) })
	}

	method descargar(unaCosa) {
		self.verificarDescarga(unaCosa)
		cosas.remove(unaCosa)
	}
	method bultos() = 1 + cosas.sum({cosa => cosa.bultos()}) 

	method verificarDescarga(unaCosa){
		if (! cosas.contains(unaCosa)){
			self.error("No se puede descargar algo que no contiene el contenedor")
		}
	} 
	
    method accidente() {cosas.forEach({cosaEnContenedor => cosaEnContenedor.accidente()})}
	}	


object embalajeDeSeguridad {
	var property cosa = knightRider
	method nivelPeligrosidad() = cosa.nivelPeligrosidad() / 2
	method peso() =	cosa.peso()   
	method bultos() = 2
	method accidente() {}
}


