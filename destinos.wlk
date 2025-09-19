import camion.*


object ruta9 {
    method verificarSiPuedeTransportar(_camion) {
        return _camion.puedeCircularEnRuta(20)
    }
}
object caminosVecinales {
    var pesoMaximoPermitido = 1500

    method modificarPesoMaximoPermitido(_peso) { pesoMaximoPermitido = _peso} 
    method verificarSiPuedeTransportar(_camion) {
        return _camion.pesoTotal() <= pesoMaximoPermitido 
    }
}