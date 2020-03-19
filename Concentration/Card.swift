//
//  Card.swift
//  Concentration
//
//  Created by Pierre Gergis on 3/16/20.
//  Copyright © 2020 Pierre Gergis. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    var flipCount = 0
    private var identifier: Int
    
    func hash(into hasher: inout Hasher) { hasher.combine(identifier) }
        
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifer() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifer()
    }
}
