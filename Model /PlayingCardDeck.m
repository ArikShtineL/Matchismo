//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Arik Shtine on 11/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "PlayingCardDeck.h"

@implementation PlayingCardDeck

- (instancetype) init
{
    
    if (self = [super init]){
        for (NSString *suit in [PlayingCard validSuits])
        {
            for (NSUInteger rank = 1 ; rank <= [PlayingCard maxRank]; rank++){
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:NO];
            }
        }
    }
    return self;
}

@end
