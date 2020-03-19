//
//  Concentration.swift
//  Concentration
//
//  Created by Pierre Gergis on 3/16/20.
//  Copyright © 2020 Pierre Gergis. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private(set) var score = 0
    var totalFlipCount: Int {
        return cards.reduce(0, {totalCount, card in totalCount + card.flipCount})
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]  // copied because struct
        }
        
        cards = cards.shuffled()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
                
        if index == indexOfOneAndOnlyFaceUpCard || cards[index].isMatched { return }
        
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
            if cards[matchIndex] == cards[index] {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
            score += cards[index].isMatched ? 2 : cards[index].flipCount > 0 ? -1 : 0
        } else {
            indexOfOneAndOnlyFaceUpCard = index
        }
        cards[index].flipCount += 1
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
