//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by simon rebiere on 02/04/2022.
//

import Foundation

protocol PokemonListPresenterMethods {
    func present()
}

class PokemonListPresenter: PokemonListPresenterMethods {
    
    weak var viewController: PokemonListViewMethods?
    
    init(viewController: PokemonListViewMethods) {
        self.viewController = viewController
    }
    
    func present() {
        
    }
}
