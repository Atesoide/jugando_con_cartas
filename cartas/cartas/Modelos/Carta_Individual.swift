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
    let images: Fotos?
    let value: String
    let suit: String
    
    let id = UUID()
    
    func sacarValor(valorDeAsAlto: Bool) -> Int{
        
        switch self.value{
        case "ACE":
            if valorDeAsAlto{
                return 11
            }
            else{
                return 1
            }
        
        case "2":
            return 2
            
        case "3":
            return 3
            
        case "4":
            return 4
            
        case "5":
            return 5
            
        default:
            return 0
        }
        return 0
    }
}
