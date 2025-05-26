//
//  Gambito.swift
//  cartas
//
//  Created by alumno on 5/26/25.
//

import Foundation

struct Gambito{
    var saldo: Int
    var aspectoCarta: String
    var ganadas: Int
    var perdidas: Int
    
    mutating func ganar(){
        self.ganadas += 1
    }
    mutating func perder(){
        self.perdidas += 1
    }
    mutating func apostar(cantidad: Int){
        self.saldo -= cantidad
    }
}
