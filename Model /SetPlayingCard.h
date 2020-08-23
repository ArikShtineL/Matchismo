//
//  SetPlayingCard.h
//  Matchismo
//
//  Created by Arik Shtine on 17/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetPlayingCard : Card

+ (NSArray *)validSuits;
+ (NSArray *)validShadowValues;
+ (NSArray *)validColors;
+ (NSUInteger)maxRank;
+ (NSArray *)rankStrings;

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (strong,nonatomic) NSString *shadowValue;
@property (strong,nonatomic) NSString *color;

@end

NS_ASSUME_NONNULL_END
