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
        
        VStack{
            Text("Rondas ganadas al dealer: \(apostador.ganadas)")
            Text("Rondas perdidas contra el dealer: \(apostador.perdidas)")
            Text("Aspecto de cartas:")
            Image(aspectoLocal)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            Text("Saldo actual: $\(saldoLocal)")
        }
        .onAppear(){
            saldoLocal = apostador.saldo
            aspectoLocal = apostador.aspectoCarta
        }
        
    }
}

#Preview {
    Stats()
        .environment(ControladorAplicacion())
}
