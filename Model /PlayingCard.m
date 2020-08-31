//
//  PlayingCard.m
//  Matchismo
//
//  Created by Arik Shtine on 10/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *) contents
{
    
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (PlayingCard *otherCard in otherCards)
    {
        if ([self.suit isEqualToString:otherCard.suit])
        {
            score += 1;
        }
        else if (self.rank == otherCard.rank)
        {
            score += 4;
        }
    }
  if (otherCards.count > 2)
  {
    for (int i = 0; i < otherCards.count - 2; i++) // chosen cards with themselves
          {
            PlayingCard *firstCard = otherCards[i];
            for (int j = i + 1; j < otherCards.count - 1; j++)
              {
                PlayingCard *secendCard = otherCards[j];
                  if ([firstCard.suit isEqualToString:secendCard.suit])
                  {
                      score += 1;
                  }
                  else if (firstCard.rank == secendCard.rank)
                  {
                      score += 4;
                  }
              }
          }
  }

    return score;
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♦", @"♠", @"♥", @"♣"];
}

+ (NSArray *)rankStrings
{
    NSArray *rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return rankStrings;
}

+ (NSUInteger)maxRank {return [self rankStrings].count -1;}

- (void) setSuit:(NSString *) suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *) suit{
    return _suit ? _suit : @"?";
}

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}
@end
