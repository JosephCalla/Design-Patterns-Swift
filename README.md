# Design-Patterns-Swift

| Structural patterns | Behavioral patterns | Creational patterns |
|-----|-----------|-----------|
| Adapter | Chain of Responsibility | Factory Method |
| Decorator| Command | Builder | 
| Bridge | Iterator | Singleton|
| Composite | Mediator | Abstract Factory |
| Facate | Memento | Prototype |
| Proxy | Observer |  |
| Flyweight | State |  |
|  | Strategy |  |
|  | Template Method |  |
|  | Visitor |  |


## Structural Patterns
**Factory Method**

Factory Method is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created.

![image](https://user-images.githubusercontent.com/35270796/203591484-14edf28c-6a7b-43b9-a8e5-ab1f7a89fcb5.png)

**Example**

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

## Creational Patterns

**Builder Pattern**

Builder is a creational design pattern that lets you construct complex objects step by step. The pattern allows you to produce different types and representations of an object using the same construction code.

![Screenshot 2022-11-24 at 00 09 42](https://user-images.githubusercontent.com/35270796/203699202-5465266d-0553-4b00-b17c-e881cb032409.png)

**Example**
```Swift
class Card {
    private var cardType: String = ""
    private var number: String = ""
    private var expired: Int = 0
    
    func showCard() {
        print("Tarjeta \(cardType) - \(number) - \(expired)")
    }
    
    class CardBuilder {
        private var innerCard = Card()
        
        func cartType(cardType: String) -> CardBuilder {
            innerCard.cardType = cardType
            return self
        }
        
        func number(number: String) -> CardBuilder {
            innerCard.number = number
            return self
        }
        
        func expires(expires: Int) -> CardBuilder {
            innerCard.expired = expires
            return self
        }
        
        func build() -> Card {
            return innerCard
        }
    }
}

// Test
func testBuilder() {
    var card: Card = Card.CardBuilder()
        .cartType(cardType: "VISA")
        .build()
    card.showCard()
}

testBuilder()

```


