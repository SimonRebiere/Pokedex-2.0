//
//  PokemonListInteractorTests.swift
//  PokedexTests
//
//  Created by simon rebiere on 03/04/2022.
//

import XCTest
@testable import Pokedex

class PokemonListInteractorTests: XCTestCase {
    
    var presenter: FakePokemonListPresenter!
    var service: MockPokemonListService!
    var interactor: PokemonListInteractor!
    
    override func setUp() {
        presenter = FakePokemonListPresenter()
        service = MockPokemonListService()
        interactor = PokemonListInteractor(presenter: presenter, servicePokemonList: service)
    }
    
    func testLoadData_success() {
        interactor.loadData()
        
        XCTAssertTrue(presenter.passInPresentInitial)
        XCTAssertNotNil(presenter.dataModel?.nextURL)
        XCTAssertEqual(2, presenter.dataModel?.pokemonList.count)
    }
    
    func testLoadData_async_success() {
        let expectation = XCTestExpectation()
        presenter.successExpectation = expectation
        service.isAsync = true
        interactor.loadData()
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(presenter.passInPresentInitial)
        XCTAssertNotNil(presenter.dataModel?.nextURL)
        XCTAssertEqual(2, presenter.dataModel?.pokemonList.count)
        
    }
    
    func testLoadData_failure() {
        service.shouldFail = true
        interactor.loadData()
        
        XCTAssertTrue(presenter.passInPresentError)
    }
    
    func testLoadMore_success() {
        interactor.loadData()
        interactor.loadMore()
        
        XCTAssertTrue(presenter.passInPresentMore)
        XCTAssertNotNil(presenter.dataModel?.nextURL)
        XCTAssertEqual(6, presenter.dataModel?.pokemonList.count)
    }

    
    func testLoadMore_failure() {
        interactor.loadData()
        service.shouldFail = true
        interactor.loadMore()
        
        XCTAssertFalse(presenter.passInPresentMore)
        XCTAssertTrue(presenter.passInPresentError)
        XCTAssertNotNil(presenter.dataModel?.nextURL)
        XCTAssertEqual(2, presenter.dataModel?.pokemonList.count)
    }
}


//Mock because this class will mock the data sent
class MockPokemonListService: PokemonListServiceMethods {
    
    var shouldFail: Bool = false
    var isAsync: Bool = false
    
    func getPokemonList(queryParams: [URLQueryItem]?, completion: @escaping (Result<PokemonListResponse, NetworkingError>) -> Void) {
        let pokemonResponse = PokemonListResponse.Pokemon(name: "pokemon", url: "https://pokeapi.co/api/v2/pokemon/1/")
        
        let listResponse = queryParams != nil ? [pokemonResponse, pokemonResponse, pokemonResponse, pokemonResponse] : [pokemonResponse, pokemonResponse]
        let response = PokemonListResponse(next: "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20", pokemonList: listResponse)
        
        if isAsync {
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
                completion(.success(response))
            }
        } else {
            if shouldFail {
                completion(.failure(.init(errorType: .emptyData, message: "Empty data test")))
            } else {
                completion(.success(response))
            }
        }
    }
}

//Fake because this is a fake presenter used to make sure the data is received properly
class FakePokemonListPresenter: PokemonListPresenterMethods {
    //Will be setted only when testing async
    var successExpectation: XCTestExpectation? = nil
    
    var passInPresentInitial: Bool = false
    var passInPresentMore: Bool = false
    var passInPresentError: Bool = false
    
    //Used to check that the data received is conform to what the interactor should transmit
    var dataModel: PokemonListDataModel? = nil
    
    func presentInitialViewModel(dataModel: PokemonListDataModel) {
        successExpectation?.fulfill()
        passInPresentInitial = true
        self.dataModel = dataModel
    }
    
    func presentMorePokemon(dataModel: PokemonListDataModel) {
        passInPresentMore = true
        self.dataModel = dataModel
    }
    
    func presentError(error: NetworkingError) {
        passInPresentError = true
    }
}
