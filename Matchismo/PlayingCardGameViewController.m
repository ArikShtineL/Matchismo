//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Arik Shtine on 16/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "MatchismoCardView.h"

static int const MATCH_CARD_DEFAULT = 2;

static NSUInteger const NUMBER_OF_CARDS_IN_THE_GAME = 30;
static NSUInteger const MAX_NUMBER_OF_CARDS_IN_THE_GAME = 30;


@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
  return [[PlayingCardDeck alloc] init];
}

- (void)setGameMatchNumber:(CardMatchingGame *)game
{
  game.cardMatchNumber = MATCH_CARD_DEFAULT;
}

- (void)crateDeckGameView {
  self.deckView = [[MatchismoCardView alloc] initWithFrame: [self deckFrame]];
  [self.gameView addSubview:self.deckView];
}

- (CardView *)createCardButtonView:(CGRect)cardFrame withCard:(Card *)card{
  MatchismoCardView *matchismoCardView = [[MatchismoCardView alloc] initWithFrame:[self deckFrame]];
  [matchismoCardView updateParameters:card];
  return matchismoCardView;
}


- (int)numberOfCardsForTheGame {
  return NUMBER_OF_CARDS_IN_THE_GAME;
}

- (int)maxNumberOfCardsForTheGame {
  return MAX_NUMBER_OF_CARDS_IN_THE_GAME;
}

- (void)flipCardsAnimation:(CardView *)cardButton withCard:(Card *)card {
  [UIView transitionWithView:cardButton duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil
                  completion:^(BOOL fin) {if (card.isMatched) [cardButton removeFromSuperview];}];
}



@end
