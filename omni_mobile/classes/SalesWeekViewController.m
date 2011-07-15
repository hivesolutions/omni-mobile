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

// __author__    = Lu’s Martinho <lmartinho@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

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
