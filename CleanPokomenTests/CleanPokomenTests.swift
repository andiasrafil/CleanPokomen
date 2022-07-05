//
//  CleanPokomenTests.swift
//  CleanPokomenTests
//
//  Created by TI Digital on 05/07/22.
//

import XCTest
import Factory
@testable import CleanPokomen

class CleanPokomenTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Container.pokemonDS.register { PokemonMockDataSoruce(error: nil)}
    }
    
    @MainActor func testRepositorySuccess() async throws {
        let repo = Container.pokemonRepo()
        let result = try! await repo.getPokemons()
        XCTAssertTrue(!result.isEmpty)
    }
    
//    @MainActor func testRepositoryFailed() async throws {
//        Container.pokemonDS.register { PokemonMockDataSoruce(error: APIServiceError.decodingError) }
//        let repo = Container.pokemonRepo()
//        do {
//            let call = try await repo.getPokemons()
//            XCTAssertThrowsError(call)
//        } catch DecodingError.dataCorrupted(_) {
//            return
//        }
//    }
    
    @MainActor
    func testSomeThing() async throws {
        let model = ViewModel()
        await model.getPokemons()
        XCTAssertTrue(!model.pokemons.isEmpty)
    }

    @MainActor
    func testFailedDecoding() async throws {
        Container.pokemonDS.register { PokemonMockDataSoruce(error: APIServiceError.decodingError)}
        let model = Container.vm()
        await model.getPokemons()
        XCTAssertTrue(model.hasError)
    }
    @MainActor
    func testFailedNetwork() async throws {
        Container.pokemonDS.register { PokemonMockDataSoruce(error: APIServiceError.badUrl)}
        let model = Container.vm()
        await model.getPokemons()
        XCTAssertTrue(model.pokemons.isEmpty)
    }
    
    @MainActor
    func testURLSessionError() {
        let data = Data()
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=200")
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url!, statusCode: 401, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
    }

}
