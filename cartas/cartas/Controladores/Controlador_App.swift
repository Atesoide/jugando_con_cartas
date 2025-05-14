//
//  Controlador_App.swift
//  cartas
//
//  Created by alumno on 5/12/25.
//

import Foundation
import SwiftUI

@Observable
@MainActor
public class ControladorAplicacion{
    var mazoDePrueba: MazoCompleto? = nil
    
    var todosMisMazos: [MazoCompleto?] = []
    
    init() {
        Task.detached(priority: .high){
            await self.generarMacito(cantidadDeMazos: "3")
            //mazoDePrueba = await generarMacito()
        }
        
    }
    func generarMacito(cantidadDeMazos:String) async{
        guard let mazo: MazoCompleto = try? await CartasAPI().generarMazo(cantidadMazos: "\(cantidadDeMazos)") else{ return }
        
        self.todosMisMazos.append(mazo)
        self.mazoDePrueba = mazo
    }
}

