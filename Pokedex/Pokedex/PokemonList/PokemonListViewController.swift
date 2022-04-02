//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by simon rebiere on 02/04/2022.
//

import Foundation
import UIKit

protocol PokemonListViewMethods: AnyObject {
    func layout(viewModel: PokemonListViewModel)
}

class PokemonListViewController: UIViewController, PokemonListViewMethods {
    
    var interactor: PokemonListInteractorMethods!
    var viewModel: PokemonListViewModel?
    
    @IBOutlet weak var pokemonListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonListCollectionView.backgroundColor = UIColor(rgb: 0xBCCAD6)

        registerCells()
        interactor.loadData()
    }
    
    func registerCells() {
        pokemonListCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        pokemonListCollectionView.register(UINib(nibName: "PokemonRowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PokemonRowCell")
    }
    
    func layout(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.pokemonListCollectionView.reloadData()
        }
    }
}

extension PokemonListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.rows.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonRowCell", for: indexPath) as? PokemonRowCollectionViewCell,
              let model = viewModel?.rows[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.configure(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: 56)
    }
}
