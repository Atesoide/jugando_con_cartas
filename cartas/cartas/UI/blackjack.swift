//
//  blackjack.swift
//  cartas
//
//  Created by alumno on 5/21/25.
//

import SwiftUI

let defaul: CartaIndividual = CartaIndividual(code: "6H", image: "", images: nil, value: "6", suit: "SPADES")


var apostador: Gambito = Gambito(saldo: 500, aspectoCarta: "carta_detras", ganadas: 0, perdidas: 0)
var bote: Int = 0


struct blackjack: View {
    @Environment(ControladorAplicacion.self) var controlador
    @State var cartaDePrueba: CartaIndividual = defaul
    @State var saldo: Int = 100
    @State var estatus: Jugando = Jugando.apostando
    @State var cartasDealer: [CartaIndividual] = []
    @State var cartasJugador: [CartaIndividual] = []
    
    
    var body: some View {
        Text("$\(apostador.saldo)")
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)
        VStack {
            switch estatus {
            case .apostando:
                Text("Apuesta tus fichas")
                Image(apostador.aspectoCarta)
                    .resizable()
                    .scaledToFit()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                HStack{ //Botones de apuesta
                    Button("10"){
                        Task{
                            if await controlador.todosMisMazos.count != 0{
                                await cartasDealer.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                
                            }
                            
                            apostador.apostar(cantidad: 10)
                            print(apostador.saldo)
                            estatus = Jugando.jugando
                            bote += 10
                        }
                    }
                    Button("25"){
                        Task{
                            if await controlador.todosMisMazos.count != 0{
                                await cartasDealer.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                            }
                            
                            apostador.apostar(cantidad: 25)
                            print(apostador.saldo)
                            estatus = Jugando.jugando
                            bote += 25
                        }
                    }
                    Button("50"){
                        Task{
                            if await controlador.todosMisMazos.count != 0{
                                await cartasDealer.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                            }
                            
                            apostador.apostar(cantidad: 50)
                            print(apostador.saldo)
                            estatus = Jugando.jugando
                            bote += 50
                        }
                    }
                    Button("100"){
                        Task{
                            if await controlador.todosMisMazos.count != 0{
                                await cartasDealer.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                            }
                            
                            apostador.apostar(cantidad: 100)
                            print(apostador.saldo)
                            estatus = Jugando.jugando
                            bote += 100
                        }
                    }
                    Button("150"){
                        Task{
                            if await controlador.todosMisMazos.count != 0{
                                await cartasDealer.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                            }
                            
                            apostador.apostar(cantidad: 150)
                            print(apostador.saldo)
                            estatus = Jugando.jugando
                            bote += 150
                        }
                    }
                }
            case .jugando:
                Text("Dealer:")
                HStack{
                    if cartasDealer.count == 1{
                        AsyncImage(url: URL(string: cartasDealer[0].image)){imagen in
                            imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .clipShape(Rectangle())
                        } placeholder: {
                            Image(apostador.aspectoCarta)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 130)
                        }
                        Image(apostador.aspectoCarta)
                            .resizable()
                            .scaledToFit()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    }
                    else{
                        ForEach(cartasDealer){ carta in
                            AsyncImage(url: URL(string: carta.image)){imagen in
                                imagen
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .clipShape(Rectangle())
                            } placeholder: {
                                Image(apostador.aspectoCarta)
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .frame(width: 130)
                            }
                        }
                    }
                }
                Spacer()
                Text("Bote: \(bote)")
                Spacer()
                Text("Tus cartas:")
                HStack{
                    ForEach(cartasJugador){ carta in
                        AsyncImage(url: URL(string: carta.image)){imagen in
                            imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .clipShape(Rectangle())
                        } placeholder: {
                            Image(apostador.aspectoCarta)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 130)
                        }
                    }
                }
                HStack{
                    
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
