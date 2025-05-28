//
//  Stats.swift
//  cartas
//
//  Created by alumno on 5/28/25.
//

import SwiftUI

struct Stats: View {
    @Environment(ControladorAplicacion.self) var controlador
    @State var saldoLocal: Int = 0
    @State var aspectoLocal: String = "carta_detras"
    
    var body: some View {
        ZStack {
            // Fondo estilo casino
            LinearGradient(
                gradient: Gradient(colors: [.casinoDarkGreen, .black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Estadísticas del Jugador")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.casinoGold)
                    .padding()
                    .background(Color.casinoDarkRed.opacity(0.8))
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.casinoGold, lineWidth: 3)
                    )
                    .shadow(radius: 10)
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("• Rondas ganadas al dealer: \(apostador.ganadas)")
                    Text("• Rondas perdidas contra el dealer: \(apostador.perdidas)")
                    Text("• Saldo actual: $\(saldoLocal)")
                }
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.casinoGold, lineWidth: 2)
                )
                .shadow(color: .casinoGold.opacity(0.3), radius: 5)
                .padding(.horizontal, 30)
                
                VStack(spacing: 10) {
                    Text("Aspecto de carta actual:")
                        .foregroundColor(.casinoGold)
                        .font(.headline)
                    Image(aspectoLocal)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .shadow(radius: 5)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.casinoGold, lineWidth: 2)
                        )
                }
                
                Spacer()
            }
        }
        .onAppear {
            saldoLocal = apostador.saldo
            aspectoLocal = apostador.aspectoCarta
        }
    }
}

#Preview {
    Stats()
        .environment(ControladorAplicacion())
}

