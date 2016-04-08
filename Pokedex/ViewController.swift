//
//  ViewController.swift
//  Pokedex
//
//  Created by Abdullah A Mamun on 3/23/16.
//  Copyright © 2016 Abdullah A Mamun. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {

    @IBOutlet weak var serachBar: UISearchBar!
    @IBOutlet weak var collection:UICollectionView!
    var inSearchMode = false
    var pokemon = [Pokemon]()
    var filterPokemon = [Pokemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collection.delegate = self
        collection.dataSource = self
        serachBar.delegate = self
        parsePokemonCSV()
        serachBar.returnKeyType = UIReturnKeyType.Done
        
    }
    func parsePokemonCSV()
    {
       let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do
        {
          let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows
            {
              let pokeId = Int(row["id"]!)
                let name = row["identifier"]
                let poke = Pokemon(n: name!, pkdex: pokeId!)
                pokemon.append(poke)
            }
            
        }catch let err as NSError
        {
          print(err.debugDescription)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell
        {
            let poke :Pokemon!
            if inSearchMode {
                poke = filterPokemon[indexPath.row]
            }
            else
            {
             poke = pokemon[indexPath.row]
            }
            cell.configureCell(poke)
          return cell
        }
        else
        {
          return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let poke : Pokemon!
        if inSearchMode {
            poke = filterPokemon[indexPath.row]
        }
        else
        {
          poke = pokemon[indexPath.row]
        }
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filterPokemon.count
        }
        else{
            return pokemon.count}
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""
        {
          inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        }
        else
        {
          inSearchMode = true
            let makeItLowerCase = searchBar.text!.lowercaseString
            filterPokemon = pokemon.filter({$0.name.rangeOfString(makeItLowerCase) != nil})
            collection.reloadData()
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailVC = segue.destinationViewController as? PokemonDetailVC
            {
                if let poke = sender as? Pokemon
                {
                 detailVC.pokemon = poke
                }
            }
        }
    }

}

