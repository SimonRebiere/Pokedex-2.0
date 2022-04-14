//
//  PokemonRowCollectionViewCell.swift
//  Pokedex
//
//  Created by simon rebiere on 02/04/2022.
//

import Foundation
import UIKit
import Kingfisher

class PokemonRowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 20
        layer.borderColor = UIColor.darkGrey.cgColor
        layer.borderWidth = 1
        
        view.backgroundColor = UIColor.shadowBlue
        imagePokemon.backgroundColor = .clear
        labelName.numberOfLines = 0
    }
    
    func configure(model: PokemonListViewModel.PokemonRow) {
        imagePokemon.kf.setImage(with: model.imageURL)
        labelName.text = model.name
        labelNumber.text = model.number
    }
    
    override func prepareForReuse() {
        imagePokemon.image = nil
        labelName.text = nil
        labelNumber.text = nil
    }
}
