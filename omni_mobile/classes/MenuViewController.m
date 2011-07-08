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

    // refreshes the login
    [self refreshLogin];
}

- (void)constructStructures {
    // initializes the background view
    [self initBackgroundView];

    // creates the logout bar button
    UIBarButtonItem *logoutBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Logout", @"Logout") style:UIBarButtonItemStylePlain target:self action: @selector(logoutButtonClicked:extra:)];

    // sets the bar buttons
    [self.navigationItem setLeftBarButtonItem:logoutBarButton animated:YES];

    // creates the account bar button
    UIBarButtonItem *accountBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Account", @"Account") style:UIBarButtonItemStylePlain target:self action: @selector(accountButtonClicked:extra:)];

    // sets the bar buttons
    [self.navigationItem setRightBarButtonItem:accountBarButton animated:YES];

    // changes the title's image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 22)];
    UIImage *logoImage = [UIImage imageNamed:@"header_logo.png"];
    [imageView setImage:logoImage];
    self.navigationItem.titleView = imageView;

    // creates the colors
    HMColor *blackColor = [[HMColor alloc] initWithColorRed:0.0 green:0.0 blue:0.0 alpha:1];
    HMColor *lightGreenColor = [[HMColor alloc] initWithColorRed:0.66 green:0.85 blue:0.36 alpha:1];
    HMColor *darkGreenColor = [[HMColor alloc] initWithColorRed:0.23 green:0.62 blue:0.27 alpha:1];
    HMColor *backgroundColor = [[HMColor alloc] initWithColorRed:0.96 green:0.96 blue:0.96 alpha:1.0];

    // creates the background colors
    NSArray *selectedBackgroundColors = [[NSArray alloc] initWithObjects:lightGreenColor, darkGreenColor, nil];

    // creates the images
    HMImage *disclosureIndicatorImage = [[HMImage alloc] initWithImageName:@"disclosure_indicator"];
    HMImage *disclosureIndicatorHighlightedImage = [[HMImage alloc] initWithImageName:@"disclosure_indicator_highlighted"];
    HMImage *personIconImage = [[HMImage alloc] initWithImageName:@"person_icon.png"];
    HMImage *personIconWhiteImage = [[HMImage alloc] initWithImageName:@"person_icon_white.png"];
    HMImage *boxUpIconImage = [[HMImage alloc] initWithImageName:@"box_up_icon.png"];
    HMImage *boxUpIconWhiteImage = [[HMImage alloc] initWithImageName:@"box_up_icon_white.png"];
    HMImage *boxDownIconImage = [[HMImage alloc] initWithImageName:@"box_down_icon.png"];
    HMImage *boxDownIconWhiteImage = [[HMImage alloc] initWithImageName:@"box_down_icon_white.png"];
    HMImage *boxIconImage = [[HMImage alloc] initWithImageName:@"box_icon.png"];
    HMImage *boxIconWhiteImage = [[HMImage alloc] initWithImageName:@"box_icon_white.png"];
    HMImage *buildingIconImage = [[HMImage alloc] initWithImageName:@"building_icon.png"];
    HMImage *buildingIconWhiteImage = [[HMImage alloc] initWithImageName:@"building_icon_white.png"];
    HMImage *megaphoneIconImage = [[HMImage alloc] initWithImageName:@"megaphone_icon.png"];
    HMImage *megaphoneIconWhiteImage = [[HMImage alloc] initWithImageName:@"megaphone_icon_white.png"];
    HMImage *creditsIconImage = [[HMImage alloc] initWithImageName:@"credits_icon.png"];
    HMImage *creditsIconWhiteImage = [[HMImage alloc] initWithImageName:@"credits_icon_white.png"];
    HMImage *dashboardIconImage = [[HMImage alloc] initWithImageName:@"dashboard_icon.png"];
    HMImage *dashboardIconWhiteImage = [[HMImage alloc] initWithImageName:@"dashboard_icon_white.png"];

    // creates the disclosure indicator accessory item
    HMAccessoryItem *disclosureIndicatorAccessoryItem = [[HMAccessoryItem alloc] init];
    disclosureIndicatorAccessoryItem.imageNormal = disclosureIndicatorImage;
    disclosureIndicatorAccessoryItem.imageHighlighted = disclosureIndicatorHighlightedImage;

    // creates the users button item
    HMTableCellItem *usersItem = [[HMTableCellItem alloc] initWithIdentifier:@"users"];
    usersItem.name = NSLocalizedString(@"Users", @"Users");
    usersItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    usersItem.nameColor = blackColor;
    usersItem.icon = personIconImage;
    usersItem.highlightedIcon = personIconWhiteImage;
    usersItem.accessory = disclosureIndicatorAccessoryItem;
    usersItem.selectable = YES;
    usersItem.selectedBackgroundColors = selectedBackgroundColors;
    usersItem.backgroundColor = backgroundColor;

    // creates the sales button item
    HMTableCellItem *salesItem = [[HMTableCellItem alloc] initWithIdentifier:@"sales"];
    salesItem.name = NSLocalizedString(@"Sales", @"Sales");
    salesItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    salesItem.nameColor = blackColor;
    salesItem.icon = boxUpIconImage;
    salesItem.highlightedIcon = boxUpIconWhiteImage;
    salesItem.accessory = disclosureIndicatorAccessoryItem;
    salesItem.selectable = YES;
    salesItem.backgroundColor = backgroundColor;
    salesItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the purchases button item
    HMTableCellItem *purchasesItem = [[HMTableCellItem alloc] initWithIdentifier:@"purchases"];
    purchasesItem.name = NSLocalizedString(@"Purchases", @"Purchases");
    purchasesItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    purchasesItem.nameColor = blackColor;
    purchasesItem.icon = boxDownIconImage;
    purchasesItem.highlightedIcon = boxDownIconWhiteImage;
    purchasesItem.accessory = disclosureIndicatorAccessoryItem;
    purchasesItem.selectable = YES;
    purchasesItem.backgroundColor = backgroundColor;
    purchasesItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the inventory button item
    HMTableCellItem *inventoryItem = [[HMTableCellItem alloc] initWithIdentifier:@"inventory"];
    inventoryItem.name = NSLocalizedString(@"Inventory", @"Inventory");
    inventoryItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    inventoryItem.nameColor = blackColor;
    inventoryItem.icon = boxIconImage;
    inventoryItem.highlightedIcon = boxIconWhiteImage;
    inventoryItem.accessory = disclosureIndicatorAccessoryItem;
    inventoryItem.selectable = YES;
    inventoryItem.backgroundColor = backgroundColor;
    inventoryItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the stores button item
    HMTableCellItem *storesItem = [[HMTableCellItem alloc] initWithIdentifier:@"stores"];
    storesItem.name = NSLocalizedString(@"Stores", @"Stores");
    storesItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    storesItem.nameColor = blackColor;
    storesItem.icon = buildingIconImage;
    storesItem.highlightedIcon = buildingIconWhiteImage;
    storesItem.accessory = disclosureIndicatorAccessoryItem;
    storesItem.selectable = YES;
    storesItem.backgroundColor = backgroundColor;
    storesItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the employees button item
    HMTableCellItem *employeesItem = [[HMTableCellItem alloc] initWithIdentifier:@"employees"];
    employeesItem.name = NSLocalizedString(@"Employees", @"Employees");
    employeesItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    employeesItem.nameColor = blackColor;
    employeesItem.icon = personIconImage;
    employeesItem.highlightedIcon = personIconWhiteImage;
    employeesItem.accessory = disclosureIndicatorAccessoryItem;
    employeesItem.selectable = YES;
    employeesItem.backgroundColor = backgroundColor;
    employeesItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the highlights button item
    HMTableCellItem *highlightsItem = [[HMTableCellItem alloc] initWithIdentifier:@"highlights"];
    highlightsItem.name = NSLocalizedString(@"Highlights", @"Highlights");
    highlightsItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    highlightsItem.nameColor = blackColor;
    highlightsItem.icon = megaphoneIconImage;
    highlightsItem.highlightedIcon = megaphoneIconWhiteImage;
    highlightsItem.accessory = disclosureIndicatorAccessoryItem;
    highlightsItem.selectable = YES;
    highlightsItem.backgroundColor = backgroundColor;
    highlightsItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the options menu button item
    HMTableCellItem *optionsMenuItem = [[HMTableCellItem alloc] initWithIdentifier:@"options_menu"];
    optionsMenuItem.name = NSLocalizedString(@"Options Menu", @"Options Menu");
    optionsMenuItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    optionsMenuItem.nameColor = blackColor;
    optionsMenuItem.icon = creditsIconImage;
    optionsMenuItem.highlightedIcon = creditsIconWhiteImage;
    optionsMenuItem.accessory = disclosureIndicatorAccessoryItem;
    optionsMenuItem.selectable = YES;
    optionsMenuItem.backgroundColor = backgroundColor;
    optionsMenuItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the sales week button item
    HMTableCellItem *salesWeekItem = [[HMTableCellItem alloc] initWithIdentifier:@"sales_week"];
    salesWeekItem.name = NSLocalizedString(@"Sales Week", @"Sales Week");
    salesWeekItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    salesWeekItem.nameColor = blackColor;
    salesWeekItem.icon = dashboardIconImage;
    salesWeekItem.highlightedIcon = dashboardIconWhiteImage;
    salesWeekItem.accessory = disclosureIndicatorAccessoryItem;
    salesWeekItem.selectable = YES;
    salesWeekItem.backgroundColor = backgroundColor;
    salesWeekItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the credits button item
    HMTableCellItem *creditsItem = [[HMTableCellItem alloc] initWithIdentifier:@"credits"];
    creditsItem.name = NSLocalizedString(@"Credits", @"Credits");
    creditsItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    creditsItem.nameColor = blackColor;
    creditsItem.icon = creditsIconImage;
    creditsItem.highlightedIcon = creditsIconWhiteImage;
    creditsItem.accessory = disclosureIndicatorAccessoryItem;
    creditsItem.selectable = YES;
    creditsItem.backgroundColor = backgroundColor;
    creditsItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the notifications button item
    HMTableCellItem *notificationsItem = [[HMTableCellItem alloc] initWithIdentifier:@"notifications"];
    notificationsItem.name = NSLocalizedString(@"Notifications", @"Notifications");
    notificationsItem.nameFont.size = MENU_VIEW_CONTROLLER_ITEM_NAME_FONT_SIZE;
    notificationsItem.nameColor = blackColor;
    notificationsItem.backgroundColor = backgroundColor;
    notificationsItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the section item groups
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];

    // customizes the second section footer item
    HMLabelItem *secondSectionFooterItem = secondSectionItemGroup.footer;
    secondSectionFooterItem.textAlignment = HMLabelItemTextAlignmentCenter;

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu
    [firstSectionItemGroup addItem:usersItem];
    [firstSectionItemGroup addItem:salesItem];
    //[firstSectionItemGroup addItem:purchasesItem];
    [firstSectionItemGroup addItem:inventoryItem];
    [firstSectionItemGroup addItem:storesItem];
    [firstSectionItemGroup addItem:employeesItem];
    //[firstSectionItemGroup addItem:highlightsItem];
    //[secondSectionItemGroup addItem:notificationsItem];
    [secondSectionItemGroup addItem:optionsMenuItem];
    [secondSectionItemGroup addItem:salesWeekItem];
    [secondSectionItemGroup addItem:creditsItem];

    // populates the menu list group
    [menuListGroup addItem:firstSectionItemGroup];
    [menuListGroup addItem:secondSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // stores the menu item group
    self.menuItemGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [secondSectionItemGroup release];
    [firstSectionItemGroup release];
    [notificationsItem release];
    [creditsItem release];
    [salesWeekItem release];
    [optionsMenuItem release];
    [highlightsItem release];
    [inventoryItem release];
    [employeesItem release];
    [storesItem release];
    [purchasesItem release];
    [salesItem release];
    [usersItem release];
    [disclosureIndicatorAccessoryItem release];
    [selectedBackgroundColors release];
    [imageView release];
    [logoutBarButton release];
    [accountBarButton release];
    [backgroundColor release];
    [darkGreenColor release];
    [lightGreenColor release];
    [blackColor release];
    [dashboardIconWhiteImage release];
    [dashboardIconImage release];
    [creditsIconWhiteImage release];
    [creditsIconImage release];
    [megaphoneIconWhiteImage release];
    [megaphoneIconImage release];
    [buildingIconWhiteImage release];
    [buildingIconImage release];
    [boxIconWhiteImage release];
    [boxIconImage release];
    [boxDownIconWhiteImage release];
    [boxDownIconImage release];
    [boxUpIconWhiteImage release];
    [boxUpIconImage release];
    [personIconWhiteImage release];
    [personIconImage release];
    [disclosureIndicatorHighlightedImage release];
    [disclosureIndicatorImage release];
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

    // creates the background view and sets it with
    // the created background color
    UIView *backgroundView = [[[UIView alloc] init] autorelease];
    backgroundView.backgroundColor = backgroundColor;

    // sets the background view in the table view
    self.tableView.backgroundView = backgroundView;
}

- (void)refreshLogin {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // retrieves the session id from the preferences
    NSString *sessionId = [preferences objectForKey:@"sessionId"];

    // in case the session id is set
    if(sessionId != nil) {
        // returns immediately
        return;
    }

    // initializes the login view controller
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];

    // pushes the login view controller
    [self presentModalViewController:loginViewController animated:YES];

    // releases the login view controller reference
    [loginViewController release];
}

- (void)logoutButtonClicked:(id)sender extra:(id)extra {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // unsets the session id in the preferences
    [preferences setValue:nil forKey:@"sessionId"];

    // unsets the session id in the preferences
    [preferences setValue:nil forKey:@"username"];

    // syncs the preferences
    [preferences synchronize];

    // refreshes the login
    [self refreshLogin];
}

- (void)accountButtonClicked:(id)sender extra:(id)extra {
    // initializes the user view controller
    UserViewController *userViewController = [[UserViewController alloc] initWithNibName:@"UserViewController" bundle:[NSBundle mainBundle]];
    userViewController.title = NSLocalizedString(@"Account", @"Account");

    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // retrieves the current user object id
    NSNumber *objectId = [preferences objectForKey:@"objectId"];

    // creates the user entity
    NSDictionary *userEntity = [NSDictionary dictionaryWithObjectsAndKeys:objectId, @"object_id", nil];

    // changes the entity to the (current) user entity
    [userViewController changeEntity:userEntity];

    // pushes the user view controller
    [self.navigationController pushViewController:userViewController animated:YES];

    // releases the user view controller reference
    [userViewController release];
}

- (void)didSelectUsersButton {
    // initializes the users view controller
    UsersViewController *usersViewController = [[UsersViewController alloc] initWithNibName:@"UsersViewController" bundle:[NSBundle mainBundle]];

    // pushes the user view controller
    [self.navigationController pushViewController:usersViewController animated:YES];

    // releases the users view controller reference
    [usersViewController release];
}

- (void)didSelectSalesButton {
    // initializes the sales view controller
    SalesViewController *salesViewController = [[SalesViewController alloc] initWithNibName:@"SalesViewController" bundle:[NSBundle mainBundle]];

    // pushes the sales view controller
    [self.navigationController pushViewController:salesViewController animated:YES];

    // releases the sales view controller reference
    [salesViewController release];
}

- (void)didSelectStoresButton {
    // initializes the stores view controller
    StoresViewController *storesViewController = [[StoresViewController alloc] initWithNibName:@"StoresViewController" bundle:[NSBundle mainBundle]];

    // pushes the store view controller
    [self.navigationController pushViewController:storesViewController animated:YES];

    // releases the stores view controller reference
    [storesViewController release];
}

- (void)didSelectInventoryButton {
    // initializes the inventory view controller
    InventoryViewController *inventoryViewController = [[InventoryViewController alloc] initWithNibName:@"InventoryViewController" bundle:[NSBundle mainBundle]];

    // pushes the inventory view controller
    [self.navigationController pushViewController:inventoryViewController animated:YES];

    // releases the users view controller reference
    [inventoryViewController release];
}

- (void)didSelectEmployeesButton {
    // initializes the employees view controller
    EmployeesViewController *employeesViewController = [[EmployeesViewController alloc] initWithNibName:@"EmployeesViewController" bundle:[NSBundle mainBundle]];

    // pushes the employees view controller
    [self.navigationController pushViewController:employeesViewController animated:YES];

    // releases the employees view controller reference
    [employeesViewController release];
}

- (void)didSelectCreditsButton {
    // initializes the credits view controller
    CreditsViewController *creditsViewController = [[CreditsViewController alloc] initWithNibName:@"CreditsViewController" bundle:[NSBundle mainBundle]];

    // pushes the credits view controller
    [self.navigationController pushViewController:creditsViewController animated:YES];

    // releases the credits view controller reference
    [creditsViewController release];
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
    if([item.identifier isEqualToString:@"users"]) {
        // calls the did select users button
        [self didSelectUsersButton];
    }
    else if([item.identifier isEqualToString:@"sales"]) {
        // calls the did select sales button
        [self didSelectSalesButton];
    }
    else if([item.identifier isEqualToString:@"inventory"]) {
        // calls the did select inventory button
        [self didSelectInventoryButton];
    }
    else if([item.identifier isEqualToString:@"stores"]) {
        // calls the did select stores button
        [self didSelectStoresButton];
    }
    else if([item.identifier isEqualToString:@"employees"]) {
        // calls the did select employees button
        [self didSelectEmployeesButton];
    }
    else if([item.identifier isEqualToString:@"options_menu"]) {
        // initializes the options menu view controller
        OptionsMenuViewController *optionsMenuViewController = [[OptionsMenuViewController alloc] initWithNibName:@"OptionsMenuViewController" bundle:[NSBundle mainBundle]];

        // pushes the options menu view controller
        [self.navigationController pushViewController:optionsMenuViewController animated:YES];

        // releases the options menu view controller reference
        [optionsMenuViewController release];
    }
    else if([item.identifier isEqualToString:@"sales_week"]) {
        // initializes the sales week view controller
        SalesWeekViewController *salesWeekViewController = [[SalesWeekViewController alloc] initWithNibName:@"SalesWeekViewController" bundle:[NSBundle mainBundle]];

        // presents the sales week view controller
        [self presentModalViewController:salesWeekViewController animated:YES];

        // releases the sales week view controller reference
        [salesWeekViewController release];
    }
    else if([item.identifier isEqualToString:@"credits"]) {
        // calls the did select credits button
        [self didSelectCreditsButton];
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
