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

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize loginItemGroup = _loginItemGroup;

- (id)init {
    // calls the super
    self = [super init];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // calls the super
    [super dealloc];
}

- (void)constructStructures {
    // retrieves the background pattern image
    UIImage *backgroundPatternImage = [UIImage imageNamed:@"welcome_background.png"];

    // creates the backgroun color with the pattern image
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundPatternImage];

    // retrieves the first child as the table view
    UITableView *tableView = [self.view.subviews objectAtIndex:0];

    // sets the background color in the table view (as transparent)
    tableView.backgroundColor = [UIColor clearColor];

    // sets the view background color
    self.view.backgroundColor = backgroundColor;

    // changes the title's image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 22)];
    UIImage *logoImage = [UIImage imageNamed:@"header_logo.png"];
    [imageView setImage:logoImage];
    self.navigationItem.titleView = imageView;

    // creates the username string item
    HMStringTableCellItem *usernameItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"username"];
    usernameItem.name = nil;
    usernameItem.defaultValue = NSLocalizedString(@"Username", @"Username");

    // creates the username string item
    HMStringTableCellItem *passwordItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"password"];
    passwordItem.name = nil;
    passwordItem.defaultValue = NSLocalizedString(@"Password", @"Password");

    // creates the first section item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    firstSectionItemGroup.footer = NSLocalizedString(@"Sentence000001", @"Sentence000001");

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu
    [firstSectionItemGroup addItem:usernameItem];
    [firstSectionItemGroup addItem:passwordItem];

    [menuListGroup addItem:firstSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // stores the menu item group
    self.loginItemGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [firstSectionItemGroup release];
    [passwordItem release];
    [usernameItem release];
}

- (void)didSelectUsersButton {
    // initializes the users view controller
    UsersViewController *usersViewController = [[UsersViewController alloc] initWithNibName:@"UsersViewController" bundle:[NSBundle mainBundle]];

    // pushes the user view controller
    [self.navigationController pushViewController:usersViewController animated:YES];

    // releases the users view controller reference
    [usersViewController release];
}

- (HMNamedItemGroup *)getItemSpecification {
    return self.loginItemGroup;
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
