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

static int const MATCH_CARD_SET = 3;

@interface SetPlayingCardGameViewController ()

@end

@implementation SetPlayingCardGameViewController

- (Deck *)createDeck
{
  return [[SetPlayingCardDeck alloc] init];
}

- (void)setGameMatchNumber:(CardMatchingGame *)game
{
  game.cardMatchNumber = MATCH_CARD_SET;
}


- (NSMutableAttributedString *)titleForCard:(Card *) card
{
  SetPlayingCard *setCard = [[SetPlayingCard alloc] init];
  if ([card isKindOfClass:[SetPlayingCard class]])
  {
      setCard = (SetPlayingCard*)card;
  }
  return [self cardContents:setCard];
}

- (NSMutableAttributedString *)cardContents:(SetPlayingCard *) setCard
{
  NSMutableAttributedString *cardContent;
  cardContent = [[NSMutableAttributedString alloc] initWithString:[[[SetPlayingCard rankStrings][setCard.rank] stringByAppendingString:@"  " ] stringByAppendingString:setCard.suit]];
  [cardContent setAttributes:@{ NSStrokeColorAttributeName: [self setColor:setCard.color], NSStrokeWidthAttributeName:setCard.shadowValue} range:NSMakeRange(0, [cardContent length])]; 
  return cardContent;
}


- (NSMutableAttributedString *)gameStateInterpreter:(GameState *)gameState
{
  NSMutableAttributedString *gameStateAttributedString = [[NSMutableAttributedString alloc] init];
  SetPlayingCard *chosenSetCard;
  if ([gameState.chosenCard isKindOfClass:[SetPlayingCard class]])
  {
      chosenSetCard = (SetPlayingCard *) gameState.chosenCard;
  }
  
   
  if (gameState.scoreEranedNow == 0 && gameState.chosenCards.count == 3)
  {
      for (SetPlayingCard *cardToText in gameState.chosenCards)
      {
        [gameStateAttributedString appendAttributedString:[self cardContents:cardToText]];
      }

      [gameStateAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" not matched!"]]];
    
      [gameState removeAllChosenCard];
      [gameState appendChosenCard];
      return gameStateAttributedString;
  }
  else if (gameState.scoreEranedNow == 0)
  {
      return [self cardContents:chosenSetCard];
  }
  else
  {
    for (SetPlayingCard *cardToText in gameState.chosenCards)
    {
      [gameStateAttributedString appendAttributedString:[self cardContents:cardToText]];
    }

    [gameStateAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" matched for %ld points", gameState.scoreEranedNow]]];
    [gameState removeAllChosenCard];

    return gameStateAttributedString;
  }
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

- (UIImage *)backGroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"ColordCard": @"CardFront"];;
}

- (NSString *)defualtImageForCard //abstract
{
  return @"CardFront";
}

@end
