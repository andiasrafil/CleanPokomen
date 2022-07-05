//
//  PokemonRepositoryImpl.swift
//  CleanPokomen
//
//  Created by TI Digital on 05/07/22.
//

import Foundation

struct PokemonRepositoryImpl: PokemonRepository {
    var dataSource: PokemonDataSource
    func getPokemons() async throws -> [Pokemon] {
        return try await dataSource.getPokemons(url: "https://pokeapi.co/api/v2/pokemon/?limit=200")
    }
}
