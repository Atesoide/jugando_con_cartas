//
//  cartas_api.swift
//  cartas
//
//  Created by alumno on 5/9/25.
//

import SwiftUI

class CartasAPI: Codable{
    let urlBase = "https://deckofcardsapi.com/api/deck"
    //let mazoDePrueba = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
    
    func generarMazo(cantidadMazos: String) async -> MazoCompleto?{
        let accion = "/new/shuffle/?deck_count=\(cantidadMazos)"
        
        return await descargar(funcion: accion)
    }
    
    
    
    //--------------------------------------------------------------------
    private func descargar<TipoGenerico: Codable>(funcion: String) async -> TipoGenerico?{
        do{
            guard let url = URL(string: "\(urlBase)\(funcion)") else{ throw ErroresDeRed.malaDireccionUrl }
            let (datos, respuesta) = try await URLSession.shared.data(from: url)
            guard let respuesta = respuesta as? HTTPURLResponse else { throw ErroresDeRed.badResponse }
            guard respuesta.statusCode >= 200 && respuesta.statusCode < 300 else { throw ErroresDeRed.badStatus}
            do{
                let respuestaDecodificada = try JSONDecoder().decode(TipoGenerico.self, from: datos)
                return respuestaDecodificada
            }
            catch let error as NSError{
                print("El error en tu modelo es: \(error.debugDescription)")
                throw ErroresDeRed.fallaAlConvertirLaRespuesta
            }
            
            
        } catch ErroresDeRed.malaDireccionUrl{
            print("Tenes mal la url capo, cambiala")
        }
        catch ErroresDeRed.badResponse{
            print("Algo salio mal con la respuesta, revisa por favor")
        }
        catch ErroresDeRed.badStatus{
            print("Como consigues un status negativo de algo que ni siquiera se mueve")
        }
        catch ErroresDeRed.fallaAlConvertirLaRespuesta{
            print("Tienes mal el modelo o la implementación de este")
            print("En DB API")
        }
        catch ErroresDeRed.invalidRequest{
            print("Como llegaste aqui?")
        }
        catch{
            
        }
        return nil
    }
}
