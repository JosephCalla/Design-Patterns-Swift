//: [Previous](@previous)

import Foundation

protocol CrediCardVisitor {
    func gassolineOffer(gassolineOffer: GasolinaOffer)
    func flightOffer(flightOffer: FlightsOffer)
}

protocol OffertElement {
    func accept(visitor: CrediCardVisitor)
}

class GasolinaOffer: OffertElement {
    func accept(visitor: CrediCardVisitor) {
        visitor.gassolineOffer(gassolineOffer: self)
    }
}

class FlightsOffer: OffertElement {
    func accept(visitor: CrediCardVisitor) {
        visitor.flightOffer(flightOffer: self)
    }
}

class ClassicCreditCardVisitor: CrediCardVisitor {
    func gassolineOffer(gassolineOffer: GasolinaOffer) {
        print("Descuento 3% en Gasolina con tu tarjeta clasica")
    }
    
    func flightOffer(flightOffer: FlightsOffer) {
        print("Descuento 5% en vuelos con tu tarjeta clasica")
    }
}


class BlackCreditCardVisitor: CrediCardVisitor {
    func gassolineOffer(gassolineOffer: GasolinaOffer) {
        print("Descuento 10% en Gasolina con tu tarjeta Black")
    }
    
    func flightOffer(flightOffer: FlightsOffer) {
        print("Descuento 25% en Vuelos con tu tarjeta Black")
    }
}


// TEST
func testVisitor() {
    let oferta = GasolinaOffer()
    oferta.accept(visitor: BlackCreditCardVisitor())
}

testVisitor()

// Print
// Descuento 10% en Gasolina con tu tarjeta Black

//: [Next](@next)
