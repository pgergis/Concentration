//
//  ViewController.swift
//  Concentration
//
//  Created by Pierre Gergis on 3/15/20.
//  Copyright © 2020 Pierre Gergis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var themeEmoji = "🎃👻🦇🙀😱😈🍭🍬🍎🧟‍♂️"

    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
  
    @IBOutlet private weak var flipCountLabel: UITextField!
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet { updateScoreLabel() }
    }
    
    private func updateFlipCountLabel() {
          flipCountLabel.text = "Flips: \(game.totalFlipCount)"
      }
      
    private func updateScoreLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.systemOrange
        ]
        let attributedString = NSAttributedString(string: "\(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    @IBOutlet private var cardButtons: [UIButton]! {
        didSet {
            for card in cardButtons {
                card.layer.cornerRadius = 8.0
            }
            updateCardFaces()
            
        }
    }
    
    private func updateCardFaces() {
        for index in cardButtons.indices {
           let button = cardButtons[index]
           let card = game.cards[index]
           if card.isFaceUp {
               button.setTitle(emoji(for: card), for: UIControl.State.normal)
               button.backgroundColor = UIColor.systemFill
           } else {
               button.setTitle("", for: UIControl.State.normal)
               button.backgroundColor = card.isMatched ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 0) : UIColor.systemOrange
           }
       }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        updateCardFaces()
        updateScoreLabel()
        updateFlipCountLabel()
    }

    private lazy var emojiChoices = themeEmoji
    private var emoji = [Card:String]()
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    @IBAction private func resetGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = themeEmoji
        
        updateViewFromModel()
    }
}

extension Int {
    var arc4random: Int {
        if self != 0 {
            let randomInt = Int(arc4random_uniform(UInt32(abs(self))))
            let isNeg = (self < 0)
            return randomInt * (isNeg ? -1 : 1)
        } else {
            return 0
        }
    }
}
