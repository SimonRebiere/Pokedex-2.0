//
//  PokemonListPresenterTests.swift
//  PokedexTests
//
//  Created by simon rebiere on 03/04/2022.
//

import XCTest
@testable import Pokedex

class PokemonListPresenterTests: XCTestCase {

    var viewController: FakePokemonListView!
    var presenter: PokemonListPresenter!
    
    override func setUp() {
        viewController = FakePokemonListView()
        presenter = PokemonListPresenter(viewController: viewController)
    }
    
    func generateFakeDataModel() -> PokemonListDataModel {
        let pokemonResponse = PokemonListResponse.Pokemon(name: "pokemon", url: "https://pokeapi.co/api/v2/pokemon/1/")
        let listResponse = [pokemonResponse, pokemonResponse]
        let response = PokemonListResponse(next: "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20", pokemonList: listResponse)
        let dataModel = PokemonListDataModel(response: response)

        return dataModel
    }
    
    func testPresentInitialViewModel() {
        let dataModel = generateFakeDataModel()
        presenter.presentInitialViewModel(dataModel: dataModel)
        
        XCTAssertEqual(2, viewController.viewModel?.rows.count)
        XCTAssertTrue(viewController.passInInitialLayout)
    }
    
    func testPresentMorePokemon() {
        let dataModel = generateFakeDataModel()
        presenter.presentMorePokemon(dataModel: dataModel)
        
        XCTAssertEqual(2, viewController.viewModel?.rows.count)
        XCTAssertTrue(viewController.passInMoreLayout)
    }
    
    func testPresentError() {
        let error = NetworkingError(errorType: .emptyData, message: "Test error message")
        presenter.presentError(error: error)
        
        XCTAssertTrue(viewController.passInShowError)
    }
}

class FakePokemonListView: PokemonListViewMethods {

    var passInInitialLayout: Bool = false
    var passInMoreLayout: Bool = false
    var passInShowError: Bool = false
    
    var viewModel: PokemonListViewModel? = nil
    
    func layout(_ layoutType: PokemonListViewLayout) {
        switch layoutType {
        case .initialViewModel(let pokemonListViewModel):
            viewModel = pokemonListViewModel
            passInInitialLayout = true
        case .loadMore(let pokemonListViewModel):
            viewModel = pokemonListViewModel
            passInMoreLayout = true
        case .showError:
            passInShowError = true
        }
    }
}
