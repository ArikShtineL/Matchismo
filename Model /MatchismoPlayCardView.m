//
//  MatchismoPlayCardView.m
//  Matchismo
//
//  Created by Arik Shtine on 23/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "MatchismoPlayCardView.h"
#import "ViewController.h"

@implementation MatchismoPlayCardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSString *) rankAsString
{
  return  @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];
}


@end
