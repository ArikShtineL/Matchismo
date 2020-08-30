//
//  CardView.h
//  Matchismo
//
//  Created by Arik Shtine on 23/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardView : UIView


#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) CGFloat faceCardScaleFactor;


- (NSString *)rankAsString;
- (CGFloat)faceCardScaleFactor;
- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor;
- (void)updateParameters:(Card *)card;

- (CGFloat)cornerScaleFactor;
- (CGFloat)cornerRadius;
- (CGFloat)cornerOffset;


@end
