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

#import "MenuViewController.h"

@implementation MenuViewController

@synthesize menuItemGroup = _menuItemGroup;

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
    // releases the menu item group
    [_menuItemGroup release];

    // calls the super
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
    // calls the super
    [super viewDidAppear:animated];

    // initializes the login view controller
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];

    // pushes the login view controller
    [self.navigationController presentModalViewController:loginViewController animated:YES];

    // releases the login view controller reference
    [loginViewController release];
}

- (void)constructStructures {
    // changes the title's image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 22)];
    UIImage *logoImage = [UIImage imageNamed:@"header_logo.png"];
    [imageView setImage:logoImage];
    self.navigationItem.titleView = imageView;

    // creates the users button item
    HMTableCellItem *usersItem = [[HMTableCellItem alloc] initWithIdentifier:@"users"];
    usersItem.name = NSLocalizedString(@"Users", @"Users");
    usersItem.icon = @"icon_users.png";
    usersItem.highlightedIcon = @"icon_users_white.png";
    usersItem.accessoryType = @"disclosure_indicator";

    // creates the sales button item
    HMTableCellItem *salesItem = [[HMTableCellItem alloc] initWithIdentifier:@"sales"];
    salesItem.name = NSLocalizedString(@"Sales", @"Sales");
    salesItem.icon = @"icon_sales.png";
    salesItem.highlightedIcon = @"icon_sales_white.png";
    salesItem.accessoryType = @"disclosure_indicator";

    // creates the purchases button item
    HMTableCellItem *purchasesItem = [[HMTableCellItem alloc] initWithIdentifier:@"purchases"];
    purchasesItem.name = NSLocalizedString(@"Purchases", @"Purchases");
    purchasesItem.icon = @"icon_purchases.png";
    purchasesItem.highlightedIcon = @"icon_purchases_white.png";
    purchasesItem.accessoryType = @"disclosure_indicator";

    // creates the inventory button item
    HMTableCellItem *inventoryItem = [[HMTableCellItem alloc] initWithIdentifier:@"inventory"];
    inventoryItem.name = NSLocalizedString(@"Inventory", @"Inventory");
    inventoryItem.icon = @"icon_inventory.png";
    inventoryItem.highlightedIcon = @"icon_inventory_white.png";
    inventoryItem.accessoryType = @"disclosure_indicator";

    // creates the highlights button item
    HMTableCellItem *highlightsItem = [[HMTableCellItem alloc] initWithIdentifier:@"highlights"];
    highlightsItem.name = NSLocalizedString(@"Highlights", @"Highlights");
    highlightsItem.icon = @"icon_highlights.png";
    highlightsItem.highlightedIcon = @"icon_highlights_white.png";
    highlightsItem.accessoryType = @"disclosure_indicator";

    // creates the notifications button item
    HMTableCellItem *notificationsItem = [[HMTableCellItem alloc] initWithIdentifier:@"notifications"];
    notificationsItem.name = NSLocalizedString(@"Notifications", @"Notifications");
    notificationsItem.highlightable = NO;
    notificationsItem.accessoryType = @"switch";

    // creates the first section item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];

    // creates the second section footer item
    HMLabelItem *secondSectionFooterItem = [[HMLabelItem alloc] initWithIdentifier:@"second_section_footer"];
    secondSectionFooterItem.description =  NSLocalizedString(@"Sentence000001", @"Sentence000001");

    // sets the footer's colors
    HMColor *secondSectionFooterTextColor = [[HMColor alloc] initRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    HMColor *secondSectionFooterShadowColor = [[HMColor alloc] initRed:0.1 green:0.1 blue:0.1 alpha:1.0];
    secondSectionFooterItem.textColor = secondSectionFooterTextColor;
    secondSectionFooterItem.shadowColor = secondSectionFooterShadowColor;

    // creates the second section item group
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];
    secondSectionItemGroup.footer = secondSectionFooterItem;

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu
    [firstSectionItemGroup addItem:usersItem];
    [firstSectionItemGroup addItem:salesItem];
    [firstSectionItemGroup addItem:purchasesItem];
    [firstSectionItemGroup addItem:inventoryItem];
    [firstSectionItemGroup addItem:highlightsItem];
    [secondSectionItemGroup addItem:notificationsItem];

    [menuListGroup addItem:firstSectionItemGroup];
    [menuListGroup addItem:secondSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // stores the menu item group
    self.menuItemGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [secondSectionFooterTextColor release];
    [secondSectionFooterShadowColor release];
    [secondSectionFooterItem release];
    [secondSectionItemGroup release];
    [firstSectionItemGroup release];
    [notificationsItem release];
    [highlightsItem release];
    [inventoryItem release];
    [purchasesItem release];
    [salesItem release];
    [usersItem release];
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
