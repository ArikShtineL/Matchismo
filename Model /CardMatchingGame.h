//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Arik Shtine on 11/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "GameState.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card*)cardAtIndex:(NSUInteger)index;


@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger cardMatchNumber;
@property (nonatomic) GameState *gameState;


@end

NS_ASSUME_NONNULL_END
 
