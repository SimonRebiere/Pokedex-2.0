//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by simon rebiere on 02/04/2022.
//

import Foundation
import UIKit

enum PokemonListViewLayout {
    case initialViewModel(PokemonListViewModel)
    case loadMore(PokemonListViewModel)
    case showError(String)
}

protocol PokemonListViewMethods: AnyObject {
    func layout(_ layoutType: PokemonListViewLayout)
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
    
    func layout(_ layoutType: PokemonListViewLayout) {
        switch layoutType {
        case .initialViewModel(let pokemonListViewModel):
            self.viewModel = pokemonListViewModel
            DispatchQueue.main.async { [weak self] in
                self?.pokemonListCollectionView.reloadData()
            }
        case .loadMore(let pokemonListViewModel):
            let lastIndexToInsert = pokemonListViewModel.rows.count - 1
            guard let firstIndexToInsert = viewModel?.rows.count,
                    lastIndexToInsert > firstIndexToInsert
            else {
                layout(.initialViewModel(pokemonListViewModel))
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.pokemonListCollectionView.performBatchUpdates({
                    self?.viewModel = pokemonListViewModel
                    let indexPathes: [IndexPath] = (firstIndexToInsert...lastIndexToInsert).map {
                        return IndexPath(row: $0, section: 0)
                    }
                    self?.pokemonListCollectionView.insertItems(at: indexPathes)
                })
            }
        case .showError(let errorMessage):
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "An error happened", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
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
    
    //As in this case .count is O(1) due to RandomAccessCollection
    //https://developer.apple.com/documentation/swift/randomaccesscollection
    //I check if I'm close to the end of the loaded datas to see if I neeed to load more datas
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        
        if indexPath.row == viewModel.rows.count - 4 {
            interactor.loadMore()
        }
    }
}
