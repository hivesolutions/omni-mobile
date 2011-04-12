// Hive Omni Erp
// Copyright (C) 2008 Hive Solutions Lda.
//
// This file is part of Hive Omni Erp.
//
// Hive Omni Erp is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Omni Erp is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Omni Erp. If not, see <http://www.gnu.org/licenses/>.

// __author__    = Jo‹o Magalh‹es <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "OptionsButtonView.h"

@implementation OptionsButtonView

@synthesize iconImage = _iconImage;

- (id)init {
    // calls the super
    self = [super init];

    // sets the initial frame
    self.frame = CGRectMake(0, 0, 106, 120);

    // retrieves the background pattern image
    UIImage *backgroundPatternImage = [UIImage imageNamed:@"menu_item_gradient.png"];

    // creates the backgroun color with the pattern image
   // UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundPatternImage];

    // sets the background color
    self.backgroundColor = [UIColor clearColor];

    // returns self
    return self;
}

- (void)drawRect:(CGRect)rect {
    // calls the super
    [super drawRect:rect];

  /*  if(self.widthBorder) {
        // retrieves the current graphics context
        CGContextRef context = UIGraphicsGetCurrentContext();

        // configures the context
        const CGColorRef grayColor = [[UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.0] CGColor];
        CGContextSetStrokeColorWithColor(context, grayColor);
        CGContextSetLineWidth(context, 1);
        CGContextSetAllowsAntialiasing(context, YES);
        CGContextSetShouldAntialias(context, YES);

        // creates the cell's border
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, 0, self.frame.size.height - 9);
        CGPathCloseSubpath(path);

        // creates the cell's border
        CGMutablePathRef path2 = CGPathCreateMutable();
        CGPathMoveToPoint(path2, NULL, self.frame.size.width, 0);
        CGPathAddLineToPoint(path2, NULL, self.frame.size.width, self.frame.size.height - 9);
        CGPathCloseSubpath(path2);

        // adds the paths
        CGContextAddPath(context, path);
        CGContextAddPath(context, path2);

        // releases the paths
        CGPathRelease(path);
        CGPathRelease(path2);

        // strokes the context
        CGContextStrokePath(context);
    }

    if(self.heightBorder) {
        // retrieves the current graphics context
        CGContextRef context = UIGraphicsGetCurrentContext();

        // configures the context
        const CGColorRef grayColor = [[UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.0] CGColor];
        CGContextSetStrokeColorWithColor(context, grayColor);
        CGContextSetLineWidth(context, 1);
        CGContextSetAllowsAntialiasing(context, YES);
        CGContextSetShouldAntialias(context, YES);

        // creates the cell's border
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, self.frame.size.width, 0);
        CGPathCloseSubpath(path);

        // creates the cell's border
        CGMutablePathRef path2 = CGPathCreateMutable();
        CGPathMoveToPoint(path2, NULL, 0, self.frame.size.height - 9);
        CGPathAddLineToPoint(path2, NULL, self.frame.size.width, self.frame.size.height - 9);
        CGPathCloseSubpath(path2);

        // adds the paths
        CGContextAddPath(context, path);
        CGContextAddPath(context, path2);

        // releases the paths
        CGPathRelease(path);
        CGPathRelease(path2);

        // strokes the context
        CGContextStrokePath(context);
    }*/
}

- (BOOL)widthBorder {
    return _widthBorder;
}

- (void)setWidthBorder:(BOOL)widthBorder {
    _widthBorder = widthBorder;

    if(widthBorder) {
        CGRect currentFrame = self.frame;
        currentFrame.size.width = 108;

        self.frame = currentFrame;
    } else {
        CGRect currentFrame = self.frame;
        currentFrame.size.width = 106;

        self.frame = currentFrame;
    }
}

- (BOOL)heightBorder {
    return _heightBorder;
}

- (void)setHeightBorder:(BOOL)heightBorder {
    _heightBorder = heightBorder;

   /* if(heightBorder) {
        CGRect currentFrame = self.frame;
        currentFrame.size.height = 108;

        self.frame = currentFrame;
    } else {
        CGRect currentFrame = self.frame;
        currentFrame.size.width = 106;

        self.frame = currentFrame;
    }*/
}

@end
