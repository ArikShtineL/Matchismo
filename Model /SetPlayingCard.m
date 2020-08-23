//
//  SetPlayingCard.m
//  Matchismo
//
//  Created by Arik Shtine on 17/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "SetPlayingCard.h"

@implementation SetPlayingCard

static const int MATCH_BOUNS = 5;
static const int MISMATCH_PENALTY = 0;
static const int COST_OF_CHOOSN = 0;

-(int)costOfMatchBouns
{
  return MATCH_BOUNS;
}

-(int)costOfMisMatch
{
  return MISMATCH_PENALTY;
}

-(int)costOfChoosn
{
  return COST_OF_CHOOSN;
}


+ (NSArray *)validSuits
{
    return @[@"●", @"▲", @"◼︎"];
}

@synthesize suit = _suit;

- (NSString *) suit{
    return _suit ? _suit : @"?";
}

+ (NSArray *)validColors
{
    return @[@"Blue", @"Green", @"Red"];
}

+ (NSArray *)validShadowValues
{
    return @[@15, @-5, @-15];
}

+ (NSArray *)rankStrings
{
    NSArray *rankStrings = @[@"?", @"1", @"2", @"3"];
    return rankStrings;
}

+ (NSUInteger)maxRank {return [self rankStrings].count -1;}



- (int)match:(NSArray *)otherCards 
{
  SetPlayingCard *card1 = otherCards[0];
  SetPlayingCard *card2 = otherCards[1];
  BOOL rankTrueCondition = (card1.rank == card2.rank && card2.rank == _rank);
  BOOL rankFalseCondition = (card1.rank != card2.rank && card2.rank != _rank && _rank != card1.rank);
  BOOL shadowTrueCondition = (card1.shadowValue == card2.shadowValue && card2.shadowValue == _shadowValue);
  BOOL shadowFalseCondition = (card1.shadowValue != card2.shadowValue && card2.shadowValue != _shadowValue && _shadowValue != card1.shadowValue);
  BOOL colorTrueCondition = ([card1.color isEqualToString:card2.color] && [card2.color isEqualToString:_color]);
  BOOL colorFalseCondition = (![card1.color isEqualToString:card2.color] && ![card2.color isEqualToString:_color] && ![_color isEqualToString:card1.color]);
  BOOL suitTrueCondition = ([card1.suit isEqualToString:card2.suit] && [card2.suit isEqualToString:_suit]);
  BOOL suitFalseCondition = (![card1.suit isEqualToString:card2.suit] && ![card2.suit isEqualToString:_suit] && ![_suit isEqualToString:card1.suit]);


  if  ((rankTrueCondition || rankFalseCondition) &&
       (shadowTrueCondition || shadowFalseCondition) &&
       (colorTrueCondition || colorFalseCondition) &&
       (suitTrueCondition || suitFalseCondition))
  {
    return MATCH_BOUNS;
  }
    return 0;
}


@end
