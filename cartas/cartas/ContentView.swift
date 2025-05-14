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
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            if controlador.todosMisMazos.count != 0{
                Text("Tu mazo tiene \(controlador.todosMisMazos[0]?.remaining) cartas")
                
                
            }
            
            //Text("\(cartas)")
        }
        .padding()
        .onAppear(perform: {
            controlador.funcionDePrueba()
        })
    }
}

#Preview {
    ContentView()
        .environment(ControladorAplicacion())
}
