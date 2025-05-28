//
//  Skins.swift
//  cartas
//
//  Created by alumno on 5/28/25.
//

import SwiftUI

struct Skins: View {
    @Environment(ControladorAplicacion.self) var controlador
    var colores: [String] = ["carta_detras", "carta_detras_purple", "carta_detras_orange", "carta_detras_green", "carta_detras_blue", "carta_detras_black"]

    var body: some View {
        ZStack {
            // Fondo de casino
            LinearGradient(
                gradient: Gradient(colors: [.casinoDarkGreen, .black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Selecciona tu estilo de carta")
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

                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(colores, id: \.self) { colorr in
                            HStack {
                                Spacer()
                                Image(colorr)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .shadow(radius: 5)
                                Spacer()
                                Button(action: {
                                    apostador.aspectoCarta = colorr
                                }) {
                                    Text("Seleccionar")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(Color.casinoDarkRed)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.casinoGold, lineWidth: 2)
                                        )
                                        .shadow(color: .casinoGold.opacity(0.4), radius: 4)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    Skins()
        .environment(ControladorAplicacion())
}
