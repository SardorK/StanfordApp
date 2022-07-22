//
//  Concentration.swift
//  StanfordApp
//
//  Created by Sardor Karshiev on 22/07/22.
//

import Foundation

class Concentration{
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func choseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFacedUp = false
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init (numberOfPairsOfCards: Int){
        for identifier in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card]
        }
    }
}
