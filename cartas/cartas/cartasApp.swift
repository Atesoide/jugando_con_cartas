//
//  cartasApp.swift
//  cartas
//
//  Created by alumno on 5/9/25.
//

import SwiftUI

@main
@MainActor
struct cartasApp: App {
    @State var controlador = ControladorAplicacion()
    var body: some Scene {
        WindowGroup {
            MenuPrincipal()
                .environment(controlador)
        }
    }
}
