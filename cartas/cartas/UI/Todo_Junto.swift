//
//  Todo_Junto.swift
//  cartas
//
//  Created by alumno on 5/28/25.
//

import SwiftUI

struct Todo_Junto: View {
    @Environment(ControladorAplicacion.self) var controlador
    var body: some View {
        TabView{
            blackjack()
                .tabItem {
                    Label("BlacJack", systemImage: "circle")
                }
            Skins()
                .tabItem {
                    Label("Aspectos", systemImage: "circle")
                }
            Stats()
                .tabItem {
                    Label("Estadisticas", systemImage: "circle")
                }
            Cajero()
                .tabItem {
                    Label("Cajero", systemImage: "circle")
                }
        }
    }
}

#Preview {
    Todo_Junto()
        .environment(ControladorAplicacion())
}
