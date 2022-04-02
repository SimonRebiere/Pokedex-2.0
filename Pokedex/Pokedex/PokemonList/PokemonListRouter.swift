//
//  PokemonListRouter.swift
//  Pokedex
//
//  Created by simon rebiere on 02/04/2022.
//

import Foundation
import UIKit

class PokemonListRouter {
    
    static func instatiateViewController() -> UIViewController? {
        let storyboard = UIStoryboard(name: "PokemonListView", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PokemonList") as? PokemonListViewController
        else { return nil }
        let presenter = PokemonListPresenter(viewController: vc)
        let interactor = PokemonListInteractor(presenter: presenter)
        vc.interactor = interactor
        return vc
    }

}
