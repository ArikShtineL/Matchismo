//
//  HistoryViewController.h
//  Matchismo
//
//  Created by Arik Shtine on 19/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController

@property (nonatomic,strong) NSMutableAttributedString *historyText;

- (void)setHistory:(NSMutableAttributedString *)historyText;


@end

NS_ASSUME_NONNULL_END
