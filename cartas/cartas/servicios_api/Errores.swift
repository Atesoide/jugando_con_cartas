//
//  Errores.swift
//  cartas
//
//  Created by alumno on 5/12/25.
//

import Foundation

enum ErroresDeRed: Error{
    case malaDireccionUrl
    case invalidRequest
    case badResponse
    case badStatus
    case fallaAlConvertirLaRespuesta
}
