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
        servicePokemonList.getPokemonList(queryParams: nil, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.dataModel = PokemonListDataModel(response: response)
                guard let dataModel = self.dataModel else { return }
                print("oui")
                self.presenter.presentInitialViewModel(dataModel: dataModel)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func loadMore() {
        guard let dataModel = dataModel,
              let url = dataModel.nextURL,
              let composedUrl = URLComponents(url: url , resolvingAgainstBaseURL: true),
              let params = composedUrl.queryItems
        else { return }
        
        servicePokemonList.getPokemonList(queryParams: params, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                dataModel.update(with: response)
                self.presenter.presentMorePokemon(dataModel: dataModel)
            case .failure(let error):
                print(error)
            }
        })
    }
}
