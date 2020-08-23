//
//  Card.h
//  Matchismo
//
//  Created by Arik Shtine on 10/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

- (int)match:(NSArray *) otherCards;

-(int)costOfMatchBouns;

-(int)costOfMisMatch;

-(int)costOfChoosn;

@property (strong, nonatomic) NSString *contents;
@property (nonatomic) BOOL isChosen;
@property (nonatomic) BOOL isMatched;

@end

NS_ASSUME_NONNULL_END
