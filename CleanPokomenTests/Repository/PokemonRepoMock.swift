//
//  PokemonRepoMock.swift
//  CleanPokomenTests
//
//  Created by TI Digital on 05/07/22.
//

import Foundation
@testable import CleanPokomen

struct PokemonRepoMock: PokemonRepository {
    private let error: Error?
    init(_ error: Error? = nil) {
        self.error = error
    }
    func getPokemons() async throws -> [Pokemon] {
        if let error = error {
            throw error
        } else {
            return []
        }
    }
}
