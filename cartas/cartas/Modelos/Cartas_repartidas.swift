//
//  Cartas_repartidas.swift
//  cartas
//
//  Created by alumno on 5/14/25.
//

import Foundation

struct CartasRepartidas: Identifiable, Codable{
    let success: Bool
    let deck_id: String
    let cards: Array<CartaIndividual>
    let remaining: Int
    
    let id = UUID()
}
