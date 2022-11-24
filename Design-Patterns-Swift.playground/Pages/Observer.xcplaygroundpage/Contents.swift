//: [Previous](@previous)

import Foundation

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
//: [Next](@next)
