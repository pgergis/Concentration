//
//  Card.swift
//  Concentration
//
//  Created by Pierre Gergis on 3/16/20.
//  Copyright © 2020 Pierre Gergis. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifer() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifer()
    }
    
    // TODO: shuffle cards
    
}
