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
@synthesize lastSelectedIndexPath = _lastSelectedIndexPath;

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
    [super dealloc];
}

- (void)startStructures {
    // changes the title's image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 22)];
    UIImage *logoImage = [UIImage imageNamed:@"header_logo.png"];
    [imageView setImage:logoImage];
    self.navigationItem.titleView = imageView;

    // creates the button items
    HMButtonItem *usersItem = [[HMButtonItem alloc] initWithName:@"users" icon:@"omni_icon_users.png" selectedIcon:@"omni_icon_users_white.png" handler:@selector(didSelectUsersButton) scope:self];
    HMButtonItem *salesItem = [[HMButtonItem alloc] initWithName:@"sales" icon:@"omni_icon_sales.png" selectedIcon:@"omni_icon_sales_white.png" handler:@selector(didSelectSalesButton) scope:self];
    HMButtonItem *highlightsItem = [[HMButtonItem alloc] initWithName:@"highlights" icon:@"omni_icon_highlights.png" selectedIcon:@"omni_icon_highlights_white.png" handler:@selector(didSelectHighlightsButton) scope:self];
    HMButtonItem *notificationsItem = [[HMButtonItem alloc] initWithName:@"notifications" icon:nil selectedIcon:nil handler:@selector(didSelectNotificationsButton) scope:self];

    // creates the item groups
    HMItemGroup *menuItemGroup = [[HMItemGroup alloc] initWithName:@"menu" description:nil];
    HMItemGroup *firstSectionItemGroup = [[HMItemGroup alloc] initWithName:@"first_section" description:nil];
    HMItemGroup *secondSectionItemGroup = [[HMItemGroup alloc] initWithName:@"second_section" description:@"New data will be pushed to your phone from the server"];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    // invokes the parent function
    [super viewWillAppear:animated];
    
    // deselects the last selected cell
    if(self.lastSelectedIndexPath) {
        [self tableView:self.tableView didDeselectRowAtIndexPath:self.lastSelectedIndexPath];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didSelectUsersButton {
    // initializes the users view controller
    UsersViewController *usersViewController = [[UsersViewController alloc] initWithNibName:@"UsersViewController" bundle:[NSBundle mainBundle]];

    // pushes the users view controller into the navigation controller
    [self.navigationController pushViewController:usersViewController animated:YES];

    // releases the users view controller reference
    [usersViewController release];
}

- (void)didSelectSalesButton {
    NSLog(@"SALES!");
}

- (void)didSelectHighlightsButton {
    NSLog(@"HIGHLIGHTS!");
}

- (void)didSelectNotificationsButton {
    NSLog(@"NOTIFICATIONS!");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // retrieves the menu item group items size
    NSInteger menuItemGroupItemsSize = [self.menuItemGroup.items count];

    // returns the menu item group items size
    return menuItemGroupItemsSize;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the section item group
    HMItemGroup *sectionItemGroup = (HMItemGroup *) [self.menuItemGroup getItem:indexPath];

    // retrieves the section item group items count
    NSInteger sectionItemGroupItemsCount = [sectionItemGroup.items count];

    // releases the index path
    [indexPath release];
    
    // returns the section item group items count
    return sectionItemGroupItemsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // retrieves the button item
    HMButtonItem *buttonItem = (HMButtonItem *) [self.menuItemGroup getItem:indexPath];

    // tries to retrives the cell from cache (reusable)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonItem.name];

    // in case the cell is not defined in the cuurrent cache
    // need to create a new cell
    if (cell == nil) {
        // creates the new cell with the given reuse identifier
        cell = [[[HMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buttonItem.name] autorelease];
    }

    // sets the button item's attributes in the cell
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = buttonItem.name;

    cell.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];

    // sets the icon in case it is defined
    if(buttonItem.icon) {
        cell.imageView.image = [UIImage imageNamed:buttonItem.icon];
    }

    // sets the notifications switch
    if(indexPath.section == 1) {
        UISwitch *notificationsSwitch = [[UISwitch alloc] init];
        cell.accessoryView = notificationsSwitch;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [notificationsSwitch release];
    }

    // returns the cell
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the section item group
    HMItemGroup *sectionItemGroup = (HMItemGroup *) [self.menuItemGroup getItem:indexPath];
    
    // releases the index path
    [indexPath release];
    
    // returns the section's description
    return sectionItemGroup.description;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // stores this as the last selected index path
    self.lastSelectedIndexPath = indexPath;
    
    // retrieves the button item
    HMButtonItem *buttonItem = (HMButtonItem *) [self.menuItemGroup getItem:indexPath];

    // retrieves the selected cell
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    // changes the cell's icon
    UIImage *iconImage = [UIImage imageNamed:buttonItem.selectedIcon];
    cell.imageView.image = iconImage;

    // invokes the button's handler
    [buttonItem.scope performSelector:buttonItem.handler];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // clears the last selected index path
    self.lastSelectedIndexPath = nil;
    
    // retrieves the button item
    HMButtonItem *buttonItem = (HMButtonItem *) [self.menuItemGroup getItem:indexPath];

    // retrieves the deselected cell
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    // changes the cell's icon
    UIImage *iconImage = [UIImage imageNamed:buttonItem.icon];
    cell.imageView.image = iconImage;
}

@end
