//
//  SetPlayingCardGameViewController.m
//  Matchismo
//
//  Created by Arik Shtine on 18/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "SetPlayingCardGameViewController.h"
#import "SetPlayingCardDeck.h"
#import "SetPlayingCard.h"
#import "SetCardView.h"

static int const MATCH_CARD_SET = 3;

static NSUInteger const NUMBER_OF_CARDS_IN_THE_GAME = 12;

@implementation SetPlayingCardGameViewController

- (Deck *)createDeck
{
  return [[SetPlayingCardDeck alloc] init];
}

- (void)setGameMatchNumber:(CardMatchingGame *)game
{
  game.cardMatchNumber = MATCH_CARD_SET;
}

-(UIColor *)setColor:(NSString *)colorText
{
  if ([colorText isEqualToString:@"Red"])
  {
    return [UIColor redColor];
  }
  else if ([colorText isEqualToString:@"Green"])
  {
    return [UIColor greenColor];
  }
  else
  {
    return [UIColor blueColor];
  }
}


- (void)crateDeckGameView {
  self.deckView = [[SetCardView alloc] initWithFrame: [self deckFrame]];
  [self.gameView addSubview:self.deckView];
}

- (CardView *)createCardButtonView:(CGRect)cardFrame withCard:(Card *)card{
  SetCardView *setCardView = [[SetCardView alloc] initWithFrame:[self deckFrame]];
  [setCardView updateParameters:card];
  return setCardView;
}


- (int)numberOfCardsForTheGame {
  return NUMBER_OF_CARDS_IN_THE_GAME;
}



@end
