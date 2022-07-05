//
//  GetPokemonUseCase.swift
//  CleanPokomen
//
//  Created by TI Digital on 05/07/22.
//

import Foundation
import Factory

enum UseCaseError: Error {
    case networkError, decodingError
}

protocol GetPokemons {
    func execute() async -> Result<[Pokemon], UseCaseError>
}

struct GetPokemonsUseCase: GetPokemons {
    @Injected(Container.pokemonRepo) private var repo
    
    func execute() async -> Result<[Pokemon], UseCaseError> {
        do {
            let pokemons = try await repo.getPokemons()
            return .success(pokemons)
        } catch(let error) {
            switch error {
            case APIServiceError.decodingError:
                return .failure(.decodingError)
            default:
                return .failure(.networkError)
            }
        }
    }
}
