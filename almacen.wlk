import cosas.*
import camion.*


object almacen {
    const property cosas = #{} 

    method cosasParaAlmacenar(cosasDelCamion) {
        cosas.addAll(cosasDelCamion)
    }
}