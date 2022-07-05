//
//  PokemonDataSource.swift
//  CleanPokomen
//
//  Created by TI Digital on 04/07/22.
//

import Foundation

protocol PokemonDataSource {
    func getPokemons(url: String) async throws -> [Pokemon]
}
