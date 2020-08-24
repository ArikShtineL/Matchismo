//
//  ViewController.m
//  SuperCard
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "TempViewController.h"
#import "CardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface TempViewController ()
@property (weak, nonatomic) IBOutlet CardView *playingCardView;
@property (strong, nonatomic) Deck *deck;
@end

@implementation TempViewController

- (Deck *)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)drawRandomPlayingCard
{
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.playingCardView.rank = playingCard.rank;
        self.playingCardView.suit = playingCard.suit;
    }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    if (!self.playingCardView.faceUp) [self drawRandomPlayingCard];
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.playingCardView.suit = @"♥";
    self.playingCardView.rank = 12;
  self.playingCardView.faceUp = YES;
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
}

@end
