//
//  GameState.m
//  Matchismo
//
//  Created by Arik Shtine on 19/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "GameState.h"

@implementation GameState

- (instancetype)init
{
    if (self = [super init]){
        _chosenCards = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)removeAllChosenCard
{
  [_chosenCards removeAllObjects];
}

- (void)appendChosenCard
{
  [_chosenCards addObject:_chosenCard];
}

@end
