// Hive Omni ERP
// Copyright (c) 2008-2019 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2019 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "CreditsViewController.h"

@implementation CreditsViewController

@synthesize dateLabel = _dateLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // sets the view title
    self.title = NSLocalizedString(@"Credits", @"Credits");

    // retrieves the background pattern image
    UIImage *backgroundPatternImage = [UIImage imageNamedDevice:@"credits_background.png"];

    // creates the backgroun color with the pattern image
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundPatternImage];

    // creates a string representation of the date
    NSString *dateString = [[NSString alloc] initWithCString:__DATE__ encoding:NSUTF8StringEncoding];

    // sets the view background color
    self.view.backgroundColor = backgroundColor;

    // sets the date in the date label
    self.dateLabel.text = dateString;

    // releases the objects
    [dateString release];

    // returns self
    return self;
}

- (void) dealloc {
    // releases the date label
    [_dateLabel release];

    // calls the super
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
