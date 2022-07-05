//
//  PokemonDataSourceTest.swift
//  CleanPokomenTests
//
//  Created by TI Digital on 05/07/22.
//

import XCTest
@testable import CleanPokomen
import Factory

class PokemonDataSourceTest: XCTestCase {
    var expectation: XCTestExpectation!

    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        Container.urlSession.register { urlSession }
        expectation = expectation(description: "Expectation")
    }
    
    func testBadURL() async throws {
        let datasource = PokemonAPIImpl()
        do {
            _ = try await datasource.getPokemons(url: "")
            XCTFail("Success response was not expected")
        } catch {
            guard let error = error as? APIServiceError else {
                XCTFail("incorrect error received")
                self.expectation.fulfill()
                return
            }
            XCTAssertEqual(error, APIServiceError.badUrl)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    
    func testDecodingError() async throws {
        let data = Data()
        let urls = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=200")
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: urls!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        let datasource = PokemonAPIImpl()
        do {
            _ = try await datasource.getPokemons(url: "https://pokeapi.co/api/v2/pokemon/?limit=200")
            XCTFail("Success response was not expected")
        } catch {
            guard let error = error as? APIServiceError else {
                XCTFail("incorrect error received")
                self.expectation.fulfill()
                return
            }
            XCTAssertEqual(error, APIServiceError.decodingError)
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testStatusNotOK() async throws {
        let data = Data()
        let urls = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=200")
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: urls!, statusCode: 300, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        let datasource = PokemonAPIImpl()
        do {
            _ = try await datasource.getPokemons(url: "https://pokeapi.co/api/v2/pokemon/?limit=200")
            XCTFail("Success response was not expected")
        } catch {
            guard let error = error as? APIServiceError else {
                XCTFail("incorrect error received")
                self.expectation.fulfill()
                return
            }
            XCTAssertEqual(error, APIServiceError.statusNotOK)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRequestError() async throws {
        MockURLProtocol.requestHandler = { request in
            throw APIServiceError.requestError
        }
        let datasource = PokemonAPIImpl()
        do {
            _ = try await datasource.getPokemons(url: "https://pokeapi.co/api/v2/pokemon/?limit=200")
            XCTFail("Success response was not expected")
        } catch {
            guard let error = error as? APIServiceError else {
                XCTFail("incorrect error received")
                self.expectation.fulfill()
                return
            }
            XCTAssertEqual(error, APIServiceError.requestError)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
