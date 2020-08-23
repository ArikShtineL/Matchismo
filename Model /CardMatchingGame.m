//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Arik Shtine on 11/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray<Card*> *cards;
@end

@implementation CardMatchingGame

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck 
{
    if (self = [super init])
    {
        if (count < _cardMatchNumber){
            return nil;
        }
        _cards = [[NSMutableArray alloc] init];
        _gameState = [[GameState alloc] init];
        for (int i= 0; i< count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                [self.cards addObject:card];
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card*)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index]: nil;
}


- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    _gameState.chosenCard = card;
    if (!card.isMatched)
    {
        if (card.isChosen)
        {
            card.isChosen = NO;
          [_gameState.chosenCards removeObject:card];
        }
        else{
            if (_gameState.chosenCards.count == _cardMatchNumber - 1)
            {
                int matchScore = [card match:_gameState.chosenCards];
                if (matchScore)
                {
                    _gameState.scoreEranedNow = matchScore * [card costOfMatchBouns];
                    self.score += _gameState.scoreEranedNow;
                    card.isMatched = YES;
                    for (Card *otherCard in _gameState.chosenCards)
                    {
                        otherCard.isMatched = YES;
                    }
                }
                else
                {
                    self.score += [card costOfMisMatch];
                    _gameState.scoreEranedNow = [card costOfMisMatch];
                    for (Card *otherCard in _gameState.chosenCards)
                    {
                        otherCard.isChosen = NO;
                    }
                    [_gameState.chosenCards addObject:card];
                }
            }
            else {
                [_gameState.chosenCards addObject:card]; 
                _gameState.scoreEranedNow = 0;
            }
            self.score += [card costOfChoosn];
            card.isChosen = YES;
        }
    }
}



@end
