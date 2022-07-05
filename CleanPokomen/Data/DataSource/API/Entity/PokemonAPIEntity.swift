//
//  PokemonAPIEntity.swift
//  CleanPokomen
//
//  Created by TI Digital on 04/07/22.
//

import Foundation

// MARK: - PokemonEntity
struct PokemonAPIEntity: Codable {
    let count: Int
    let next, previous: String?
    let results: [PokemonResult]
}

// MARK: - Result
struct PokemonResult: Codable {
    let name: String
    let url: String
}
