//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Arik Shtine on 19/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyLabel;

@end

@implementation HistoryViewController


- (void)setHistory:(NSMutableAttributedString *)historyText;
{
  _historyText = historyText;
  if (self.view.window)
  {
    [self updateUI];
  }
}

- (void)updateUI
{
  self.historyLabel.attributedText = _historyText;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self updateUI];
}


@end
