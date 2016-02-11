// Hive Omni ERP
// Copyright (c) 2008-2016 Hive Solutions Lda.
//
// This file is part of Hive Omni ERP.
//
// Hive Omni ERP is free software: you can redistribute it and/or modify
// it under the terms of the Apache License as published by the Apache
// Foundation, either version 2.0 of the License, or (at your option) any
// later version.
//
// Hive Omni ERP is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// Apache License for more details.
//
// You should have received a copy of the Apache License along with
// Hive Omni ERP. If not, see <http://www.apache.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2016 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "OptionsMenuViewController.h"

@implementation OptionsMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (void)constructStructures {
    // initializes the background view
    [self initBackgroundView];

    // changes the title's image view
    UIImageView *imageHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 22)];
    UIImage *logoImage = [UIImage imageNamed:@"header_logo.png"];
    [imageHeaderView setImage:logoImage];
    self.navigationItem.titleView = imageHeaderView;

    // creates the options button views
    HMOptionsButtonView *optionsButton1View = [[HMOptionsButtonView alloc] init];
    HMOptionsButtonView *optionsButton2View = [[HMOptionsButtonView alloc] init];
    HMOptionsButtonView *optionsButton3View = [[HMOptionsButtonView alloc] init];
    HMOptionsButtonView *optionsButton4View = [[HMOptionsButtonView alloc] init];
    HMOptionsButtonView *optionsButton5View = [[HMOptionsButtonView alloc] init];
    HMOptionsButtonView *optionsButton6View = [[HMOptionsButtonView alloc] init];
    HMOptionsButtonView *optionsButton7View = [[HMOptionsButtonView alloc] init];
    HMOptionsButtonView *optionsButton8View = [[HMOptionsButtonView alloc] init];
    HMOptionsButtonView *optionsButton9View = [[HMOptionsButtonView alloc] init];

    // sets the icon image in the options button
    optionsButton1View.iconImage = [UIImage imageNamed:@"box_option.png"];
    optionsButton1View.text = NSLocalizedString(@"Inventory", @"Inventory");

    // sets the icon image in the options button
    optionsButton2View.iconImage = [UIImage imageNamed:@"box_down_option.png"];
    optionsButton2View.text = NSLocalizedString(@"Purchases", @"Purchases");

    // sets the icon image in the options button
    optionsButton3View.iconImage = [UIImage imageNamed:@"person_option.png"];
    optionsButton3View.text = NSLocalizedString(@"Users", @"Users");

    // sets the icon image in the options button
    optionsButton4View.iconImage = [UIImage imageNamed:@"building_option.png"];
    optionsButton4View.text = NSLocalizedString(@"Stores", @"Stores");

    // sets the icon image in the options button
    optionsButton5View.iconImage = [UIImage imageNamed:@"building_option.png"];
    optionsButton5View.text = NSLocalizedString(@"Stores", @"Stores");

    // sets the icon image in the options button
    optionsButton6View.iconImage = [UIImage imageNamed:@"building_option.png"];
    optionsButton6View.text = NSLocalizedString(@"Stores", @"Stores");

    // sets the icon image in the options button
    optionsButton7View.iconImage = [UIImage imageNamed:@"building_option.png"];
    optionsButton7View.text = NSLocalizedString(@"Stores", @"Stores");

    // sets the icon image in the options button
    optionsButton8View.iconImage = [UIImage imageNamed:@"building_option.png"];
    optionsButton8View.text = NSLocalizedString(@"Stores", @"Stores");

    // sets the icon image in the options button
    optionsButton9View.iconImage = [UIImage imageNamed:@"building_option.png"];
    optionsButton9View.text = NSLocalizedString(@"Stores", @"Stores");

    // creates the button clicked selector
    [optionsButton1View addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];

    // retrieves the options view
    HMOptionsView *optionsView = (HMOptionsView *) self.view;

    // adds the option button views
    [optionsView addOptionsButton:optionsButton1View];
    [optionsView addOptionsButton:optionsButton2View];
    [optionsView addOptionsButton:optionsButton3View];
    [optionsView addOptionsButton:optionsButton4View];
    [optionsView addOptionsButton:optionsButton5View];
    [optionsView addOptionsButton:optionsButton6View];
    [optionsView addOptionsButton:optionsButton7View];
    [optionsView addOptionsButton:optionsButton8View];
    [optionsView addOptionsButton:optionsButton9View];

    // releases the options button view
    [optionsButton1View release];
    [optionsButton2View release];
    [optionsButton3View release];
    [optionsButton4View release];
    [optionsButton5View release];
    [optionsButton6View release];
    [optionsButton7View release];
    [optionsButton8View release];
    [optionsButton9View release];
    [imageHeaderView release];
}

- (void)initBackgroundView {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // retrieves the background image
    NSNumber *backgroundImage = [preferences valueForKey:@"backgroundImage"];

    // in case the background image is not enabled
    if(backgroundImage.intValue == 0) {
        // returns immediately
        return;
    }

    // sets the background color in the view
    UIImage *backgroundPatternImage = [UIImage imageNamedDevice:@"linen_shadow_background.png"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundPatternImage];

    // sets the background color in the view
    self.view.backgroundColor = backgroundColor;
}

- (void)buttonClicked {
    NSLog(@"Button Clicked");
}

- (void)addOptionsButtonView:(HMOptionsButtonView *)optionsButtonView {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
