//
//  blackjack.swift
//  cartas
//
//  Created by alumno on 5/21/25.
//

import SwiftUI

let defaul: CartaIndividual = CartaIndividual(code: "6H", image: "", images: nil, value: "6", suit: "SPADES")

struct blackjack: View {
    @Environment(ControladorAplicacion.self) var controlador
    @State var cartaDePrueba: CartaIndividual = defaul
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            if controlador.todosMisMazos.count != 0{
                Text("Tu mazo tiene \(controlador.todosMisMazos[0]?.remaining) cartas")
                AsyncImage(url: URL(string: cartaDePrueba.image)){imagen in
                    imagen
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                        .clipShape(Rectangle())
                } placeholder: {
                    Image("carta_detras")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: 100)
                }
                //Text("carta es \(cartaDePrueba)")
                
                
            }
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/){
                Task{
                    if await controlador.revisarCantidadDeCartas(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "") <= 10{
                        await controlador.revolverMazo(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "")
                    }
                    cartaDePrueba = await controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul
                    
                }
                
            }
            //Text("\(cartas)")
        }
        .padding()
        .onAppear(perform: {
            if controlador.todosMisMazos.count != 0{
                Task{
                    
                    
                    cartaDePrueba = await controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul
                    await controlador.revolverMazo(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "")
                    
                    
                    
                }
                
            }
        })
    }
}

#Preview {
    blackjack()
        .environment(ControladorAplicacion())
}
