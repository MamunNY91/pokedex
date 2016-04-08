//
//  PokeCell.swift
//  Pokedex
//
//  Created by Abdullah A Mamun on 3/23/16.
//  Copyright © 2016 Abdullah A Mamun. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell
{
    @IBOutlet weak var thumbImg:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    var pokemon : Pokemon!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 8.0
    }
    func configureCell(pk:Pokemon)
    {
       self.pokemon = pk
        nameLbl.text = pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(pokemon.pokedexId)")
    }
}
