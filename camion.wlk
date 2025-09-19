import cosas.*
import almacen.*

object camion {
	const property cosas = #{}
		
	method cargar(unaCosa) {
		self.verificarCarga(unaCosa)
		cosas.add(unaCosa)
	}

	method verificarCarga(unaCosa){
		if (cosas.contains(unaCosa)){
			self.error("No se puede cargar algo que ya contiene el camion")
		}
	}
	method vaciarCamion() {
		cosas.forEach({cosaEnCamion => self.descargar(cosaEnCamion) })
	}

	method descargar(unaCosa) {
		self.verificarDescarga(unaCosa)
		cosas.remove(unaCosa)
	}


	method verificarDescarga(unaCosa){
		if (! cosas.contains(unaCosa)){
			self.error("No se puede descargar algo que no contiene el camion")
		}
	} 

	method todoPesoEsPar() = self.cosas().all({carga => self.esPar(carga.peso())}) 
	method esPar(_peso) {
		return _peso % 2 == 0

	} 
	method existeAlgoQuePesa(_peso){
		return cosas.any({cosa => self.pesoDeEsIgualA(cosa, _peso)})
	}
	method pesoDeEsIgualA(unaCosa, unPeso){
		return unaCosa.peso() == unPeso
	}

	method pesoTotal() = 1000 + cosas.sum({cosa => cosa.peso()})
	method tieneExcesoDePeso() = self.pesoTotal() > 2500  

	method encontrarAlgoConNivelPeligrosidad(unNivelDePeligrosidad){
		return cosas.find({cosa =>  self.nivelPeligrosidadEsIgualA(cosa, unNivelDePeligrosidad)})
	}
	method nivelPeligrosidadEsIgualA(unaCosa, unNP) = unaCosa.nivelPeligrosidad() == unNP

	method cosasCargadasDeMasNPQueOtra(otraCosa) = self.cosasCargadasDeMasNPQue(otraCosa.nivelPeligrosidad())
	method cosasCargadasDeMasNPQue(unNP) = cosas.filter {cosa => self.nivelPeligrosidadDeEsMayorA(cosa, unNP)} 
	method nivelPeligrosidadDeEsMayorA(unaCosa, unNP) =  unaCosa.nivelPeligrosidad() > unNP

	method puedeCircularEnRuta(nivelRuta) = ! self.tieneExcesoDePeso() && self.cosasCargadasDeMasNPQue(nivelRuta) == #{}

	method existeAlgoQuePesaEntreYEntre(unPeso, otroPeso) = cosas.any({cosa => self.pesaEntreYEntre(cosa, unPeso, otroPeso)})
	method pesaEntreYEntre(unaCosa, unPeso, otroPeso) = unaCosa.peso().between(unPeso, otroPeso)  

	method cosaMasPesada() = cosas.find{cosa => self.pesoDeEsIgualA(cosa, self.pesoCosaMasPesada())}
	method pesoCosaMasPesada() = cosas.map({cosa => cosa.peso()}).max() 

	method pesoDeTodasLasCosas() = cosas.map({cosa => cosa.peso()})

	method cantidadTotalDeBultos() = cosas.sum({cosa => cosa.bultos()}) 
	
	method ocurreAccidente() {cosas.forEach({cosa => cosa.accidente()})}

	method transportar(destino, camino) {
		if (camino.verificarSiPuedeTransportar(self)){
			destino.cosasParaAlmacenar(cosas)
			self.vaciarCamion()
		}
	}
}

