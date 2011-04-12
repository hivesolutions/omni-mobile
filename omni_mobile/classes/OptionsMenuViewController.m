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

// __author__    = Jo�o Magalh�es <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "OptionsMenuViewController.h"




#import "OptionsButtonView.h"

@implementation OptionsMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // creates the options button view
    OptionsButtonView *optionsButtonView = [[OptionsButtonView alloc] init];

    // creates the options button view
    OptionsButtonView *optionsButton2View = [[OptionsButtonView alloc] init];

    // creates the options button view
    OptionsButtonView *optionsButton3View = [[OptionsButtonView alloc] init];

    // sets the initial frame
    optionsButton2View.frame = CGRectMake(106, 0, 108, 120);
    optionsButton2View.widthBorder = YES;

    //optionsButton2View.backgroundColor = [UIColor greenColor];

    // sets the initial frame
    optionsButton3View.frame = CGRectMake(214, 0, 106, 120);
    //optionsButton3View.backgroundColor = [UIColor blueColor];

    // retrieves the scroll view
    UIScrollView *scrollView = (UIScrollView *) [self.view.subviews objectAtIndex:1];

    scrollView.contentSize = CGSizeMake(1000, 336);

    // adds the option button views
    [scrollView addSubview:optionsButtonView];
    [scrollView addSubview:optionsButton2View];
    [scrollView addSubview:optionsButton3View];

    // releases the options button view
    [optionsButtonView release];

    // returns self
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // retrieves the page width
    CGFloat pageWidth = scrollView.frame.size.width;

    // calculates the current page based on the current x offset
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

    // retrieves the page control
    UIPageControl *pageControl = [self.view.subviews objectAtIndex:2];

    // sets the current page
    pageControl.currentPage = page;
}

@end
