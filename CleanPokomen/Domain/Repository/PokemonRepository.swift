//
//  PokemonRepository.swift
//  CleanPokomen
//
//  Created by TI Digital on 05/07/22.
//

import Foundation

protocol PokemonRepository {
    func getPokemons() async throws -> [Pokemon]
}
