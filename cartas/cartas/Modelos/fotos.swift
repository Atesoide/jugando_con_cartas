//
//  fotos.swift
//  cartas
//
//  Created by alumno on 5/14/25.
//
//MODELO TODO INECESARIO QUIEN DISEÑÓ ESTA API

import Foundation

struct Fotos: Identifiable, Codable{
    let svg: String
    let png: String
    
    let id = UUID()
}
