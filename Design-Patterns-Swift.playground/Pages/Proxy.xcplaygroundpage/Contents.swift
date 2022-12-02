//: [Previous](@previous)

import Foundation

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

//: [Next](@next)
