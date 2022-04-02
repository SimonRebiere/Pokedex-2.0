//
//  PokemonListInteractor.swift
//  Pokedex
//
//  Created by simon rebiere on 02/04/2022.
//

import Foundation

protocol PokemonListInteractorMethods {
    func loadData()
    func loadMore()
}

class PokemonListInteractor: PokemonListInteractorMethods {
    
    //var dataModel
    let presenter: PokemonListPresenterMethods
    
    init(presenter: PokemonListPresenterMethods) {
        self.presenter = presenter
    }
    
    func loadData() {
        
    }
    
    func loadMore() {
        
    }
}
