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

    // creates the options button view
    OptionsButtonView *optionsButton4View = [[OptionsButtonView alloc] init];

    // creates the options button view
    OptionsButtonView *optionsButton5View = [[OptionsButtonView alloc] init];

    // creates the options button view
    OptionsButtonView *optionsButton6View = [[OptionsButtonView alloc] init];

    // creates the options button view
    OptionsButtonView *optionsButton7View = [[OptionsButtonView alloc] init];

    // creates the options button view
    OptionsButtonView *optionsButton8View = [[OptionsButtonView alloc] init];

    // creates the options button view
    OptionsButtonView *optionsButton9View = [[OptionsButtonView alloc] init];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 22, 50, 50)];
    imageView.image = [UIImage imageNamed:@"box_option.png"];

    // adds the image view to the options button view
    [optionsButtonView addSubview:imageView];

    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(26, 32, 80, 100)];
    labelView.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    labelView.text = @"Inventory";
    labelView.textColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1.0];
    labelView.backgroundColor = [UIColor clearColor];
    labelView.shadowColor = [UIColor whiteColor];
    labelView.shadowOffset = CGSizeMake(0, 1);

    [optionsButtonView addSubview:labelView];



    UIImageView *image2View = [[UIImageView alloc] initWithFrame:CGRectMake(30, 22, 50, 50)];
    image2View.image = [UIImage imageNamed:@"box_down_option.png"];

    // adds the image view to the options button view
    [optionsButton2View addSubview:image2View];

    UILabel *label2View = [[UILabel alloc] initWithFrame:CGRectMake(22, 32, 80, 100)];
    label2View.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    label2View.text = @"Purchases";
    label2View.textColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1.0];
    label2View.backgroundColor = [UIColor clearColor];
    label2View.shadowColor = [UIColor whiteColor];
    label2View.shadowOffset = CGSizeMake(0, 1);

    [optionsButton2View addSubview:label2View];



    UIImageView *image3View = [[UIImageView alloc] initWithFrame:CGRectMake(26, 22, 50, 50)];
    image3View.image = [UIImage imageNamed:@"person_option.png"];

    // adds the image view to the options button view
    [optionsButton3View addSubview:image3View];

    UILabel *label3View = [[UILabel alloc] initWithFrame:CGRectMake(32, 32, 80, 100)];
    label3View.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    label3View.text = @"Users";
    label3View.textColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1.0];
    label3View.backgroundColor = [UIColor clearColor];
    label3View.shadowColor = [UIColor whiteColor];
    label3View.shadowOffset = CGSizeMake(0, 1);

    [optionsButton3View addSubview:label3View];


    UIImageView *image4View = [[UIImageView alloc] initWithFrame:CGRectMake(26, 22, 50, 50)];
    image4View.image = [UIImage imageNamed:@"building_option.png"];

    // adds the image view to the options button view
    [optionsButton4View addSubview:image4View];

    UILabel *label4View = [[UILabel alloc] initWithFrame:CGRectMake(32, 32, 80, 100)];
    label4View.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    label4View.text = @"Stores";
    label4View.textColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1.0];
    label4View.backgroundColor = [UIColor clearColor];
    label4View.shadowColor = [UIColor whiteColor];
    label4View.shadowOffset = CGSizeMake(0, 1);

    [optionsButton4View addSubview:label4View];


    // sets the initial frame
    optionsButton2View.frame = CGRectMake(106, 0, 108, 120);
    optionsButton2View.widthBorder = YES;

    // sets the initial frame
    optionsButton3View.frame = CGRectMake(214, 0, 106, 120);

    // sets the initial frame
    optionsButton4View.frame = CGRectMake(0, 111, 106, 120);
    optionsButton4View.heightBorder = YES;

    // sets the initial frame
    optionsButton5View.frame = CGRectMake(106, 111, 106, 120);
    optionsButton5View.widthBorder = YES;
    optionsButton5View.heightBorder = YES;

    // sets the initial frame
    optionsButton6View.frame = CGRectMake(214, 111, 106, 120);
    optionsButton6View.heightBorder = YES;

    // sets the initial frame
    optionsButton7View.frame = CGRectMake(0, 222, 106, 120);

    // sets the initial frame
    optionsButton8View.frame = CGRectMake(106, 222, 106, 120);
    optionsButton8View.widthBorder = YES;

    // sets the initial frame
    optionsButton9View.frame = CGRectMake(214, 222, 106, 120);

    // retrieves the scroll view
    UIScrollView *scrollView = (UIScrollView *) [self.view.subviews objectAtIndex:1];

    // sets the scroll view content size
    scrollView.contentSize = CGSizeMake(1080, 336);

    // adds the option button views
    [scrollView addSubview:optionsButtonView];
    [scrollView addSubview:optionsButton2View];
    [scrollView addSubview:optionsButton3View];
    [scrollView addSubview:optionsButton4View];
    [scrollView addSubview:optionsButton5View];
    [scrollView addSubview:optionsButton6View];
    [scrollView addSubview:optionsButton7View];
    [scrollView addSubview:optionsButton8View];
    [scrollView addSubview:optionsButton9View];

    // changes the title's image view
    UIImageView *imageHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 22)];
    UIImage *logoImage = [UIImage imageNamed:@"header_logo.png"];
    [imageHeaderView setImage:logoImage];
    self.navigationItem.titleView = imageHeaderView;

    // releases the options button view
    [optionsButtonView release];
    [optionsButton2View release];
    [optionsButton3View release];
    [optionsButton4View release];
    [optionsButton5View release];
    [optionsButton6View release];
    [optionsButton7View release];
    [optionsButton8View release];
    [optionsButton9View release];

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
