//
//  GameState.h
//  Matchismo
//
//  Created by Arik Shtine on 19/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameState : NSObject

@property (nonatomic, strong) NSMutableArray<Card*> *chosenCards;
@property (nonatomic, strong) Card *chosenCard;
@property (nonatomic, readwrite) NSInteger scoreEranedNow;


- (void)removeAllCardsFromChosenCardArray;
- (void)appendChosenCard;


@end

NS_ASSUME_NONNULL_END
