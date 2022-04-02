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
}

class PokemonListPresenter: PokemonListPresenterMethods {
    
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
        var count = 1
        var rows: [PokemonListViewModel.PokemonRow] = []

        dataModel.pokemonList.forEach({
            let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(count).png")
            rows.append(PokemonListViewModel.PokemonRow(imageURL: url, name: $0.name, number: "n°\(count)"))
            count += 1
        })
        return rows
    }
}
