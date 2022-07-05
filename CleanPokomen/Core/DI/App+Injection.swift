//
//  App+Injection.swift
//  CleanPokomen
//
//  Created by TI Digital on 05/07/22.
//

import Foundation
import Factory
import Mocker

extension Container {
    static let pokemonDS = Factory { PokemonAPIImpl() as PokemonDataSource }
    static let pokemonRepo = Factory { PokemonRepositoryImpl(dataSource: pokemonDS()) as PokemonRepository }
    @MainActor static let vm = Factory { ViewModel() }
    static let urlSession = Factory { URLSession.shared as URLSession }
}
