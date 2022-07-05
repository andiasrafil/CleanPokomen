//
//  PokemonView.swift
//  CleanPokomen
//
//  Created by TI Digital on 05/07/22.
//

import SwiftUI
import Factory

struct PokemonView: View {
    @StateObject var vm = Container.vm()
    var body: some View {
        pokemonList()
    }
    
    fileprivate func pokemonList() -> some View {
        List {
            ForEach(vm.pokemons, id: \.id) { item in
                Text("nama pokemon : \(item.name)")
            }
        }
        .navigationTitle("Pokemon List")
        .task {
            await vm.getPokemons()
        }
        .alert("error", isPresented: $vm.hasError) {
            
        } message: {
            Text(vm.errorMessage)
        }
    }
}

#if !TESTING

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        let _ = Container.pokemonDS.register { PokemonMockDataSoruce(error: nil)}
        PokemonView()
    }
}
#endif
