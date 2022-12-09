//: [Previous](@previous)

import Foundation

protocol StrategyTextFormatter {
    func format(text: String)
}

class CapitalStategyTextFormatter: StrategyTextFormatter {
    func format(text: String) {
        print("Texto en Mayusculas: \(text.uppercased())")
    }
}

class LowerStategyTextFormatter: StrategyTextFormatter {
    func format(text: String) {
        print("Texto en Minusculas: \(text.lowercased())")
    }
}

class Context {
    var strategyTextFormatter: StrategyTextFormatter
    
    init(strategyTextFormatter: StrategyTextFormatter) {
        self.strategyTextFormatter = strategyTextFormatter
    }
    
    func publishText(text: String) {
        strategyTextFormatter.format(text: text)
    }
}

// TEST
func testStrategy() {
    let contextCapital = Context(strategyTextFormatter: CapitalStategyTextFormatter())
    contextCapital.publishText(text: "este texto sera convertido a Mayusculas a traves de nuestro algoritmo")
    
    let contextLower = Context(strategyTextFormatter: LowerStategyTextFormatter())
    contextLower.publishText(text: "este texto sera convertido a Minusculas a traves de nuestro algoritmo")
}

testStrategy()

// RESULT
///Texto en Mayusculas: ESTE TEXTO SERA CONVERTIDO A MAYUSCULAS A TRAVES DE NUESTRO ALGORITMO
///Texto en Minusculas: este texto sera convertido a minusculas a traves de nuestro algoritmo

//: [Next](@next)
