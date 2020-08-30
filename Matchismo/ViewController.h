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
#import "Grid.h"
#import "CardView.h"


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong, nonatomic) IBOutlet UIView *deckView; 
@property (strong, nonatomic) Grid *grid;


- (Deck *)createDeck; // abstract
- (void)setGameMatchNumber:(CardMatchingGame *)game;
- (CardView *)createCardButtonView:(CGRect)cardFrame withCard:(Card *)card;
- (void)crateDeckGameView;
- (void)updateGrid;
- (int)numberOfCardsForTheGame;
- (int)maxNumberOfCardsForTheGame;
- (CGRect)deckFrame;
- (void)flipCardsAnimation:(CardView *)cardButton withCard:(Card *)card;


@end

