//
//  ViewController.swift
//  Pokedex
//
//  Created by simon rebiere on 19/03/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pleaseWork()
    }
    
    func pleaseWork() {
        let service = PokemonListService()
        service.getPokemonList(completion: { response in
            print(response)
        })
    }


}

