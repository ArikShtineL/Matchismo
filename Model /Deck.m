//
//  Deck.m
//  Matchismo
//
//  Created by Arik Shtine on 10/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "Deck.h"


@interface Deck()
@property (strong, nonatomic) NSMutableArray<Card*>  *cards;


@end

@implementation Deck

- (instancetype)init 
{
    if (self = [super init]){
        _cards = [[NSMutableArray alloc] init];
    }
    
    return self;
}

//- (NSMutableArray *) cards
//{
//    if (!_cards) _cards = [[NSMutableArray alloc] init]; //change to non lazy
//    return _cards;
//}

- (void)addCard:(Card *)card atTop:(BOOL)atTop{
    if (atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

- (Card *) drawRandomCard{
    Card *randomCard = nil;
    
    if (self.cards.count){
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
