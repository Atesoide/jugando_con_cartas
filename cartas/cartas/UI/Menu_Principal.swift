//
//  Menu_Principal.swift
//  cartas
//
//  Created by alumno on 5/28/25.
//

import SwiftUI

struct MenuPrincipal: View {
    @Environment(ControladorAplicacion.self) var controlador

    var body: some View {
        NavigationView {
            ZStack {
                // Fondo estilo casino
                LinearGradient(
                    gradient: Gradient(colors: [.casinoDarkGreen, .black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 30) {
                    Spacer()

                    VStack(spacing: 10) {
                        Text("¡Bienvenido a")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.casinoGold)
                            .shadow(color: .black, radius: 2)

                        Text("iOS Blackjack!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.casinoGold)
                            .shadow(color: .black, radius: 3)
                    }
                    .padding()
                    .background(Color.casinoDarkRed.opacity(0.8))
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.casinoGold, lineWidth: 3)
                    )
                    .shadow(radius: 10)
                    .padding(.horizontal, 20)

                    Spacer()

                    NavigationLink(destination: TodoJunto()) {
                        HStack {
                            Image(systemName: "play.circle.fill")
                                .font(.title)
                            Text("Iniciar")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.casinoDarkRed)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.casinoGold, lineWidth: 2)
                        )
                        .shadow(color: .casinoGold.opacity(0.5), radius: 5)
                        .padding(.horizontal, 40)
                    }

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MenuPrincipal()
        .environment(ControladorAplicacion())
}

