//
//  Card.swift
//  StanfordApp
//
//  Created by Sardor Karshiev on 22/07/22.
//

import Foundation

class Card{
    
    var isFacedUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentefier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentefier()
    }
    
}
