//
//  PokemonAPIImpl.swift
//  CleanPokomen
//
//  Created by TI Digital on 04/07/22.
//

import Foundation
import Factory

enum APIServiceError: Error {
    case badUrl, requestError, decodingError, statusNotOK
}

struct PokemonAPIImpl: PokemonDataSource {
    @Injected(Container.urlSession) private var session
    func getPokemons(url: String) async throws -> [Pokemon] {
        guard let url = URL(string: url) else {
            throw APIServiceError.badUrl
        }
        
        guard let (data, response) = try? await session.data(from: url) else {
            throw APIServiceError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIServiceError.statusNotOK
        }
        
        guard let result = try? JSONDecoder().decode(PokemonAPIEntity.self, from: data) else {
            throw APIServiceError.decodingError
        }
        
        return result.results.map { item in
            Pokemon(name: item.name, url: item.url)
        }
     }
    
    
}
