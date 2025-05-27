//
//  blackjack.swift
//  cartas
//
//  Created by alumno on 5/21/25.
//

import SwiftUI

let defaul: CartaIndividual = CartaIndividual(code: "6H", image: "", images: nil, value: "6", suit: "SPADES")


var apostador: Gambito = Gambito(saldo: 500, aspectoCarta: "carta_detras", ganadas: 0, perdidas: 0)



struct blackjack: View {
    @Environment(ControladorAplicacion.self) var controlador
    @State var bote: Int = 0
    @State var cartaDePrueba: CartaIndividual = defaul
    @State var estatus: Jugando = Jugando.apostando
    @State var cartasDealer: [CartaIndividual] = []
    @State var cartasJugador: [CartaIndividual] = []
    @State var turnoDeQuien: Turnos = Turnos.turnoJugador
    @State var tamañoCartasJ: Int = 100 //Tamaño de las cartas del jugador
    @State var tamañoCartasD: Int = 100 //Tamaño de las cartas del dealer
    @State var resultadoDealer: Int = 0
    @State var resultadoJugador: Int = 0
    @State var dejaDeApostar: Bool = false
    @State var puedeDoblar: Bool = true
    @State var BoteVacio: Bool = true
    @State var valorTemporal: Int = 0
    @State var victoria: Bool = true
    @State var empate: Bool = false
    
    
    
    var body: some View {
        Text("$\(apostador.saldo)")
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)
        VStack {
            switch estatus {
            case .apostando:
                Text("Apuesta tus fichas")
                Text("Bote: \(bote)")
                Image(apostador.aspectoCarta)
                    .resizable()
                    .scaledToFit()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                HStack{ //Botones de apuesta
                    Button("10"){
                        apostador.apostar(cantidad: 10)
                        bote += 10
                        dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                        BoteVacio = false
                    }
                    .disabled(dejaDeApostar)
                    Button("25"){
                        apostador.apostar(cantidad: 25)
                        bote += 25
                        dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                        BoteVacio = false
                    }
                    .disabled(dejaDeApostar)
                    Button("50"){
                        apostador.apostar(cantidad: 50)
                        bote += 50
                        dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                        BoteVacio = false
                    }
                    .disabled(dejaDeApostar)
                    Button("100"){
                        apostador.apostar(cantidad: 100)
                        bote += 100
                        dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                        BoteVacio = false
                    }
                    .disabled(dejaDeApostar)
                    Button("150"){
                        apostador.apostar(cantidad: 150)
                        bote += 150
                        dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                        BoteVacio = false
                    }
                    .disabled(dejaDeApostar)
                }
                Button("Iniciar"){
                    Task{
                        if await controlador.todosMisMazos.count != 0{
                            await cartasDealer.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                            
                            await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                            await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                            
                        }
                        
                        resultadoDealer = sumarValores(cartas: cartasDealer, valorAltoAs: true)
                        if cartasJugador.contains(where: { CartaIndividual in
                            CartaIndividual.value == "ACE"
                        }){
                            valorTemporal = sumarValores(cartas: cartasJugador, valorAltoAs: true)
                        }
                        resultadoJugador = sumarValores(cartas: cartasJugador, valorAltoAs: false)
                        if valorTemporal == 21{
                            turnoDeQuien = Turnos.turnoDealer
                            apostador.saldo += bote * 3
                            bote = 0
                            apostador.ganar()
                            victoria = true
                        }
                        
                        estatus = Jugando.jugando

                        
                    }
                }
                .disabled(BoteVacio)
            case .jugando:
                Text("Dealer: \(resultadoDealer)")
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
                                    .frame(width: CGFloat(tamañoCartasD))
                                    .clipShape(Rectangle())
                            } placeholder: {
                                Image(apostador.aspectoCarta)
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .frame(width: CGFloat(tamañoCartasD) + 30)
                            }
                        }
                    }
                }
                Spacer()
                Text("Bote: \(bote)")
                Spacer()
                Text("Tus cartas:")
                if valorTemporal != 0{
                    Text("\(valorTemporal)")
                }
                else{
                    Text("\(resultadoJugador)")
                }
                
                
                HStack{
                    ForEach(cartasJugador){ carta in
                        AsyncImage(url: URL(string: carta.image)){imagen in
                            imagen
                                .resizable()
                                .scaledToFit()
                                .frame(width: CGFloat(tamañoCartasJ))
                                .clipShape(Rectangle())
                        } placeholder: {
                            Image(apostador.aspectoCarta)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: CGFloat(tamañoCartasJ) + 30)
                        }
                    }
                }
                switch turnoDeQuien {
                case .turnoJugador:
                    HStack{ // Gameplay principal -----------------------
                        Button("Doblar"){
                            Task{
                                apostador.saldo -= bote
                                bote += bote
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                
                                if valorTemporal != 0{
                                    valorTemporal = sumarValores(cartas: cartasJugador, valorAltoAs: true)
                                    if valorTemporal > 21{
                                        resultadoJugador = sumarValores(cartas: cartasJugador, valorAltoAs: false)
                                    }
                                    else{
                                        resultadoJugador = valorTemporal
                                    }
                                    valorTemporal = 0
                                }
                                else{
                                    resultadoJugador = sumarValores(cartas: cartasJugador, valorAltoAs: true)
                                    if cartasJugador.contains(where: { CartaIndividual in
                                        CartaIndividual.value == "ACE"
                                    }) && resultadoJugador > 21{
                                        resultadoJugador = sumarValores(cartas: cartasJugador, valorAltoAs: false)
                                    }
                                    else{
                                        resultadoJugador = sumarValores(cartas: cartasJugador, valorAltoAs: false)
                                    }
                                }
                                if resultadoJugador > 21{
                                    turnoDeQuien = Turnos.turnoDealer
                                    apostador.perder()
                                    victoria = false
                                    return
                                }
                                await cartasDealer.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                if cartasDealer.contains(where: { CartaIndividual in
                                    CartaIndividual.value == "ACE"
                                }){
                                    valorTemporal = sumarValores(cartas: cartasDealer, valorAltoAs: true)
                                    resultadoDealer = valorTemporal
                                }
                                else{
                                    resultadoDealer = sumarValores(cartas: cartasDealer, valorAltoAs: false)
                                }
                                
                                repeat{
                                    if resultadoDealer < 21 && resultadoDealer < 17{
                                        await cartasDealer.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                    }
                                    
                                    if valorTemporal != 0{
                                        valorTemporal = sumarValores(cartas: cartasDealer, valorAltoAs: true)
                                        if valorTemporal > 21{
                                            resultadoDealer = sumarValores(cartas: cartasDealer, valorAltoAs: false)
                                            valorTemporal = 0
                                        }
                                    }
                                    else{
                                        resultadoDealer = sumarValores(cartas: cartasDealer, valorAltoAs: true)
                                        if cartasDealer.contains(where: { CartaIndividual in
                                            CartaIndividual.value == "ACE"
                                        }) && resultadoDealer > 21{
                                            resultadoDealer = sumarValores(cartas: cartasJugador, valorAltoAs: false)
                                        }
                                    }
                                } while resultadoDealer < 16
                                if resultadoDealer > resultadoJugador && resultadoDealer <= 21{
                                    victoria = false
                                    empate = false
                                }
                                else if resultadoDealer < resultadoJugador{
                                    victoria = true
                                    empate = false
                                }
                                else if resultadoJugador == resultadoDealer{
                                    empate = true
                                }
                                turnoDeQuien = Turnos.turnoDealer
                            }
                            
                        }
                        .disabled(dejaDeApostar || !puedeDoblar)
                        Button("Pedir"){
                            Task{
                                await cartasJugador.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                puedeDoblar = false
                                if valorTemporal != 0{
                                    valorTemporal = sumarValores(cartas: cartasJugador, valorAltoAs: true)
                                    if valorTemporal > 21{
                                        resultadoJugador = sumarValores(cartas: cartasJugador, valorAltoAs: false)
                                        valorTemporal = 0
                                    }
                                }
                                else{
                                    resultadoJugador = sumarValores(cartas: cartasJugador, valorAltoAs: true)
                                    if cartasJugador.contains(where: { CartaIndividual in
                                        CartaIndividual.value == "ACE"
                                    }) && resultadoJugador > 21{
                                        resultadoJugador = sumarValores(cartas: cartasJugador, valorAltoAs: false)
                                    }
                                }
                                if cartasJugador.count > 3{
                                    tamañoCartasJ = 70
                                }
                                if cartasJugador.count > 5{
                                    tamañoCartasJ = 50
                                }
                                if resultadoJugador > 21{
                                    turnoDeQuien = Turnos.turnoDealer
                                    apostador.perder()
                                    victoria = false
                                }
                            }
                        }
                        Button("Plantarse"){
                            Task{
                                if valorTemporal != 0{
                                    resultadoJugador = valorTemporal
                                    valorTemporal = 0
                                }
                                await cartasDealer.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                if cartasDealer.contains(where: { CartaIndividual in
                                    CartaIndividual.value == "ACE"
                                }){
                                    valorTemporal = sumarValores(cartas: cartasDealer, valorAltoAs: true)
                                    resultadoDealer = valorTemporal
                                }
                                else{
                                    resultadoDealer = sumarValores(cartas: cartasDealer, valorAltoAs: false)
                                }
                                
                                repeat{
                                    if resultadoDealer < 21 && resultadoDealer < 17{
                                        await cartasDealer.append(controlador.sacarCarta(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "", cantidadCartas: "1") ?? defaul)
                                    }
                                    
                                    if valorTemporal != 0{
                                        valorTemporal = sumarValores(cartas: cartasDealer, valorAltoAs: true)
                                        if valorTemporal > 21{
                                            resultadoDealer = sumarValores(cartas: cartasDealer, valorAltoAs: false)
                                            valorTemporal = 0
                                        }
                                    }
                                    else{
                                        resultadoDealer = sumarValores(cartas: cartasDealer, valorAltoAs: true)
                                        if cartasDealer.contains(where: { CartaIndividual in
                                            CartaIndividual.value == "ACE"
                                        }) && resultadoDealer > 21{
                                            resultadoDealer = sumarValores(cartas: cartasJugador, valorAltoAs: false)
                                        }
                                    }
                                    if cartasDealer.count > 3{
                                        tamañoCartasD = 70
                                    }
                                    if cartasDealer.count > 5{
                                        tamañoCartasD = 50
                                    }
                                } while resultadoDealer < 16
                                if resultadoDealer > resultadoJugador && resultadoDealer <= 21{
                                    victoria = false
                                    empate = false
                                }
                                else if resultadoJugador < resultadoJugador{
                                    victoria = true
                                    empate = false
                                }
                                else if resultadoJugador == resultadoDealer{
                                    empate = true
                                }
                                turnoDeQuien = Turnos.turnoDealer
                            }
                            
                        }
                    }
                case .turnoDealer:
                    if victoria && !empate{
                        Text("Ganaste!")
                        Button("Cobrar $\(bote * 2)"){
                            apostador.saldo += bote * 2
                            bote = 0
                            estatus = Jugando.apostando
                            turnoDeQuien = Turnos.turnoJugador
                            cartasDealer = []
                            cartasJugador = []
                            resultadoDealer = 0
                            resultadoJugador = 0
                            puedeDoblar = true
                            BoteVacio = true
                            valorTemporal = 0
                            empate = false
                            tamañoCartasD = 100
                            tamañoCartasJ = 100
                        }
                        
                    }
                    else if !victoria && !empate{
                        Text("Perdiste...")
                        Button("Volver"){
                            bote = 0
                            estatus = Jugando.apostando
                            turnoDeQuien = Turnos.turnoJugador
                            cartasDealer = []
                            cartasJugador = []
                            resultadoDealer = 0
                            resultadoJugador = 0
                            puedeDoblar = true
                            BoteVacio = true
                            valorTemporal = 0
                            victoria = true
                            empate = false
                            tamañoCartasD = 100
                            tamañoCartasJ = 100
                        }
                    }
                    else{
                        Text("Empate")
                        Button("devolver bote"){
                            apostador.saldo += bote
                            bote = 0
                            estatus = Jugando.apostando
                            turnoDeQuien = Turnos.turnoJugador
                            cartasDealer = []
                            cartasJugador = []
                            resultadoDealer = 0
                            resultadoJugador = 0
                            puedeDoblar = true
                            BoteVacio = true
                            valorTemporal = 0
                            victoria = true
                            empate = false
                            tamañoCartasD = 100
                            tamañoCartasJ = 100
                        }
                    }
                    
                case .turnosTerminados:
                    Text("Siii")
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

func sumarValores(cartas: [CartaIndividual], valorAltoAs: Bool) -> Int {
    var suma: Int = 0
    for carta in cartas {
        suma += carta.sacarValor(valorDeAsAlto: valorAltoAs)
    }
    return suma
}
func verificarSaldo(saldo: Int) -> Bool{
    if saldo > 150{
        return false
    }
    else{
        return true
    }
}

#Preview {
    blackjack()
        .environment(ControladorAplicacion())
}
