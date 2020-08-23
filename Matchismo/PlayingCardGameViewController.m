//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Arik Shtine on 16/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "HistoryViewController.h"

static int const MATCH_CARD_DEFAULT = 2;


@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
  return [[PlayingCardDeck alloc] init];
}

- (void)setGameMatchNumber:(CardMatchingGame *)game
{
  game.cardMatchNumber = MATCH_CARD_DEFAULT;
}

- (NSMutableAttributedString *)gameStateInterpreter:(GameState *)gameState
{
  NSString *gameStateText;
  NSMutableAttributedString *gameStateAttributedString = [[NSMutableAttributedString alloc] init];
   
  if (gameState.scoreEranedNow == 0)
  {
      [gameStateAttributedString appendAttributedString: [[NSAttributedString alloc] initWithString: gameState.chosenCard.contents]];
      return gameStateAttributedString;
  }
  else if (gameState.scoreEranedNow > 0)
  {
    gameStateText =  [@"Matched " stringByAppendingString:gameState.chosenCard.contents];
    for (PlayingCard *cardToText in gameState.chosenCards)
    {
        gameStateText = [gameStateText stringByAppendingString:cardToText.contents];
    }
    gameStateText = [gameStateText stringByAppendingFormat:@" for %ld points", gameState.scoreEranedNow];
    [gameStateAttributedString appendAttributedString: [[NSAttributedString alloc] initWithString: gameStateText]];
    [gameState removeAllChosenCard];
    return gameStateAttributedString;
  }
  else
  {
    gameStateText =  @"";
    for (PlayingCard *cardToText in gameState.chosenCards)
    {
        gameStateText = [gameStateText stringByAppendingString:cardToText.contents];
    }
    gameStateText = [gameStateText stringByAppendingFormat:@" don't match %ld points penalty", gameState.scoreEranedNow];
    [gameStateAttributedString appendAttributedString: [[NSAttributedString alloc] initWithString: gameStateText]];
    [gameState removeAllChosenCard];
    [gameState appendChosenCard];
    return gameStateAttributedString;
  }
}

- (NSMutableAttributedString *)titleForCard:(Card *) card
{
  return card.isChosen ? [[NSMutableAttributedString alloc] initWithString:card.contents]: [[NSMutableAttributedString alloc] initWithString:@""];
}

- (NSString *)defualtImageForCard //abstract
{
  return @"CardBack";
}



@end
