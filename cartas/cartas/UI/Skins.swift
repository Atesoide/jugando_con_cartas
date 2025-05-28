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
        ScrollView{
            LazyVStack{
                ForEach(colores, id: \.self){colorr in
                    HStack{
                        Spacer()
                        Image(colorr)
                            .resizable()
                            .scaledToFit()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Button("Seleccionar aspecto"){
                            apostador.aspectoCarta = colorr
                        }
                        Spacer()
                    }
                    
                }
            }
        }
    }
}

#Preview {
    Skins()
        .environment(ControladorAplicacion())
}
