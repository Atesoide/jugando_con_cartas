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
    @State var aspectoInvisible: String = apostador.aspectoCarta
    
    var body: some View {
        VStack {
            // Saldo del jugador - estilo fichas de casino
            Text("$\(apostador.saldo)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gold, lineWidth: 2)
                )
                .shadow(color: .gold.opacity(0.5), radius: 5)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.bottom, 10)
            
            switch estatus {
            case .apostando:
                // Vista de apuestas
                VStack(spacing: 20) {
                    Text("Apuesta tus fichas")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.gold)
                    
                    // Bote - estilo plato de casino
                    Text("Bote: \(bote)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.darkRed)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gold, lineWidth: 3)
                        )
                    
                    // Carta de fondo
                    Image(aspectoInvisible)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .shadow(color: .black, radius: 5)
                    
                    // Botones de apuesta - estilo fichas de casino
                    HStack(spacing: 10) {
                        CasinoChipButton(value: 10, action: {
                            apostador.apostar(cantidad: 10)
                            bote += 10
                            dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                            BoteVacio = false
                        }, disabled: dejaDeApostar)
                        
                        CasinoChipButton(value: 25, action: {
                            apostador.apostar(cantidad: 25)
                            bote += 25
                            dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                            BoteVacio = false
                        }, disabled: dejaDeApostar)
                        
                        CasinoChipButton(value: 50, action: {
                            apostador.apostar(cantidad: 50)
                            bote += 50
                            dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                            BoteVacio = false
                        }, disabled: dejaDeApostar)
                        
                        CasinoChipButton(value: 100, action: {
                            apostador.apostar(cantidad: 100)
                            bote += 100
                            dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                            BoteVacio = false
                        }, disabled: dejaDeApostar)
                        
                        CasinoChipButton(value: 150, action: {
                            apostador.apostar(cantidad: 150)
                            bote += 150
                            dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                            BoteVacio = false
                        }, disabled: dejaDeApostar)
                    }
                    
                    // Botón de inicio - estilo mesa de blackjack
                    Button("Iniciar"){
                        Task{
                            await controlador.revolverMazo(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "")
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
                    .buttonStyle(CasinoButtonStyle(disabled: BoteVacio))
                }
                .padding()
                .background(Color.darkGreen.opacity(0.8))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gold, lineWidth: 3)
                )
                .shadow(radius: 10)
                
            case .jugando:
                // Vista de juego
                VStack(spacing: 15) {
                    // Área del dealer
                    VStack {
                        Text("Dealer: \(resultadoDealer)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .background(Color.darkRed)
                            .cornerRadius(10)
                        
                        HStack {
                            if cartasDealer.count == 1 {
                                AsyncImage(url: URL(string: cartasDealer[0].image)){imagen in
                                    imagen
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .black, radius: 5)
                                } placeholder: {
                                    Image(apostador.aspectoCarta)
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                        .frame(width: 130)
                                        .shadow(color: .black, radius: 5)
                                }
                                Image(apostador.aspectoCarta)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .shadow(color: .black, radius: 5)
                            } else {
                                ForEach(cartasDealer){ carta in
                                    AsyncImage(url: URL(string: carta.image)){imagen in
                                        imagen
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: CGFloat(tamañoCartasD))
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .shadow(color: .black, radius: 5)
                                    } placeholder: {
                                        Image(apostador.aspectoCarta)
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                            .frame(width: CGFloat(tamañoCartasD) + 30)
                                            .shadow(color: .black, radius: 5)
                                    }
                                }
                            }
                        }
                    }
                    
                    // Bote en juego
                    Text("Bote: \(bote)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.darkRed)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gold, lineWidth: 3)
                        )
                    
                    // Área del jugador
                    VStack {
                        Text("Tus cartas:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        if valorTemporal != 0 {
                            Text("\(valorTemporal)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.gold)
                        } else {
                            Text("\(resultadoJugador)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.gold)
                        }
                        
                        HStack {
                            ForEach(cartasJugador){ carta in
                                AsyncImage(url: URL(string: carta.image)){imagen in
                                    imagen
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: CGFloat(tamañoCartasJ))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .black, radius: 5)
                                } placeholder: {
                                    Image(apostador.aspectoCarta)
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                        .frame(width: CGFloat(tamañoCartasJ) + 30)
                                        .shadow(color: .black, radius: 5)
                                }
                            }
                        }
                    }
                    
                    // Acciones del jugador
                    switch turnoDeQuien {
                    case .turnoJugador:
                        HStack(spacing: 15) {
                            Button("Doblar") {
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
                                    dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                                }
                            }
                            .disabled(dejaDeApostar || !puedeDoblar)
                            .buttonStyle(CasinoActionButtonStyle(disabled: dejaDeApostar || !puedeDoblar))
                            
                            Button("Pedir") {
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
                            .buttonStyle(CasinoActionButtonStyle())
                            
                            Button("Plantarse") {
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
                                    dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                                    turnoDeQuien = Turnos.turnoDealer
                                }
                            }
                            .buttonStyle(CasinoActionButtonStyle())
                        }
                        .padding(.top, 10)
                        
                    case .turnoDealer:
                        // Resultados del juego
                        VStack(spacing: 20) {
                            if victoria && !empate {
                                Text("Ganaste!")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gold)
                                
                                Button("Cobrar $\(bote * 2)") {
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
                                .buttonStyle(CasinoResultButtonStyle(win: true))
                                
                            } else if !victoria && !empate {
                                Text("Perdiste...")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.darkRed)
                                
                                Button("Volver") {
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
                                .buttonStyle(CasinoResultButtonStyle(win: false))
                                
                            } else {
                                Text("Empate")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Button("Devolver bote") {
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
                                    dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
                                }
                                .buttonStyle(CasinoResultButtonStyle(win: nil))
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gold, lineWidth: 3)
                        )
                        
                    
                    }
                }
                .padding()
                .background(Color.darkGreen.opacity(0.8))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gold, lineWidth: 3)
                )
                .shadow(radius: 10)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.darkGreen, .black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
        .onAppear(perform: {
            dejaDeApostar = verificarSaldo(saldo: apostador.saldo)
            aspectoInvisible = apostador.aspectoCarta
            if controlador.todosMisMazos.count != 0 {
                Task {
                    await controlador.revolverMazo(idMazo: controlador.todosMisMazos[0]?.deck_id ?? "")
                }
            }
        })
    }
}

// Estilos personalizados para los botones del casino
struct CasinoChipButton: View {
    let value: Int
    let action: () -> Void
    let disabled: Bool
    
    var body: some View {
        Button(action: action) {
            Text("\(value)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(chipColor(for: value))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 5)
        }
        .disabled(disabled)
        .opacity(disabled ? 0.5 : 1.0)
    }
    
    private func chipColor(for value: Int) -> Color {
        switch value {
        case 10: return .blue
        case 25: return .green
        case 50: return .red
        case 100: return .black
        case 150: return .purple
        default: return .gray
        }
    }
}

struct CasinoButtonStyle: ButtonStyle {
    var disabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(disabled ? Color.gray : Color.darkRed)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gold, lineWidth: 2)
            )
            .shadow(color: .gold.opacity(0.5), radius: configuration.isPressed ? 2 : 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(disabled ? 0.6 : 1.0)
    }
}

struct CasinoActionButtonStyle: ButtonStyle {
    var disabled: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(10)
            .background(disabled ? Color.gray : Color.darkRed)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gold, lineWidth: 2)
            )
            .shadow(color: .gold.opacity(0.5), radius: configuration.isPressed ? 2 : 3)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(disabled ? 0.6 : 1.0)
    }
}

struct CasinoResultButtonStyle: ButtonStyle {
    var win: Bool? // true = ganar, false = perder, nil = empate
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                win == true ? Color.green :
                    win == false ? Color.darkRed :
                    Color.gray
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gold, lineWidth: 3)
            )
            .shadow(color: .gold.opacity(0.5), radius: configuration.isPressed ? 2 : 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

// Extensiones para colores personalizados del casino
extension Color {
    static let gold = Color(red: 1.0, green: 0.84, blue: 0.0)
    static let darkRed = Color(red: 0.5, green: 0.0, blue: 0.0)
    static let darkGreen = Color(red: 0.0, green: 0.4, blue: 0.0)
}

func sumarValores(cartas: [CartaIndividual], valorAltoAs: Bool) -> Int {
    var suma: Int = 0
    for carta in cartas {
        suma += carta.sacarValor(valorDeAsAlto: valorAltoAs)
    }
    return suma
}

func verificarSaldo(saldo: Int) -> Bool {
    if saldo > 150 {
        return false
    } else {
        return true
    }
}

#Preview {
    blackjack()
        .environment(ControladorAplicacion())
}
