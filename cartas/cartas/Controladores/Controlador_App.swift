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
    
    init() {
        Task.detached(priority: .high){
            await self.generarMacito()
        }
    }
    func generarMacito() async{
        guard let mazo: MazoCompleto = try? await CartasAPI().generarMazo(cantidadMazos: "1") else{return}
        
        self.mazoDePrueba = mazo
    }
}

