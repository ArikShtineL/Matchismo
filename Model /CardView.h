//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Arik Shtine on 23/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) CGFloat faceCardScaleFactor;


- (void)pinch:(UIPinchGestureRecognizer *)gesture;
- (NSString *)rankAsString;
- (CGFloat)faceCardScaleFactor;
- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor;

@end
