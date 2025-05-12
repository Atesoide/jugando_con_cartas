//
//  Mazo_Completo.swift
//  cartas
//
//  Created by alumno on 5/9/25.
//

import Foundation

struct MazoCompleto: Identifiable, Codable{
    let success: Bool
    let deck_id: String
    let shuffled: Bool
    let remaining: Int
    
    let id = UUID()

}
