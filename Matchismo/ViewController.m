//
//  ViewController.m
//  Matchismo
//
//  Created by Arik Shtine on 10/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "ViewController.h"



static int const MATCH_CARD_DEFAULT = 2;

@interface ViewController ()
@property (strong, nonatomic)Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *cardsViewsInTheGame;
@property (strong, nonatomic) UIDynamicAnimator *cardMoveAnimator;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;
@property (strong, nonatomic) CardView *gatheredUpCardsIntoPile;

@end	

@implementation ViewController

- (IBAction)tapToFlipCard:(UITapGestureRecognizer *)sender {
  if (self.gatheredUpCardsIntoPile) {
    self.gatheredUpCardsIntoPile = nil;
    for (int i = 1; i < self.cardsViewsInTheGame.count; ++i) {
      CardView *cardview = self.cardsViewsInTheGame[i];
      cardview.alpha = 1;
  }
    [self reOrderCards];
  }
  else if ([sender.view isKindOfClass:[CardView class]]) {
    CardView *cardView = (CardView *)sender.view;
    NSUInteger cardIndex = [self.cardsViewsInTheGame indexOfObject:cardView];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
  }
}

- (IBAction)AddCardsButton {
  for (int i = 0; i < self.game.cardMatchNumber ; ++i) {
    [self takeCardOutFromDeck:[self deckFrame]];
  }
  if ([self.game.deck numberOfCardsInTheDeck] == 0) {
    [self.deckView removeFromSuperview];
  }
  [self reOrderCards];
}

- (Deck *)createDeck // abstract
{
    return nil;
}

- (IBAction)NewGameButton {
    [self UpdateNewUI];
}

- (void)UpdateNewUI
{
    _game = [[CardMatchingGame alloc] initWithCardCount:[self numberOfCardsForTheGame] usingDeck:[self createDeck]];
  
    [self returnTheCardToDeck];
    [self.deckView removeFromSuperview];
    [self.cardsViewsInTheGame removeAllObjects];
    [self distributecardsFromDeckAtTheStart];
    [self setGameMatchNumber:_game];
    self.ScoreLabel.text = @"Score: 0";
    [self crateDeckGameView];
}

- (void)returnTheCardToDeck {
  for (CardView *cardView in self.cardsViewsInTheGame) {
      [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        cardView.frame = [self deckFrame];
      } completion:^ (BOOL fin){ if (fin) [cardView removeFromSuperview];}];
  }
}

- (void)updateDeckViewSize {
  self.deckView.frame = [self deckFrame];
}


- (void)updateUI
{
    [self updateCards];
    [self reOrderCards];
    self.ScoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    if ([self.game.deck numberOfCardsInTheDeck] == 0) {
      self.deckView = nil;
      [self.deckView removeFromSuperview];
  }
}


- (void)updateCards
{
  for (int cardIndex = 0; cardIndex < self.cardsViewsInTheGame.count; ++cardIndex)
  {
    Card *card = [self.game cardAtIndex:cardIndex];
    CardView *cardButton = self.cardsViewsInTheGame[cardIndex];
    if (card.isChosen && !cardButton.faceUp) {
        cardButton.faceUp = YES;
        [self flipCardsAnimation:cardButton withCard:card];
    }
    else if (!card.isChosen && cardButton.faceUp){
      cardButton.faceUp = NO;
      [self flipCardsAnimation:cardButton withCard:card];
    }
    if (card.isMatched) {
      [cardButton removeFromSuperview];
      [self.cardsViewsInTheGame removeObjectAtIndex:cardIndex];
      [self.game.cards removeObject:card];
    }
    }
  }


- (void)flipCardsAnimation:(CardView *)cardButton withCard:(Card *)card{
  //abstract
}


- (void)setGameMatchNumber:(CardMatchingGame *)game
{
  game.cardMatchNumber = MATCH_CARD_DEFAULT;
}


- (void)updateGrid {
  self.grid.cellAspectRatio = 2.0/3.0;
  self.grid.size = CGSizeMake(self.gameView.bounds.size.width * 0.8, self.gameView.bounds.size.height * 0.8);
  self.grid.minimumNumberOfCells = [self.game numberOfCardInTheGame];
}

- (void)crateDeckGameView {
  // abstract
}


- (void)takeCardOutFromDeck:(CGRect)cardFrame {
  Card *card =  [self.game addCardToGame];
  if (card) {
    [self addCardButtonView:cardFrame withCard:card];
  }
}


- (void)addCardButtonView:(CGRect)cardFrame withCard:(Card *)card {
  CardView *cardView = [self createCardButtonView:cardFrame withCard:card];
  [self.cardsViewsInTheGame addObject:cardView];
  [self.gameView addSubview:cardView];
  [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
    cardView.frame = cardFrame;
  } completion:nil];
  
  [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToFlipCard:)]];
  [cardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchCards:)]];
}

- (IBAction)dragCardsByPanGsesture:(UIPanGestureRecognizer *)sender {
  if (self.gatheredUpCardsIntoPile) {
    CGPoint gesturePoint = [sender locationInView:self.gameView];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
      [self attachCardToPointView:gesturePoint];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
      self.attachment.anchorPoint = gesturePoint;
    }
  }

}

- (void)attachCardToPointView:(CGPoint)anchorPoint {
  if (self.gatheredUpCardsIntoPile) {
    self.attachment =
    [[UIAttachmentBehavior alloc] initWithItem:self.gatheredUpCardsIntoPile attachedToAnchor:anchorPoint];
    [self.cardMoveAnimator addBehavior:self.attachment];
  }
}


- (IBAction)pinchCards:(UIPinchGestureRecognizer *)sender {

  if ((sender.state == UIGestureRecognizerStateEnded)) {
    self.gatheredUpCardsIntoPile = [self.cardsViewsInTheGame firstObject];
      for (int i = 1; i < self.cardsViewsInTheGame.count; ++i) {
      CardView *cardview = self.cardsViewsInTheGame[i];
      [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        cardview.frame = [self.grid frameOfCellAtRow:self.grid.columnCount / 2 inColumn:self.grid.rowCount / 2];
      } completion:^(BOOL fin) {if (fin) cardview.alpha = 0;}];
    }
    self.gatheredUpCardsIntoPile.frame =
    [self.grid frameOfCellAtRow:self.grid.columnCount / 2 inColumn:self.grid.rowCount / 2];
  }
}


- (CardView *)createCardButtonView:(CGRect)cardFrame withCard:(Card *)card{
  return nil;
}

- (int)numberOfCardsForTheGame {
  return 0; //abstract
}

- (void)distributecardsFromDeckAtTheStart {
  [self updateGrid];
  for (int i = 0; i < self.game.cards.count; ++i) {
    NSUInteger cellRow = i / self.grid.columnCount;
    NSUInteger cellColumn = i % self.grid.columnCount;
    Card *card = self.game.cards[i];
    [self addCardButtonView:[self.grid frameOfCellAtRow:cellRow inColumn:cellColumn] withCard:card];
  }
}

- (void)reOrderCards {
  [self updateGrid];
  [self updateDeckViewSize];
  for (int i = 0; i < self.cardsViewsInTheGame.count; ++i) {
    NSUInteger cellRow = i / self.grid.columnCount;
    NSUInteger cellColumn = i % self.grid.columnCount;
    CardView *cardview = self.cardsViewsInTheGame[i];
    [UIView animateWithDuration:1.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
      cardview.frame = [self.grid frameOfCellAtRow:cellRow inColumn:cellColumn];
    } completion:nil];
  }
}

-(CGRect)deckFrame {
  return CGRectMake(self.gameView.bounds.size.width * 0.9, self.gameView.bounds.size.height * 0.85,
                    self.grid.cellSize.width, self.grid.cellSize.height);
}

- (void)viewDidLayoutSubviews {
  [self reOrderCards];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _game = [[CardMatchingGame alloc] initWithCardCount:[self numberOfCardsForTheGame] usingDeck:[self createDeck]];
    _cardsViewsInTheGame = [[NSMutableArray alloc] init];
    _grid = [[Grid alloc] init];
    [self updateGrid];

    _cardMoveAnimator = [[UIDynamicAnimator  alloc] initWithReferenceView:self.gameView];

    [self crateDeckGameView];
    [self distributecardsFromDeckAtTheStart];
  
    [self setGameMatchNumber:_game];
}

@end
