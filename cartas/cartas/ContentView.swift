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
        // var cartas: Int = controlador.mazoDePrueba?.remaining ?? 0
        Text(defaul.suit)
        
    }
}

#Preview {
    ContentView()
        .environment(ControladorAplicacion())
}
