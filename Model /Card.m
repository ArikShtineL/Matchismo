//
//  Card.m
//  Matchismo
//
//  Created by Arik Shtine on 10/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "Card.h"

@interface Card()

@end
@implementation Card


- (int )match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards){
        if ([card.contents isEqualToString:self.contents]){
            return 1;
        }
    }

    return score;
}

static const int MATCH_BOUNS = 4;
static const int MISMATCH_PENALTY = -2;
static const int COST_OF_CHOOSN = -1;

-(int)costOfMatchBouns
{
  return MATCH_BOUNS;
}

-(int)costOfMisMatch
{
  return MISMATCH_PENALTY;
}

-(int)costOfChoosn
{
  return COST_OF_CHOOSN;
}


@end
