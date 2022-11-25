# Design-Patterns-Swift

| Structural patterns | Behavioral patterns | Creational patterns |
|-----|-----------|-----------|
| Adapter | Chain of Responsibility | 🚧 Factory Method |
| Decorator| Command | 👷‍ Builder | 
| Bridge | Iterator | 🧘 Singleton|
| Composite | Mediator | Abstract Factory |
| Facate | Memento | Prototype |
| Proxy | 🧐 Observer |  |
| Flyweight | State |  |
|  | Strategy |  |
|  | Template Method |  |
|  | Visitor |  |

# SOLID
- **S** - Single responsability principle
- **O** - Open/Closed principle
- **L** - Liskov substitution principle
- **I** - Interface segregation principle
- **D** - Dependency inversion principle

## Single responsability principle
A class should have one responsability.

```Swift
class Car {
	var licensePlate: String
	init(licensePlate: String) { self.licensePlate = licensePlate }
}
class CarBD {
	func saveCarDB(car: Car) {}
	func deleteCarDB(car: Car) {}
}
```

## Open/Closed
Software entities, including classes, modules and functions, should be open for extension but closed for modification.

This means you should be able to expand the capabilities of your types without having to alter them drastically to add what you need.

**Examples 1**

```Swift 
import UIKit

protocol LoginServiceProtocol {
    func login(completion: @escaping (Bool) -> Void)
}

class LoginService: LoginServiceProtocol {
    func login(completion: @escaping (Bool) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://any-url.com/")!) { data, response, error in
            if let _ = error {
                completion(false)
            } else {
                //logic
                completion(true)
            }
        }.resume ()
    }
}

class LoginFacebookService: LoginServiceProtocol {
    func login(completion: @escaping (Bool) -> Void) {
        // SDK Facebook
	completion(true)
    }
}
```
**Examples 2**

❌ BAD
```Swift 
class Car {
    var brand: String
    init(brand: String) { self.brand = brand }
}
var cars: [Car] = [
    Car(brand: "Ford"),
    Car(brand: "Chevrolet")
] 
func printCarsPrice(_ cars: [Car]) {
    for car in cars {
        if car.brand == "Ford" { print(2000)  } // 2000
        if car.brand == "Chevrolet" { print(3200)  } // 3000
    }
}
printCarsPrice(cars)
```
Why is that code is ❌ Bad ?

Because this does not follow the open-closed principle, since if we wanted to add a new car:
```Swift
var cars: [Car] = [
	Car(brand: "Ford"),
   	Car(brand: "Chevrolet"),
   	Car(brand: "Jeep")   	    
]	 
```

We would also have to modify the method we created previously:
```Swift
func printCarsPrice(_ cars: [Car]) {
    for car in cars {
        if car.brand == "Ford" { print(2000)  } // 2000
        if car.brand == "Chevrolet" { print(3200)  } // 3000
        if car.brand == "Jeep" { print(1450)  } // 1450
    }
}
```

✅ GOOD
```Swift
protocol Car { func price()-> Int }

class Ford: Car {
    func price()-> Int { return 2000 }
}
class Chevrolet: Car {
    func price()-> Int { return 3000 }
}
class Jeep: Car {
    func price()-> Int { return 1450 }
}
var cars: [Car] = [
    Chevrolet(),
    Ford(),
    Jeep()
] 

func printCarsPrice(_ cars: [Car]) {
    for car in cars {
        print(car.price())
    }
}

printCarsPrice(cars)
```
## Liskov Substitution

Establishes that a class that inherits from another can be used as its parent without needing to know the differences between them.

In other words, if you replace one object with another that’s a subclass and this replacement could break the affected part, then you’re not following this principle.


```Swift
protocol UserDataBaseManagerProtocol {
  func saveUser(user: User)
}

class UserDataBaseManager: UserDataBaseManagerProtocol {
  func saveUser(user: User) {
  	// Save user on DB
  }
}
```
## Interface segregation
Clients should not be forced to depend upon interfaces they do not use.

When designing a protocol you’ll use in different places in your code, it’s best to break that protocol into multiple smaller pieces where each piece has a specific role. That way, clients depend only on the part of the protocol they need.

Take for **example** this struct 
``` Swift
protocol Bird {
    func eat() 
    func fly() 
}

class Pigeon: Bird {
    func eat() {}
    func fly() {}
}
class Parrot: Bird  {
    func eat() {}
    func fly() {}
}
```

⚠️ Well, but now i want to add a new Penguien class. As you know, they're birds but it can swimming also.

```Swift
protocol Bird {
    func eat() 
    func fly() 
    func swim() 
}

class Pigeon: Bird {
    func eat() {}
    func fly() {}
    func swim() {}
}
class Parrot: Bird  {
    func eat() {}
    func fly() {}
    func swim() {}
}
class Penguin: Bird  {
    func eat() {}
    func fly() {}
    func swim() {}
}
```

The problem is that dove 🕊️  can't swimming and pingüino 🐧 can't fly. The solution would be se Interface segregation. ✅

```Swift
protocol Bird {
    func eat()  
}

protocol FlyingBird {
    func fly() 
}
protocol SwimmingBird {
    func swim() 
}

class Pigeon: Bird, FlyingBird  {
    func eat() {}
    func fly() {}
}
class Penguin: Bird, SwimmingBird {
    func eat() {}
    func swim() {}
}

```
## Dependency inversion
Depend upon abstractions, not concretions.

Different parts of your code should not depend on concrete classes. They don’t need that knowledge. This encourages the use of protocols instead of using concrete classes to connect parts of your app.



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

# Behavioral patterns
## 🧐 Observer Pattern
Observer is a behavioral design pattern that allows some objects to notify other objects about changes in their state.

The Observer pattern provides a way to subscribe and unsubscribe to and from these events for any object that implements a subscriber interface.

![Screenshot 2022-11-24 at 10 15 25](https://user-images.githubusercontent.com/35270796/203817619-7d0dd8be-7d69-410d-9262-f1f88e622367.png)
- Subject: 
- Observer: 
- ConcreteObserver:
- NotifyObservers:
```Swift

struct TrafficLight {
    var status: String
}

/// Observer: Es la interfaz que define las operaciones que se utilizan para notificar al "Subject"
protocol Observer {
    func update(traffictLight: TrafficLight)
}


protocol Subject {
    func addObserver(o: Observer)
    func deleteObserver(o: Observer)
    func notifyUpdate(trafficLight: TrafficLight)
}


class MessagePublisher: Subject {
    var observers = [Observer]()
    func addObserver(o: Observer) {
        observers.append(o)
    }
    
    func deleteObserver(o: Observer) {
        if let index = observers.firstIndex(where: { $0 as AnyObject === o as AnyObject}) {
            observers.remove(at: index)
        }
    }
    
    func notifyUpdate(trafficLight: TrafficLight) {
        observers.forEach { $0.update(traffictLight: trafficLight) }
    }
}

/// ConcreteObserverA
class  Car: Observer {
    func update(traffictLight: TrafficLight) {
        if traffictLight.status as AnyObject === "CAR_RED" as AnyObject {
            print("Semaforo coche Rojo -> Coche NO puede pasar")
        } else {
            print("Semaforo coche Verde -> Coche SI puede pasar")
        }
    }
}


/// ConcreteObserverB
class Pedestrian: Observer {
    func update(traffictLight: TrafficLight) {
        if traffictLight.status as AnyObject === "CAR_RED" as AnyObject {
            print("Semaforo peaton Verde -> PEATON SI puede pasar")
        } else {
            print("Semaforo peaton Rojo -> PEATON NO puede pasar")
        }
    }
}


// TEST
func testObserver() {
    let car = Car()
    let pedestrian = Pedestrian()
    var trafficLight = TrafficLight(status: "CAR_GREEN")
    let messagePublisher = MessagePublisher()
    
    messagePublisher.addObserver(o: car)
    messagePublisher.addObserver(o: pedestrian)
    messagePublisher.notifyUpdate(trafficLight: trafficLight)
    sleep(2)
    print("After sleep")
    TrafficLight(status: "CARD_RED")
    messagePublisher.notifyUpdate(trafficLight: trafficLight)
}

testObserver()
```

**Advantage of Observer Pattern**
- 🟢 Open/Closed Principle. You can introduce new subscriber classes without having to change the publisher’s code (and vice versa if there’s a publisher interface).
- 🟢 You can establish relations between objects at runtime.

**Disadvantages of Observer Patter**
- 🔴 Subscribers are notified in random order.

# Structural patterns
## Adapter


