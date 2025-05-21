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
        guard var mazo: MazoCompleto = try? await CartasAPI().generarMazo(cantidadMazos: "\(cantidadDeMazos)") else{ return }
        
        self.todosMisMazos.append(mazo)
        self.mazoDePrueba = mazo
    }
    func sacarCarta(idMazo: String, cantidadCartas: String) async -> CartaIndividual?{
            print("Controlador: \(idMazo)")
            guard let cartaEncapsulada: CartasRepartidas = try? await CartasAPI().sacarCarta(idMazo: idMazo, cantidadCartas: cantidadCartas) else{ return nil }
            guard var cartaExtraida: CartaIndividual = try? await extraerCartaIndividual(cartaSacada: cartaEncapsulada) else {return nil}
            print(cartaEncapsulada.remaining)
            
            return cartaExtraida
        }
    func revisarCantidadDeCartas(idMazo: String) async -> Int{
        guard let cartaInvisible: CartasRepartidas = try? await CartasAPI().sacarCarta(idMazo: idMazo, cantidadCartas: "0") else{ return 52 }
        return cartaInvisible.remaining
    }
        
    func extraerCartaIndividual(cartaSacada: CartasRepartidas) -> CartaIndividual{
            let cartaExtraida: CartaIndividual = cartaSacada.cards[0]
            
            return cartaExtraida
        }
    func revolverMazo(idMazo: String) async{
            var contador: Int = 0
            for mazo in todosMisMazos{
                
                if idMazo == mazo?.deck_id{
                    todosMisMazos[0] = try? await CartasAPI().reShuffle(idMazo: idMazo)
                }
                contador += 1
            }
        }
    
}
