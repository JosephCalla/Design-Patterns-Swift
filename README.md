# Design-Patterns-Swift

| Structural patterns | Behavioral patterns | Creational patterns |
|-----|-----------|-----------|
| ✌️ [Adapter](https://github.com/JosephCalla/Design-Patterns-Swift#%EF%B8%8F-adapter-pattern) | Chain of Responsibility | 🚧 [Factory Method](https://github.com/JosephCalla/Design-Patterns-Swift#-factory-method) |
| Decorator| Command | 👷‍ [Builder](https://github.com/JosephCalla/Design-Patterns-Swift#%EF%B8%8F-builder-pattern) | 
| Bridge | Iterator | 🧘 [Singleton](https://github.com/JosephCalla/Design-Patterns-Swift#-singleton-pattern) |
| Composite | Mediator | Abstract Factory |
| 🪟 [Facade](https://github.com/JosephCalla/Design-Patterns-Swift#-facade) | Memento | Prototype |
| 👮‍♀️ [Proxy](https://github.com/JosephCalla/Design-Patterns-Swift#%EF%B8%8F-proxy-pattern) | 🧐 [Observer](https://github.com/JosephCalla/Design-Patterns-Swift#-observer-pattern) |  |
| Flyweight | State |  |
|  | Strategy |  |
|  | Template Method |  |
|  | [Visitor](https://github.com/JosephCalla/Design-Patterns-Swift#visitor-pattern)|  |

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

Is this class obserblable?

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

🔙 [Back To Menu](https://github.com/JosephCalla/Design-Patterns-Swift#design-patterns-swift)

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

🔙 [Back To Menu](https://github.com/JosephCalla/Design-Patterns-Swift#design-patterns-swift)


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

🔙 [Back To Menu](https://github.com/JosephCalla/Design-Patterns-Swift#design-patterns-swift)

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


🔙 [Back To Menu](https://github.com/JosephCalla/Design-Patterns-Swift#design-patterns-swift)


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

🔙 [Back To Menu](https://github.com/JosephCalla/Design-Patterns-Swift#design-patterns-swift)

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

🔙 [Back To Menu](https://github.com/JosephCalla/Design-Patterns-Swift#design-patterns-swift)

##  Visitor Pattern
Visitor is a behavioral design pattern that lets you separate algorithms from the objects on which they operate.

The Visitor pattern suggests that you place the new behavior into a separate class called visitor, instead of trying to integrate it into existing classes. The original object that had to perform the behavior is now passed to one of the visitor’s methods as an argument, providing the method access to all necessary data contained within the object.

![Screenshot 2022-12-02 at 09 58 43](https://user-images.githubusercontent.com/35270796/205321779-09ebc79d-5ea4-430a-93ad-b31fd4f5c4cb.png)

```Swift
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
```

🔙 [Back To Menu](https://github.com/JosephCalla/Design-Patterns-Swift#design-patterns-swift)


# Structural patterns
## ✌️ Adapter Pattern
Objetivo: 2 interfaces no relacionadas puedan trabajar juntas sin ningun tipo de problema.

![Screenshot 2022-11-26 at 19 26 34](https://user-images.githubusercontent.com/35270796/204113926-72659bc5-079f-4654-8293-802a7c1f0ff5.png)

```Swift
protocol OperationTarget {
    var getSum: String {get}
}

class OperationAdaptee {
    var a: Int
    var b: Int
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
    }
    
    func sum() -> Int {
        return a + b
    }
}

class OperationAdapter: OperationTarget {
    let adaptee: OperationAdaptee
    
    init(adaptee: OperationAdaptee) {
        self.adaptee  = adaptee
    }
    var getSum: String {
        return String(self.adaptee.sum())
    }
}

// Test
func testAdapter() {
    let adaptee = OperationAdaptee(a: 3, b: 4)
    if (adaptee.sum() == 7) {
        print("Ok int")
    }
    
    let target = OperationAdapter(adaptee: adaptee)
    if target.getSum == "7" {
        print("Ok String")
    }
    print(target.getSum)
}

testAdapter()
```

**Advantage of Adapter Pattern**
- 🟢 Single Responsibility Principle. You can separate the interface or data conversion code from the primary business logic of the program.
- 🟢 Open/Closed Principle. You can introduce new types of adapters into the program without breaking the existing client code, as long as they work with the adapters through the client interface.

**Disadvantages of Adapter Patter**
- 🔴 The overall complexity of the code increases because you need to introduce a set of new interfaces and classes. Sometimes it’s simpler just to change the service class so that it matches the rest of your code.

🔙 [Back To Menu](https://github.com/JosephCalla/Design-Patterns-Swift#design-patterns-swift)

## 🪟 Facade
Facade is a structural design pattern that provides a simplified interface to a library, a framework, or any other complex set of classes.

**Problem**

Imagine that you must make your code work with a broad set of objects that belong to a sophisticated library or framework. Ordinarily, you’d need to initialize all of those objects, keep track of dependencies, execute methods in the correct order, and so on.

As a result, the business logic of your classes would become tightly coupled to the implementation details of 3rd-party classes, making it hard to comprehend and maintain

**Solution**

A facade is a class that provides a simple interface to a complex subsystem which contains lots of moving parts. A facade might provide limited functionality in comparison to working with the subsystem directly. However, it includes only those features that clients really care about.

Having a facade is handy when you need to integrate your app with a sophisticated library that has dozens of features, but you just need a tiny bit of its functionality.

For instance, an app that uploads short funny videos with cats to social media could potentially use a professional video conversion library. However, all that it really needs is a class with the single method encode(filename, format). After creating such a class and connecting it with the video conversion library, you’ll have your first facade.

![Screenshot 2022-11-28 at 05 52 33](https://user-images.githubusercontent.com/35270796/204260017-bf49c825-7a3c-4dad-930f-d7155d644ead.png)

```Swift
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
    let facade = CreditMarketFacade()
    facade.showCreditBlack()
    facade.showCreditGold()
    facade.showCreditSilver()
}

testFacade()
```

🔙 [Back To Menu](https://github.com/JosephCalla/Design-Patterns-Swift#design-patterns-swift)

## 👮‍♀️ Proxy pattern
Un proxy controla el acceso al objeto original, lo que le permite realizar algo antes o después de que la solicitud llegue al objeto original.

**¿cuál es el beneficio?** Si necesita ejecutar algo antes o después de la lógica principal de la clase, el proxy le permite hacerlo sin cambiar esa clase. Dado que el proxy implementa la misma interfaz que la clase original, se puede pasar a cualquier cliente que espere un objeto de servicio real.

Por lo tanto, las llamadas al objeto acaban ocurriendo indirectamente a traves del objeto proxy es el que actua como sustitu del objeto original, delegando las llamadas a los metodos de los objetos

La **clase Proxy** tiene un campo de referencia que apunta a un objeto de servicio(clase a controlar). Una vez que el proxy finaliza su procesamiento (p. ej., inicialización diferida, registro, control de acceso, almacenamiento en caché, etc.), pasa la solicitud al objeto de servicio.

Por lo general, los proxies administran el ciclo de vida completo de sus objetos de servicio.

**💡 Formas de utilizar el patrón Proxy**

🐞 Inicialización diferida (**proxy virtual**). Esto es cuando tiene un objeto de servicio pesado que desperdicia recursos del sistema al estar siempre activo, aunque solo lo necesite de vez en cuando.

⚡️ En lugar de crear el objeto cuando se inicia la aplicación, puede retrasar la inicialización del objeto hasta el momento en que realmente se necesite.


🐞 Control de acceso (**proxy de protección**). Aquí es cuando desea que solo los clientes específicos puedan usar el objeto de servicio; por ejemplo, cuando sus objetos son partes cruciales de un sistema operativo y los clientes son varias aplicaciones lanzadas (incluidas las maliciosas).

⚡️ El proxy puede pasar la solicitud al objeto de servicio solo si las credenciales del cliente coinciden con algunos criterios.


🐞 Ejecución local de un servicio remoto (**proxy remoto**). Esto es cuando el objeto de servicio se encuentra en un servidor remoto.

⚡️ En este caso, el proxy pasa la solicitud del cliente a través de la red, manejando todos los detalles desagradables del trabajo con la red.


🐞 Solicitudes de registro (**proxy de registro**). Aquí es cuando desea mantener un historial de solicitudes al objeto de servicio.

⚡️ El proxy puede registrar cada solicitud antes de pasarla al servicio.n/


🐞 Almacenamiento en caché de los resultados de la solicitud (**caching proxy**). Aquí es cuando necesita almacenar en caché los resultados de las solicitudes de los clientes y administrar el ciclo de vida de este caché, especialmente si los resultados son bastante grandes.

⚡️ El proxy puede implementar el almacenamiento en caché para solicitudes recurrentes que siempre arrojan los mismos resultados. El proxy puede usar los parámetros de las solicitudes como claves de caché.


🐞 **Referencia inteligente**. Esto es cuando necesita poder descartar un objeto pesado una vez que no haya clientes que lo usen.

⚡️ El proxy puede realizar un seguimiento de los clientes que obtuvieron una referencia al objeto de servicio o sus resultados. De vez en cuando, el ⚡️ proxy puede revisar los clientes y verificar si todavía están activos. Si la lista de clientes se vacía, el proxy podría descartar el objeto de servicio y liberar los recursos del sistema subyacente.

El proxy también puede rastrear si el cliente modificó el objeto de servicio. Luego, los objetos sin modificar pueden ser reutilizados por otros clientes.


![Screenshot 2022-12-01 at 07 41 08](https://user-images.githubusercontent.com/35270796/205055409-1e6d4548-cfb3-4d54-89cb-cec336f94b8f.png)

```Swift
protocol Internet {
    func connectTo(url: String)
}

class AccessToInternet: Internet {
    func connectTo(url: String) {
        print("Conectando a \(url)")
    }
}

class ProxyInternet: Internet {
    var internet = AccessToInternet()
    var bannedUrl = [String]()
    
    init() {
        bannedUrl.append("twitter.com")
        bannedUrl.append("google.com")
        bannedUrl.append("facebook.com")
    }
    
    func connectTo(url: String) {
        if (bannedUrl.contains(url)) {
            print("Intentando conectar \(url)")
            print("URL bloqueada - Accesso Denegado - Consulta a tu Administrador")
        } else {
            internet.connectTo(url: url)
        }
    }
}

// TEST

func testProxy() {
    let internet = ProxyInternet()
    internet.connectTo(url: "udemy.com")
    internet.connectTo(url: "twitter.com")
}


testProxy()
```
**Advantage of Proxy Pattern**
- 🟢 Puede controlar el objeto de servicio sin que los clientes lo sepan.
- 🟢 Puede administrar el ciclo de vida del objeto de servicio cuando a los clientes no les importa.
- 🟢 El proxy funciona incluso si el objeto de servicio no está listo o disponible.
- 🟢 Principio abierto/cerrado . Puede introducir nuevos proxies sin cambiar el servicio o los clientes.

**Disadvantages of Proxy Patter**
- 🔴 El código puede volverse más complicado ya que necesita introducir muchas clases nuevas.
- 🔴 La respuesta del servicio puede retrasarse.

🔙 [Back To Menu](https://github.com/JosephCalla/Design-Patterns-Swift#design-patterns-swift)

