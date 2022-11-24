//: [Previous](@previous)

import Foundation

class CardSingleton {
    static var shared = CardSingleton() // Singleton
    
    private init(){} // Important!
    
    func doSomething() {
        print("Haciendo trabajo de la clase Singleton")
    }
}


func testSingleton() {
    let instancia1 = CardSingleton.shared
    let instancia1 = CardSingleton.shared
    
    // Just for testing to verify that they're have only one instance
    if instancia2 == instancia1 {
        print("La instancia1 es la misma que la 2")
    }
}
//: [Next](@next)
