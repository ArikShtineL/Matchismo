//
//  SetCardView.m
//  Matchismo
//
//  Created by Arik Shtine on 24/08/2020.
//  Copyright © 2020 Arik Shtine. All rights reserved.
//

#import "SetCardView.h"
#import "SetPlayingCard.h"

@implementation SetCardView

#define SHAPE_WIDTH 0.12
#define SHAPE_HEIGHT 0.3
#define SHAPE_FACTOR 2.0

#define SQUIGGLE_FACTOR 0.8

#define DIMAOND_FACTOR 1.4

#define OVAL_FACTOR 0.35
#define OVAL_WIDTH 1.4

#define GAP_BETTWEN_LINES 3.0



#define SYMBOL_LINE_WIDTH 0.01

#define SQUIGGLE @"◼︎"
#define DIMAOND @"▲"
#define OVAL @"●"

#define UNFILLED @"-5"
#define SOLID @"-15"
#define STRIPED @"15"


- (void)drawRect:(CGRect)rect
{
    // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];

    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);

    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
  
    if (self.faceUp) {
        [[UIImage imageNamed:@"ColordCard"] drawInRect:self.bounds];
    }
    if ([self.suit isEqualToString:SQUIGGLE]) {
      for (int i = 1; i <= self.rank; ++i) {
        [self drawSquiggleAtPoint:CGPointMake(self.bounds.size.width * 0.25 * i, self.bounds.size.height * 0.5)];
      }
    }
    else if ([self.suit isEqualToString:DIMAOND]) {
      for (int i = 1; i <= self.rank; ++i) {
        [self drawDimaondAtPoint:CGPointMake(self.bounds.size.width * 0.25 * i, self.bounds.size.height * 0.5)];
      }
    }
    else if ([self.suit isEqualToString:OVAL])  {
      for (int i = 1; i <= self.rank; ++i) {
        [self drawOvalAtPoint:CGPointMake(self.bounds.size.width * 0.25 * i, self.bounds.size.height * 0.5)];
      }
    }

}


- (void)shadePath:(UIBezierPath *)path {
  if ([self.shade isEqualToString:STRIPED]) {
    [path addClip];

    UIBezierPath *linesPath = [[UIBezierPath alloc] init];
    CGFloat i = 0;
    while (i < self.bounds.size.width) {
      [linesPath moveToPoint:CGPointMake(self.bounds.size.width - i, self.bounds.size.height)];
      [linesPath addLineToPoint:CGPointMake(self.bounds.size.width - i , 0)];
      i += GAP_BETTWEN_LINES;
    }
    [[self colorToUIColor] setStroke];
    [linesPath stroke];
    
  }
  else if ([self.shade isEqualToString:SOLID]) {
    [[self colorToUIColor] setFill];
    [path fill];
  }
}


- (UIColor *)colorToUIColor {
  if ([self.color isEqualToString:@"Green"]) {
    return [UIColor greenColor];
  }
  else if ([self.color isEqualToString:@"Red"]) {
    return [UIColor redColor];
  }
  else if ([self.color isEqualToString:@"Purple"]) {
    return [UIColor purpleColor];
  }
  return [UIColor blackColor];
}

- (void)strokeColorPath:(UIBezierPath *)path {
  [[self colorToUIColor] setStroke];
  [path stroke];
}



- (void)drawOvalAtPoint:(CGPoint)point {
  CGContextSaveGState(UIGraphicsGetCurrentContext());
  
  CGFloat dx = self.bounds.size.width * SHAPE_WIDTH / OVAL_WIDTH;
  CGFloat dy = self.bounds.size.height * SHAPE_HEIGHT / SHAPE_FACTOR;
  
  CGFloat dsqy = dy * OVAL_FACTOR;
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
  
  [path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
               controlPoint:CGPointMake(point.x, point.y - dy  -  dsqy)];
  [path addLineToPoint:CGPointMake(point.x + dx, point.y + dy)];
  [path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
                controlPoint:CGPointMake(point.x, point.y + dy  +  dsqy)];
  [path closePath];
  
  [self shadePath:path];

  path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
  [self strokeColorPath:path];
  
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}


- (void)drawDimaondAtPoint:(CGPoint)point {
  CGContextSaveGState(UIGraphicsGetCurrentContext());
  
  CGFloat dx = self.bounds.size.width * SHAPE_WIDTH / SHAPE_FACTOR;
  CGFloat dy = self.bounds.size.height * SHAPE_HEIGHT / SHAPE_FACTOR;
  
  CGFloat dsqx = dx * DIMAOND_FACTOR;
  CGFloat dsqy = dy * DIMAOND_FACTOR;
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
  
  [path addLineToPoint:CGPointMake(point.x + dx, (point.y - dy) + dsqy )];
  [path addLineToPoint:CGPointMake(point.x - dx, point.y + dsqy)];
  [path addLineToPoint:CGPointMake((point.x - dx)  - dsqx, (point.y - dy) + dsqy )];
  [path closePath];
  
  [self shadePath:path];
  path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
  [self strokeColorPath:path];
  
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

 
- (void)drawSquiggleAtPoint:(CGPoint)point {
  CGContextSaveGState(UIGraphicsGetCurrentContext());

  CGFloat dx = self.bounds.size.width * SHAPE_WIDTH / SHAPE_FACTOR;
  CGFloat dy = self.bounds.size.height * SHAPE_HEIGHT / SHAPE_FACTOR;
  CGFloat dsqx = dx * SQUIGGLE_FACTOR;
  CGFloat dsqy = dy * SQUIGGLE_FACTOR;
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
  [path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
               controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
  [path addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
          controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
          controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
  [path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
               controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
  [path addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
          controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
          controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
  path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
  
  [self shadePath:path];
  path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
  [self strokeColorPath:path];
  
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)updateParameters:(Card *)card {
  SetPlayingCard *setPlayingCard = (SetPlayingCard *) card;
  self.suit = setPlayingCard.suit;
  self.rank = setPlayingCard.rank;
  self.color = setPlayingCard.color;
  self.shade = [NSString stringWithFormat:@"%@", setPlayingCard.shadowValue];
}

@end
