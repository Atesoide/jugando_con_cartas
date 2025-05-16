//
//  ContentView.swift
//  cartas
//
//  Created by alumno on 5/9/25.
//

import SwiftUI

let defaul: CartaIndividual = CartaIndividual(code: "6H", image: "", images: nil, value: "6", suit: "SPADES")
struct ContentView: View {
    @Environment(ControladorAplicacion.self) var controlador
    @State var cartaDePrueba: CartaIndividual = defaul
    
    var body: some View {
        // var cartas: Int = controlador.mazoDePrueba?.remaining ?? 0
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            if controlador.todosMisMazos.count != 0{
                Text("Tu mazo tiene \(controlador.todosMisMazos[0]?.remaining) cartas")
                Text("carta es\(cartaDePrueba)")
                Text("Tu mazo tiene \(controlador.todosMisMazos[0]?.remaining) cartas")
                
                
            }
            
            //Text("\(cartas)")
        }
        .padding()
        .onAppear(perform: {
            if controlador.todosMisMazos.count != 0{
                Task{
                    cartaDePrueba = await controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "") ?? defaul
                }
                
            }
            
        })
        
    }
}

#Preview {
    ContentView()
        .environment(ControladorAplicacion())
}
