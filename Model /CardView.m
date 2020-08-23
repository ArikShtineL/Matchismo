//
//  PlayingCardView.m
//  Matchismo
//
//  Created by Arik Shtine on 23/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "CardView.h"

@interface CardView()
@property (nonatomic) CGFloat faceCardScaleFactor;


@end

@implementation CardView
//
//@synthesize _faceCardScaleFactor = faceCardScaleFactor;
//
//
//#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90
//
//- (CGFloat)faceCardScaleFactor
//{
//  if (!_faceCardScaleFactor)
//  {
//    _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
//  }
//  return _faceCardScaleFactor;
//}
//
//- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
//{
//  _faceCardScaleFactor = faceCardScaleFactor;
//  [self setNeedsDisplay];
//}





- (void)setSuit:(NSString *)suit
{
  _suit = suit;
  [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
  _rank = rank;
  [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
  _faceUp = faceUp;
  [self setNeedsDisplay];
}

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor {return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius {return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset {return [self cornerRadius] / 3.0; }


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
  UIBezierPath *roundedReact = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  
  [roundedReact addClip];
  
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [[UIColor blackColor] setStroke];
  [roundedReact stroke];
  
  if (self.faceUp)
  {
      UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
      if (faceImage)
      {
        CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0-self.faceCardScaleFactor), self.bounds.size.width *  (1.0-self.faceCardScaleFactor));
        
        [faceImage drawInRect:imageRect];
      }
      else{
    //    [self drawPips];
      }

      [self drawCorners];
  }
  else{
    [[UIImage imageNamed:@"CardBack"] drawInRect:self.bounds];
  }

}

- (NSString *) rankAsString
{
  return nil;
//  return  @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];
}

- (void)setup
{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)drawCorners
{
  NSMutableParagraphStyle *paragraphstyle = [[NSMutableParagraphStyle alloc] init];
  paragraphstyle.alignment = NSTextAlignmentCenter;
  
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
  
  NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{ NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphstyle}];
  
  CGRect textBounds;
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [cornerText size];
  [cornerText drawInRect:textBounds];
  
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
  [cornerText drawInRect:textBounds];
  
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self)
  {
    //fill
  }
  return self;
}



@end
