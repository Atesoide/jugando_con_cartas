//
//  Carta_Individual.swift
//  cartas
//
//  Created by alumno on 5/14/25.
//

import Foundation

struct CartaIndividual: Identifiable, Codable{
    let code: String
    let image: String
    let images: Fotos
    let value: String
    let suit: String
    
    let id = UUID()
}
