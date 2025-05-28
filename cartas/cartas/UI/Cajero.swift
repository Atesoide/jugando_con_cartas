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
        VStack{
            Spacer()
            Text("Vamos! tienes que vencer al malvado")
            Text("dealer de blackjack")
            Spacer()
            Button("Sacar dinero"){
                apostador.saldo = 500
            }
            .disabled(desactivarCajero)
            Spacer()
        }
        .onAppear(perform: {
            if apostador.saldo >= 500{
                desactivarCajero = true
            }
            else{
                desactivarCajero = false
            }
        })
        
        
        
    }
        
}

#Preview {
    Cajero()
        .environment(ControladorAplicacion())
}
