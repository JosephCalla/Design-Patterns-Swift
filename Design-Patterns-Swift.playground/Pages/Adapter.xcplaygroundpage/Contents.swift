//: [Previous](@previous)

import Foundation

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

//: [Next](@next)
