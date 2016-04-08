//
//  Pokemon.swift
//  Pokedex
//
//  Created by Abdullah A Mamun on 3/23/16.
//  Copyright © 2016 Abdullah A Mamun. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name:String!
    private var _pokedexId:Int!
    private var _description:String!
    private var _type:String!
    private var _defense:Int!
    private var _height:String!
    private var _weight:String!
    private var _attack:Int!
    private var _nextEvoText:String!
    private var _nextEvoId:String!
    private var _nextEvoLbl:String!
    private var _pokemonUrl:String!
    var name:String
        {
      return _name
    }
    var description:String
    {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type:String
    {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var defense:Int
    {
        if _defense == nil {
            _defense = 0
        }
        
        return _defense
    }
    var height:String
    {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight:String
    {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var attack:Int
    {
        if _attack == nil {
            _attack = 0
        }
        return _attack
    }
    var nextEvoText:String
    {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    var nextEvoId:String
    {
        if  _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    var nextEvoLbl:String
    {
        if _nextEvoLbl == nil {
            _nextEvoLbl = ""
        }
        return _nextEvoLbl
    }
        
    var pokedexId:Int
        {
      return _pokedexId
    }
    
    init(n:String,pkdex:Int)
    {
       _name = n
        _pokedexId = pkdex
        _pokemonUrl = "\(baseUrl)\(urlPokemon)\(self.pokedexId)/"
    }
    func downloadPokemondetails(completed:DownloadComplete)  {
        let url  = NSURL(string: _pokemonUrl)
        Alamofire.request(.GET, url!).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary <String, AnyObject>
            {
                if let weight = dict["weight"] as? String
                {
                  self._weight = weight
                }
                if let height = dict["height"] as? String
                {
                  self._height = height
                }
                if let attack = dict["attack"] as? Int
                {
                  self._attack = attack
                }
                if let defense = dict["defense"] as? Int
                {
                  self._defense = defense
                }
                print(self._height)
                print(self._weight)
                print(self._defense)
                print(self._attack)
                if let types = dict["types"] as? [Dictionary<String ,String>] where types.count > 0
                {
                    if let name = types[0]["name"]
                    {
                      self._type = name.capitalizedString
                    }
                    if types.count > 1
                    {
                        for x in 1 ..< types.count
                        {
                            if let name = types[x] ["name"]
                            {
                               self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }
                else {self._type = ""}
                print(self._type)
                if let dictArr = dict["descriptions"] as? [Dictionary<String,String>] where dictArr.count > 0
                {
                    if let url = dictArr[0]["resource_uri"]
                    {
                        let nsurl = NSURL(string: "\(baseUrl)\(url)")
                        
                     Alamofire.request(.GET, nsurl!).responseJSON{ response in
                        let desResult = response.result
                        if let desDict = desResult.value as? Dictionary<String,AnyObject>
                        {
                            if let description = desDict["description"] as? String
                            {
                              self._description = description
                                print(self._description)
                            }
                        }
                        completed()
                     }
                    }
                }else {self._description = ""}
                if let evolution = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolution.count > 0
                {
                    if let to = evolution[0]["to"] as? String
                    {
                      //mega is not found
                        if  to.rangeOfString("mega") == nil
                        {
                            if let uri = evolution[0]["resource_uri"] as? String
                            {
                             let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvoId = num
                                self._nextEvoText = to
                                if let lvl = evolution[0]["level"]  as? Int
                                {
                                  self._nextEvoLbl = "\(lvl)"
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
}