// Hive Mobile
// Copyright (C) 2008 Hive Solutions Lda.
//
// This file is part of Hive Mobile.
//
// Hive Mobile is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Mobile is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Mobile. If not, see <http://www.gnu.org/licenses/>.

// __author__    = Jo�o Magalh�es <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMStyledPageControl.h"

@implementation HMStyledPageControl

@synthesize currentCachePage = _currentCachePage;

- (id)init {
    // loads the dot images
    _imageActive = [UIImage imageNamed:HM_STYLED_PAGE_CONTROL_DOT_ACTIVE];
    _imageInactive = [UIImage imageNamed:HM_STYLED_PAGE_CONTROL_DOT_INACTIVE];

    // calls the super
    self = [super init];

    // returns self
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    // loads the dot images
    _imageActive = [UIImage imageNamed:HM_STYLED_PAGE_CONTROL_DOT_ACTIVE];
    _imageInactive = [UIImage imageNamed:HM_STYLED_PAGE_CONTROL_DOT_INACTIVE];

    // calls the super
    self = [super initWithFrame:frame];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // loads the dot images
    _imageActive = [UIImage imageNamed:HM_STYLED_PAGE_CONTROL_DOT_ACTIVE];
    _imageInactive = [UIImage imageNamed:HM_STYLED_PAGE_CONTROL_DOT_INACTIVE];

    // calls the super
    self = [super initWithCoder:aDecoder];

    // returns self
    return self;
}

- (void)setCurrentPage:(NSInteger)page {
    // calls the super
    [super setCurrentPage:page];

    // in case the page is already cached
    if(page == self.currentCachePage) {
        // returns immediately
        return;
    }

    // retrieves the subviews count
    NSUInteger subviewsCount = [self.subviews count];

    // iterates over all the subviews to update the images
    for(NSUInteger subviewIndex = 0; subviewIndex < subviewsCount; subviewIndex++) {
        // retrieves the current subview
        UIImageView *subview = [self.subviews objectAtIndex:subviewIndex];

        // in case the subview represents
        // the currently selected page
        if(subviewIndex == page) {
            // sets the active image in the subview
            [subview setImage:_imageActive];
        }
        // otherwise it must be not selected
        else {
            // sets the inactive image in the subview
            [subview setImage:_imageInactive];
        }
    }

    // sets the current cache page
    self.currentCachePage = page;
}

- (void)setNumberOfPages:(NSInteger)pages {
    // calls the super
    [super setNumberOfPages:pages];

    // retrieves the first subview and sets the active
    // image for it (selected page controls)
    UIImageView *subview = [self.subviews objectAtIndex:0];
    [subview setImage:_imageActive];

    // retrieves the subviews count
    NSUInteger subviewsCount = [self.subviews count];

    // iterates over all the other subviews to set the
    // inactive image (unselected page controls)
    for(NSUInteger subviewIndex = 1; subviewIndex < subviewsCount; subviewIndex++) {
        // retrieves the current subview
        UIImageView *subview = [self.subviews objectAtIndex:subviewIndex];

        // sets the inactive image in the subview
        [subview setImage:_imageInactive];
    }
}

@end
