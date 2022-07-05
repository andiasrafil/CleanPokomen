//
//  PokemonViewModel.swift
//  CleanPokomen
//
//  Created by TI Digital on 05/07/22.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    var getPokemons = GetPokemonsUseCase()
    @Published var pokemons: [Pokemon] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    func getPokemons() async {
        errorMessage = ""
        let result = await getPokemons.execute()
        switch result {
        case .success(let pokes):
            self.pokemons = pokes
        case .failure(let error):
            self.pokemons = []
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
}
