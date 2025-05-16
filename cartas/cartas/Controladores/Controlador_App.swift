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
            await self.generarMacito(cantidadDeMazos: "1")
            //mazoDePrueba = await generarMacito()
        }
        
    }
    func generarMacito(cantidadDeMazos:String) async{
        guard let mazo: MazoCompleto = try? await CartasAPI().generarMazo(cantidadMazos: "\(cantidadDeMazos)") else{ return }
        
        self.todosMisMazos.append(mazo)
        self.mazoDePrueba = mazo
    }
    func sacarCarta(idMazo: String) async -> CartaIndividual?{
        guard let cartaEncapsulada: CartasRepartidas = try? await CartasAPI().sacarCarta(idMazo: idMazo) else{ return nil }
        guard var cartaExtraida: CartaIndividual = try? await extraerCartaIndividual(cartaSacada: cartaEncapsulada) else {return nil}
        print(cartaEncapsulada.remaining)
        
        return cartaExtraida
    }
    func extraerCartaIndividual(cartaSacada: CartasRepartidas) -> CartaIndividual{
        let cartaExtraida: CartaIndividual = cartaSacada.cards[0]
        
        return cartaExtraida
    }

}

