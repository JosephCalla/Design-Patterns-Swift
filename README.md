# Design-Patterns-Swift

**Factory Method**

Factory Method is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created.

```Swift
// Factory Method - Creational
protocol Payment {
    func doPayment()
}

class GooglePayment: Payment {
    func doPayment() {
        print("Haciendo el pago con GOOGLE PAYMENT")
    }
}

class CardPayment: Payment {
    func doPayment() {
        print("Haciendo el pago con Tarjeta de Crédito")
    }
}

enum TypePayment {
    case GOOGLE
    case CARD
}

class PaymentFactory {
    static func buildPayment(typePayment: TypePayment) -> Payment {
        switch typePayment {
        case .GOOGLE:
            return GooglePayment()
            
        case .CARD:
            return CardPayment()
        }
    }
}

// Show Result ->
func testFactoryMethod() {
    var payment: Payment
    payment = PaymentFactory.buildPayment(typePayment: .GOOGLE)
    payment.doPayment()
}

testFactoryMethod()
```
