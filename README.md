# Design-Patterns-Swift

| Structural patterns | Behavioral patterns | Creational patterns |
|-----|-----------|-----------|
| Adapter | Chain of Responsibility | 🚧 Factory Method |
| Decorator| Command | 👷‍ Builder | 
| Bridge | Iterator | 🧘 Singleton|
| Composite | Mediator | Abstract Factory |
| Facate | Memento | Prototype |
| Proxy | Observer |  |
| Flyweight | State |  |
|  | Strategy |  |
|  | Template Method |  |
|  | Visitor |  |


# Creational Patterns
## 🚧 Factory Method

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
**Advantage of Factory Method Pattern**

- 🟢 You avoid tight coupling between the creator and the concrete products.
- 🟢 Single Responsibility Principle. You can move the product creation code into one place in the program, making the code easier to support.
- 🟢 Open/Closed Principle. You can introduce new types of products into the program without breaking existing client code.

**Disadvantages of Factory Method Pattern**
- 🔴 The code may become more complicated since you need to introduce a lot of new subclasses to implement the pattern. The best case scenario is when you’re introducing the pattern into an existing hierarchy of creator classes.
 
## 👷‍♂️ Builder Pattern

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

**Advantage of Builder Pattern**

- 🟢 You can construct objects step-by-step, defer construction steps or run steps recursively.
- 🟢 You can reuse the same construction code when building various representations of products.
- 🟢 Single Responsibility Principle. You can isolate complex construction code from the business logic of the product.

**Disadvantages of Builder Pattern**
- 🔴 The overall complexity of the code increases since the pattern requires creating multiple new classes.


## 🧘 Singleton Pattern

Singleton is a creational design pattern that lets you ensure that a class has only one instance, while providing a global access point to this instance.

![image](https://user-images.githubusercontent.com/35270796/203810419-b2303c49-7660-4ada-8034-d5038c40109d.png)


```Swift
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
```

**Advantage of Singleton Pattern**
- 🟢 You can be sure that a class has only a single instance.
- 🟢 You gain a global access point to that instance.
- 🟢 The singleton object is initialized only when it’s requested for the first time.

**Disadvantages of Singleton Pattern**
- 🔴 Violates the Single Responsibility Principle. The pattern solves two problems at the time.
- 🔴 The Singleton pattern can mask bad design, for instance, when the components of the program know too much about each other.
- 🔴 The pattern requires special treatment in a multithreaded environment so that multiple threads won’t create a singleton object several times.
- 🔴 It may be difficult to unit test the client code of the Singleton because many test frameworks rely on inheritance when producing mock objects. Since the constructor of the singleton class is private and overriding static methods is impossible in most languages, you will need to think of a creative way to mock the singleton. Or just don’t write the tests. Or don’t use the Singleton pattern.
