//: [Previous](@previous)

import Foundation

protocol CreditModule {
    func showCredit()
}

class BlackModule: CreditModule {
    func showCredit() {
        print("La tarjeta Black tiene un credito de un 1.000.000")
    }
}

class GoldModule: CreditModule {
    func showCredit() {
        print("La tarjeta Gold tiene un credito de 50.000")
    }
}

class SilverModule: CreditModule {
    func showCredit() {
        print("La tarjeta Silver tiene un credito de 50.000")
    }
}

class CreditMarketFacade {
    var black = BlackModule()
    var gold = GoldModule()
    var silver = SilverModule()
    
    func showCreditBlack() {
        black.showCredit()
    }
    
    func showCreditGold() {
        gold.showCredit()
    }
    
    func showCreditSilver() {
        silver.showCredit()
    }
    
}

/// Test
func testFacade() {
    let facate = CreditMarketFacade()
    facate.showCreditBlack()
    facate.showCreditGold()
    facate.showCreditSilver()
}

testFacade()
//: [Next](@next)
