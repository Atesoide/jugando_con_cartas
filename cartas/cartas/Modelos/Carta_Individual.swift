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
            
        case "6":
            return 6
            
        case "7":
            return 7
            
        case "8":
            return 8
            
        case "9":
            return 9
            
        case "10":
            return 10
            
        case "JACK":
            return 10
            
        case "QUEEN":
            return 10
            
        case "KING":
            return 10
            
        default:
            return 0
        }
    }
}
