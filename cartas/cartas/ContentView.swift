//
//  ContentView.swift
//  cartas
//
//  Created by alumno on 5/9/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(ControladorAplicacion.self) var controlador
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Tu mazo tiene \(controlador.mazoDePrueba?.remaining) cartas")
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(ControladorAplicacion())
}
