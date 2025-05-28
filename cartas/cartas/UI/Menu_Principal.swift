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
        NavigationView{
            VStack{
                Spacer()
                Text("Bienvenido a")
                Text("IOs Blackjack")
                Spacer()
                NavigationLink{
                    blackjack()
                } label: {
                    Text("Iniciar")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    MenuPrincipal()
        .environment(ControladorAplicacion())
}
