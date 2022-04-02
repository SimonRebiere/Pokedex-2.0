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
    
    var dataModel: PokemonListDataModel?
    
    let presenter: PokemonListPresenterMethods
    let servicePokemonList: PokemonListServiceMethods
    
    init(presenter: PokemonListPresenterMethods,
         servicePokemonList: PokemonListServiceMethods = PokemonListService()) {
        self.presenter = presenter
        self.servicePokemonList = servicePokemonList

        self.dataModel = nil
    }
    
    func loadData() {
        servicePokemonList.getPokemonList(additionalParams: nil, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.dataModel = PokemonListDataModel(response: response)
                guard let dataModel = self.dataModel else { return }
                print("oui")
                self.presenter.present(dataModel: dataModel)
            case .failure(let error):
                //maybe show alert or toast
                print(error)
            }
        })
    }
    
    func loadMore() {
        
    }
}

class PokemonListDataModel {
    
    var nextURL: URL?
    var pokemonList: [Pokemon]
    
    struct Pokemon {
        var name: String
        var url: URL?
    }
    
    init(response: PokemonListResponse) {
        self.nextURL = URL(string: response.next ?? "")
        //might wanna optimize that
        self.pokemonList = response.pokemonList.map( { Pokemon(name: $0.name, url: URL(string: $0.url)) } )
    }
    
    func update(with response: PokemonListResponse) {
        nextURL = URL(string: response.next ?? "")
        let newPokemons = response.pokemonList.map( { Pokemon(name: $0.name, url: URL(string: $0.url)) })
        pokemonList.append(contentsOf: newPokemons)
    }
}
