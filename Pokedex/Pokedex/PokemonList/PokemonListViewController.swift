//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by simon rebiere on 02/04/2022.
//

import Foundation
import UIKit

protocol PokemonListViewMethods: AnyObject {
    func layout()// mettre viewModel en parametres
}

class PokemonListViewController: UIViewController, PokemonListViewMethods {
    
    var interactor: PokemonListInteractorMethods!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }
    
    func layout() {
        
    }
}
