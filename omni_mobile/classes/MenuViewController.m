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

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "UsersViewController.h"

#import "MenuViewController.h"

@implementation MenuViewController

@synthesize menuItemGroup = _menuItemGroup;

- (id)init {
    // calls the super
    self = [super init];

    // starts the structures
    [self startStructures];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // starts the structures
    [self startStructures];

    // returns self
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // starts the structures
    [self startStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // calls the super
    [super dealloc];
}

- (void)startStructures {
    // changes the title's image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 22)];
    UIImage *logoImage = [UIImage imageNamed:@"header_logo.png"];
    [imageView setImage:logoImage];
    self.navigationItem.titleView = imageView;

    // creates the button items
    HMButtonItem *usersItem = [[HMButtonItem alloc] initWithIdentifier:@"users" name:NSLocalizedString(@"Users", @"Users") icon:@"omni_icon_users.png" highlightedIcon:@"omni_icon_users_white.png"];
    HMButtonItem *salesItem = [[HMButtonItem alloc] initWithIdentifier:@"sales" name:NSLocalizedString(@"Sales", @"Sales") icon:@"omni_icon_sales.png" highlightedIcon:@"omni_icon_sales_white.png"];
    HMButtonItem *highlightsItem = [[HMButtonItem alloc] initWithIdentifier:@"highlights" name:NSLocalizedString(@"Highlights", @"Highlights") icon:@"omni_icon_highlights.png" highlightedIcon:@"omni_icon_highlights_white.png"];
    HMButtonItem *notificationsItem = [[HMButtonItem alloc] initWithIdentifier:@"notifications" name:NSLocalizedString(@"Notifications", @"Notifications") icon:nil highlightedIcon:nil];

    // creates the item groups
    HMItemGroup *menuItemGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu" name:nil description:nil];
    HMItemGroup *firstSectionItemGroup = [[HMItemGroup alloc] initWithIdentifier:@"first_section" name:nil description:nil];
    HMItemGroup *secondSectionItemGroup = [[HMItemGroup alloc] initWithIdentifier:@"second_section" name:nil description:NSLocalizedString(@"Sentence000001", @"Sentence000001")];

    // populates the menu
    [menuItemGroup addItem:firstSectionItemGroup];
    [menuItemGroup addItem:secondSectionItemGroup];
    [firstSectionItemGroup addItem:usersItem];
    [firstSectionItemGroup addItem:salesItem];
    [firstSectionItemGroup addItem:highlightsItem];
    [secondSectionItemGroup addItem:notificationsItem];

    // stores the menu item group
    self.menuItemGroup = menuItemGroup;

    // releases the objects
    [menuItemGroup release];
    [firstSectionItemGroup release];
    [secondSectionItemGroup release];
    [usersItem release];
    [salesItem release];
    [highlightsItem release];
    [notificationsItem release];
}

- (void)didSelectUsersButton {
    // initializes the users view controller
    UsersViewController *usersViewController = [[UsersViewController alloc] initWithNibName:@"UsersViewController" bundle:[NSBundle mainBundle]];

    // fade out
    //[UIView beginAnimations:@"Fade Out" context:nil];
    //[UIView setAnimationDelay:0];
    //[UIView setAnimationDuration:0.5];
    //self.tableView.alpha = 0.0;
    //[UIView commitAnimations];

    // fade in
    //[UIView beginAnimations:@"Fade In" context:nil];
    //[UIView setAnimationDelay:0.5];
    //[UIView setAnimationDuration:0.5];
    //self.tableView.alpha = 1.0;
    //[UIView commitAnimations];

    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.5];
    [self.navigationController pushViewController:usersViewController animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];

    // releases the users view controller reference
    [usersViewController release];
}

- (HMItemGroup *)getItemSpecification {
    return self.menuItemGroup;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didSelectItemRowWithItem:(HMItem *)item {
    if(item.identifier == @"users") {
        [self didSelectUsersButton];
    }
    else {
        // initializes the menu view controller
        MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:[NSBundle mainBundle]];

        // pushes the menu view controller into the navigation controller
        [self.navigationController pushViewController:menuViewController animated:YES];

        // releases the menu view controller reference
        [menuViewController release];
    }
}

- (void)didDeselectItemRowWithItem:(HMItem *)item {
}

@end
