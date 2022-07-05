//
//  Pokemon.swift
//  CleanPokomen
//
//  Created by TI Digital on 04/07/22.
//

import Foundation

struct Pokemon: Identifiable {
    let id = UUID()
    let name: String
    let url: String
}
