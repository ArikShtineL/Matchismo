//
//  Deck.h
//  Matchismo
//
//  Created by Arik Shtine on 10/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;
- (NSUInteger)numberOfCardsInTheDeck;

@end

NS_ASSUME_NONNULL_END
