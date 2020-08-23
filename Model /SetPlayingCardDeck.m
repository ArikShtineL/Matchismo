//
//  SetPlayingCardDeck.m
//  Matchismo
//
//  Created by Arik Shtine on 18/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "SetPlayingCardDeck.h"
#import "SetPlayingCard.h"

@implementation SetPlayingCardDeck

- (instancetype) init
{
    
    if (self = [super init]){
      for (NSString *suit in [SetPlayingCard validSuits])
      {
        for (NSUInteger rank = 1; rank <= [SetPlayingCard maxRank]; rank++)
        {
          for (NSString *color in [SetPlayingCard validColors])
          {
            for (NSString *shdowValue in [SetPlayingCard validShadowValues])
            {
              SetPlayingCard *card = [[SetPlayingCard alloc] init];
              card.rank = rank;
              card.suit = suit;
              card.color = color;
              card.shadowValue = shdowValue;
              [self addCard:card atTop:NO];
            }
          }
        }
    }
    }
    return self;
}

@end
