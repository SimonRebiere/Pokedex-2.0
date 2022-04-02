//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by simon rebiere on 02/04/2022.
//

import Foundation

protocol PokemonListPresenterMethods {
    func present(dataModel: PokemonListDataModel)
}

class PokemonListPresenter: PokemonListPresenterMethods {
    
    weak var viewController: PokemonListViewMethods?
    
    init(viewController: PokemonListViewMethods) {
        self.viewController = viewController
    }
    
    func present(dataModel: PokemonListDataModel) {
        var count = 1
        var rows: [PokemonListViewModel.PokemonRow] = []

        dataModel.pokemonList.forEach({
            let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(count).png")
            rows.append(PokemonListViewModel.PokemonRow(imageURL: url, name: $0.name, number: "n°\(count)"))
            count += 1
        })
        
        let viewModel = PokemonListViewModel(rows: rows)
        viewController?.layout(viewModel: viewModel)
    }
}

struct PokemonListViewModel {
    struct PokemonRow {
        var imageURL: URL?
        var name: String
        var number: String
    }
    
    let rows: [PokemonRow]
}
