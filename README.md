# Design-Patterns-Swift

Builder Method

```
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
