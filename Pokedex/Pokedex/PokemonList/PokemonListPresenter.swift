//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by simon rebiere on 02/04/2022.
//

import Foundation

protocol PokemonListPresenterMethods {
    func presentInitialViewModel(dataModel: PokemonListDataModel)
    func presentMorePokemon(dataModel: PokemonListDataModel)
    func presentError(error: NetworkingError)
}

final class PokemonListPresenter: PokemonListPresenterMethods {
    
    weak var viewController: PokemonListViewMethods?
    
    init(viewController: PokemonListViewMethods) {
        self.viewController = viewController
    }
    
    func presentInitialViewModel(dataModel: PokemonListDataModel) {
        let rows = generateViewModel(dataModel: dataModel)
        let viewModel = PokemonListViewModel(rows: rows)
        viewController?.layout(.initialViewModel(viewModel))
    }
    
    func presentMorePokemon(dataModel: PokemonListDataModel) {
        let rows = generateViewModel(dataModel: dataModel)
        let viewModel = PokemonListViewModel(rows: rows)
        viewController?.layout(.loadMore(viewModel))
    }
    
    private func generateViewModel(dataModel: PokemonListDataModel) -> [PokemonListViewModel.PokemonRow] {
        let rows: [PokemonListViewModel.PokemonRow] = dataModel.pokemonList.enumerated().map({ index, pokemon in
            let count = index + 1
            let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(count).png")
            return PokemonListViewModel.PokemonRow(imageURL: url, name: pokemon.name, number: "n°\(count)")
        })

        return rows
    }
    
    func presentError(error: NetworkingError) {
        let errorMessage = error.errorType.description
        viewController?.layout(.showError(errorMessage))
    }
}
