//
//  Cajero.swift
//  cartas
//
//  Created by alumno on 5/28/25.
//
import SwiftUI


struct Cajero: View {
    @Environment(ControladorAplicacion.self) var controlador
    @State var desactivarCajero: Bool = true
    
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
                Spacer()
                
                // Texto de bienvenida - estilo letrero de casino
                VStack(spacing: 10) {
                    Text("Vamos! tienes que vencer al malvado")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.casinoGold)
                        .shadow(color: .black, radius: 2)
                    
                    Text("dealer de blackjack")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.casinoGold)
                        .shadow(color: .black, radius: 2)
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
                
                // Botón de sacar dinero - estilo máquina de casino
                Button(action: {
                    apostador.saldo = 500
                }) {
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.title)
                        
                        Text("Sacar dinero")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(desactivarCajero ? Color.gray : Color.casinoDarkRed)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.casinoGold, lineWidth: 2)
                    )
                    .shadow(color: desactivarCajero ? .clear : .casinoGold.opacity(0.5), radius: 5)
                }
                .disabled(desactivarCajero)
                .padding(.horizontal, 40)
                
                Spacer()
                
                // Indicador de saldo - estilo placa de casino
                Text("Saldo actual: $\(apostador.saldo)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.black)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.casinoGold, lineWidth: 2)
                    )
                    .shadow(color: .casinoGold.opacity(0.3), radius: 5)
                    .padding(.bottom, 20)
            }
        }
        .onAppear(perform: {
            desactivarCajero = apostador.saldo >= 500
        })
    }
}

#Preview {
    Cajero()
        .environment(ControladorAplicacion())
}
