//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Abdullah A Mamun on 4/5/16.
//  Copyright © 2016 Abdullah A Mamun. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController
{
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var desLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var defenseLbl: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    
    @IBOutlet weak var idLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    
    @IBOutlet weak var nextEvoLbl: UILabel!
    
    @IBOutlet weak var currentEvoImg: UIImageView!
    
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    @IBOutlet weak var attackLbl: UILabel!
    
    var pokemon:Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        pokemon.downloadPokemondetails {
            print("doenload complete")
            self.updateUI()
        }
        
    }
    func updateUI()
    {
       
        
          desLbl.text = pokemon.description
        
        
            typeLbl.text = pokemon.type
        
        
            defenseLbl.text = "\(pokemon.defense )"
        
        
        
            heightLbl.text = pokemon.height
        
       
            idLbl.text = "\(pokemon.pokedexId)"
        
        
            weightLbl.text = pokemon.weight
        
       
        if pokemon.nextEvoId == "" {
            nextEvoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        }
        else
        {
             nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
             nextEvoLbl.text = "Next Evolution: \(pokemon.nextEvoText)"
        }
        
            attackLbl.text = "\(pokemon.attack)"
        
        
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
