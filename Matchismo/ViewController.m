//
//  ViewController.m
//  Matchismo
//
//  Created by Arik Shtine on 10/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "ViewController.h"
#import "HistoryViewController.h"


static int const MATCH_CARD_DEFAULT = 2;

@interface ViewController ()
@property (strong, nonatomic)Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (nonatomic, strong)CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong,nonatomic) NSMutableArray<NSMutableAttributedString *> *historyTextLines;

@end	

@implementation ViewController

- (Deck *)createDeck // abstract
{
    return nil;
}

- (NSMutableAttributedString *)gameStateInterpreter:(GameState *)gameState // abstract
{
  return nil;
}

- (IBAction)NewGameButton {
    [self UpdateNewUI];
}

- (void)UpdateNewUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        [cardButton setBackgroundImage:[UIImage imageNamed:[self defualtImageForCard]] forState:UIControlStateNormal];
        [cardButton setAttributedTitle: [[NSMutableAttributedString alloc] initWithString:@""] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    _deck = [self createDeck];
    _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
    [self setGameMatchNumber:_game];
    self.ScoreLabel.text = @"Score: 0";
    [_historyTextLines removeAllObjects];
    [self updateCards];
}


- (NSString *)defualtImageForCard //abstract
{
  return nil;
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI
{
  [self updateCards];
  
  [_historyTextLines addObject: [self gameStateInterpreter:_game.gameState]];
    self.ScoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}


- (void)updateCards
{
  for (UIButton *cardButton in self.cardButtons)
  {
      NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
      Card *card = [self.game cardAtIndex:cardIndex];
      [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
      [cardButton setBackgroundImage:[self backGroundImageForCard:card] forState:UIControlStateNormal];
      cardButton.enabled = !card.isMatched;
  }
}


- (NSMutableAttributedString *)titleForCard:(Card *) card // abstract
{
  return nil;
}


- (UIImage *)backGroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}


- (void)setGameMatchNumber:(CardMatchingGame *)game
{
  game.cardMatchNumber = MATCH_CARD_DEFAULT;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _deck = [self createDeck];
    _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
    [self setGameMatchNumber:_game];
    _historyTextLines = [[NSMutableArray alloc] init];
    [self updateCards];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"Show Game History"])
  {
    if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]])
    {
      HistoryViewController *historyVar = (HistoryViewController *)segue.destinationViewController;
      historyVar.historyText = [self HistoryArrayToString:_historyTextLines];
    }
  }
}

-(NSMutableAttributedString *)HistoryArrayToString:(NSMutableArray<NSMutableAttributedString *> *)historyTextArray
{
  NSMutableAttributedString *historyString = [[NSMutableAttributedString alloc] init];
  for (NSMutableAttributedString *attributedString in historyTextArray)
  {
    [historyString appendAttributedString:attributedString];
    [historyString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" \n "]];
  }
  return historyString;
}


@end
