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

#import "SalesWeekViewController.h"

@implementation SalesWeekViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // retrieves the application
    UIApplication *application = [UIApplication sharedApplication];

    // sets the status bar in the application to black
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];

    // casts the view as a week widget view (safe)
    HMWeekWidgetView *weekWidgetView = (HMWeekWidgetView *) self.view;

    // creates the week widget panel view 1 week items
    NSArray *weekWidgetPanelView1WeekItems = [[NSArray alloc] initWithObjects:
                                              @"Terca-Feira", @"1,500 EUR",
                                              @"Quarta-Feira", @"50 EUR",
                                              @"Quinta-Feira", @"642 EUR",
                                              @"Sexta-Feira", @"3,452 EUR",
                                              @"Sabado", @"52 EUR",
                                              @"Domingo", @"743 EUR",
                                              nil];

    // creates the week widget panel view 2 week items
    NSArray *weekWidgetPanelView2WeekItems = [[NSArray alloc] initWithObjects:
                                              @"Terca-Feira", @"1,500 EUR",
                                              @"Quarta-Feira", @"50 EUR",
                                              @"Quinta-Feira", @"642 EUR",
                                              @"Sexta-Feira", @"3,452 EUR",
                                              @"Sabado", @"52 EUR",
                                              @"Domingo", @"743 EUR",
                                              nil];

    // creates the week widget panel view
    HMWeekWidgetPanelView *weekWidgetPanelView1 = [[HMWeekWidgetPanelView alloc] initWithFrame:CGRectMake(0, 0, 320, 428)];
    weekWidgetPanelView1.title = @"Galeria da Joia";
    weekWidgetPanelView1.subTitle = @"Loja";
    weekWidgetPanelView1.value = @"127 EUR";
    weekWidgetPanelView1.image = [UIImage imageNamed:@"minus_widget.png"];
    weekWidgetPanelView1.weekItems = weekWidgetPanelView1WeekItems;

    // updates the status value in the week widget panel view
    [weekWidgetPanelView1 updateStatus];

    // adds the week widget panel view
    [weekWidgetView addWeekWidgetPanel:weekWidgetPanelView1 panelType:HMWeekWidgetRedPanel];

    // creates the week widget panel view
    HMWeekWidgetPanelView *weekWidgetPanelView2 = [[HMWeekWidgetPanelView alloc] initWithFrame:CGRectMake(0, 0, 320, 428)];
    weekWidgetPanelView2.title = @"Galeria da Joia";
    weekWidgetPanelView2.subTitle = @"Loja";
    weekWidgetPanelView2.value = @"999 EUR";
    weekWidgetPanelView2.image = [UIImage imageNamed:@"plus_widget.png"];
    weekWidgetPanelView2.weekItems = weekWidgetPanelView2WeekItems;

    // updates the status value in the week widget panel view
    [weekWidgetPanelView2 updateStatus];

    // adds the week widget panel view
    [weekWidgetView addWeekWidgetPanel:weekWidgetPanelView2 panelType:HMWeekWidgetGreenPanel];

    // releases the objects
    [weekWidgetPanelView1 release];
    [weekWidgetPanelView2 release];
    [weekWidgetPanelView1WeekItems release];
    [weekWidgetPanelView2WeekItems release];

    // returns self
    return self;
}

@end
