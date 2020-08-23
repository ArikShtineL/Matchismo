//
//  ViewController.h
//  Matchismo
//
//  Created by Arik Shtine on 10/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//
// Abstract Class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController : UIViewController


// protected for subclass
- (Deck *)createDeck; // abstract
- (void)setGameMatchNumber:(CardMatchingGame *)game;
- (NSMutableAttributedString *)gameStateInterpreter:(GameState *)gameState;



@end

