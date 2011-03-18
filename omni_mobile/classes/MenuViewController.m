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

- (void)constructStructures {
    // creates an edit button and adds it to the navigation item
    UIBarButtonItem *editUiBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:nil];
    editUiBarButton.action = @selector(editButtonClicked);
    self.navigationItem.rightBarButtonItem = editUiBarButton;

    // changes the title's image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 22)];
    UIImage *logoImage = [UIImage imageNamed:@"header_logo.png"];
    [imageView setImage:logoImage];
    self.navigationItem.titleView = imageView;

    // creates the menu header items
    HMItem *title = [[HMItem alloc] initWithIdentifier:@"Tobias"];
    HMItem *subTitle = [[HMItem alloc] initWithIdentifier:@"Matias"];
    HMItem *image = [[HMItem alloc] initWithIdentifier:@"user.png"];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the users button item
    HMTableCellItem *usersItem = [[HMTableCellItem alloc] initWithIdentifier:@"users"];
    usersItem.name = NSLocalizedString(@"Users", @"Users");
    usersItem.icon = @"omni_icon_users.png";
    usersItem.highlightedIcon = @"omni_icon_users_white.png";
    usersItem.highlightable = YES;
    usersItem.accessoryType = @"disclosure_indicator";

    // creates the sales button item
    HMTableCellItem *salesItem = [[HMTableCellItem alloc] initWithIdentifier:@"sales"];
    salesItem.name = NSLocalizedString(@"Sales", @"Sales");
    salesItem.icon = @"omni_icon_sales.png";
    salesItem.highlightedIcon = @"omni_icon_sales_white.png";
    salesItem.highlightable = YES;
    salesItem.accessoryType = @"disclosure_indicator";

    // creates the highlights button item
    HMStringTableCellItem *highlightsItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"highlights"];
    highlightsItem.name = NSLocalizedString(@"Highlights", @"Highlights");
    highlightsItem.icon = @"omni_icon_highlights.png";
    highlightsItem.highlightedIcon = @"omni_icon_highlights_white.png";
    highlightsItem.highlightable = YES;
    highlightsItem.accessoryType = @"disclosure_indicator";

    // creates the notifications button item
    HMTableCellItem *notificationsItem = [[HMTableCellItem alloc] initWithIdentifier:@"notifications"];
    notificationsItem.name = NSLocalizedString(@"Notifications", @"Notifications");
    notificationsItem.icon = nil;
    notificationsItem.highlightedIcon = nil;
    notificationsItem.highlightable = NO;
    notificationsItem.accessoryType = @"switch";

    // creates the first section item group
    HMItemGroup *firstSectionItemGroup = [[HMItemGroup alloc] initWithIdentifier:@"first_section"];

    // creates the second section item group
    HMItemGroup *secondSectionItemGroup = [[HMItemGroup alloc] initWithIdentifier:@"second_section"];
    secondSectionItemGroup.description = NSLocalizedString(@"Sentence000001", @"Sentence000001");

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:title];
    [menuHeaderGroup addItem:@"subTitle" item:subTitle];
    [menuHeaderGroup addItem:@"image" item:image];

    // populates the menu
    [firstSectionItemGroup addItem:usersItem];
    [firstSectionItemGroup addItem:salesItem];
    [firstSectionItemGroup addItem:highlightsItem];
    [secondSectionItemGroup addItem:notificationsItem];

    [menuListGroup addItem:firstSectionItemGroup];
    [menuListGroup addItem:secondSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"header" item:menuHeaderGroup];
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // stores the menu item group
    self.menuItemGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [secondSectionItemGroup release];
    [firstSectionItemGroup release];
    [notificationsItem release];
    [highlightsItem release];
    [salesItem release];
    [usersItem release];
    [menuHeaderGroup release];
    [image release];
    [subTitle release];
    [title release];
}

- (void)didSelectUsersButton {
    // initializes the users view controller
    UsersViewController *usersViewController = [[UsersViewController alloc] initWithNibName:@"UsersViewController" bundle:[NSBundle mainBundle]];

    // pushes the user view controller
    [self.navigationController pushViewController:usersViewController animated:YES];

    // releases the users view controller reference
    [usersViewController release];
}

- (void) editButtonClicked {
    // toggles the table's editing mode
    if(self.editing) {
        // disables the table's editing mode
        [self setEditing:NO animated:YES];

        // changes the button's title to edit
        self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Edit", @"Edit");
    } else {
        // enables the table's editing mode
        [self setEditing:YES animated:YES];

        // changes the button's title to done
        self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Done", @"Done");
    }
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
    return;

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
