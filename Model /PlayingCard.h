//
//  PlayingCard.h
//  Matchismo
//
//  Created by Arik Shtine on 10/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCard : Card

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end

NS_ASSUME_NONNULL_END
