//
//  PokemonMockDataSource.swift
//  CleanPokomen
//
//  Created by TI Digital on 05/07/22.
//

import Foundation
@testable import CleanPokemon

struct PokemonMockDataSoruce: PokemonDataSource {
    private let error: Error?
    
    init(error: Error?) {
        self.error = error
    }
    
    func getPokemons(url: String) async throws -> [Pokemon] {
        if let error = error {
            throw error
        } else {
            let data = try JSONDecoder().decode(PokemonAPIEntity.self, from: readLocalFile(forName: "pokemon")!)
            return data.results.map { item in
                Pokemon(name: item.name, url: item.url)
            }
        }
    }
}

func readLocalFile(forName name: String) -> Data? {
    let bundlePath = Bundle.main.path(forResource: name, ofType: "json")!
    let jsonData = try! String(contentsOfFile: bundlePath).data(using: .utf8)
    return jsonData
}
