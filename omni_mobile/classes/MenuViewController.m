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

@interface Item : NSObject {
    @private NSString *_name;
}

@property (retain) NSString *name;

@end

@interface ButtonItem : Item {
    @private NSString *_icon;
    @private int _accessoryType;
    @private UIView *_accessoryView;
    @private id _scope;
    @private SEL _handler;
}

@property (retain) NSString *icon;
@property int accessoryType;
@property (retain) UIView *accessoryView;
@property (retain) id scope;
@property SEL handler;

@end

@implementation Item

@synthesize name = _name;

- (id)init {
    
    return self;
}

- (id)initWithName:(NSString *)aName {
    [self init];
    
    // sets the attributes
    self.name = aName;

    return self;
}

@end

@implementation ButtonItem

@synthesize accessoryType = _accessoryType;
@synthesize accessoryView = _accessoryView;
@synthesize icon = _icon;
@synthesize scope = _scope;
@synthesize handler = _handler;

- (id)init {
    self = [super init];
    
    return self;
}

- (id)initWithName:(NSString *)name icon:(NSString *)icon accessoryType:(int)accessoryType accessoryView:(UIView *)accessoryView scope:(id)scope handler:(SEL)handler {
    self = [super initWithName:name];
    
    // sets the attributes
    self.accessoryType = accessoryType;
    self.accessoryView = accessoryView;
    self.icon = icon;
    self.scope = scope;
    self.handler = handler;
    
    return self;
}


@end


@implementation MenuViewController

@synthesize sectionsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // creates a notifications switch
        UISwitch *notificationsSwitch = [[UISwitch alloc] init];
        
        // creates the cells
        Item *usersItem = [[ButtonItem alloc] initWithName:@"users" icon:@"disk_32x36.png" accessoryType:UITableViewCellAccessoryDisclosureIndicator accessoryView:nil scope:self handler:@selector(didSelectUsersButton)];
        Item *salesItem = [[ButtonItem alloc] initWithName:@"sales" icon:@"disk_32x36.png" accessoryType:UITableViewCellAccessoryDisclosureIndicator accessoryView:nil scope:self handler:@selector(didSelectSalesButton)];
        Item *highlightsItem = [[ButtonItem alloc] initWithName:@"highlights" icon:@"disk_32x36.png" accessoryType:UITableViewCellAccessoryDisclosureIndicator accessoryView:nil scope:self handler:@selector(didSelectHighlightsButton)];
        Item *notificationsItem = [[ButtonItem alloc] initWithName:@"notifications" icon:@"disk_32x36.png" accessoryType:UITableViewCellAccessoryDisclosureIndicator accessoryView:notificationsSwitch scope:self handler:@selector(didSelectNotificationsButton)];
        
        // creates the table structure
        NSArray *firstSectionArray = [NSArray arrayWithObjects: usersItem, salesItem, highlightsItem, nil];
        NSArray *secondSectionArray = [NSArray arrayWithObjects: notificationsItem, nil];
        self.sectionsArray = [NSArray arrayWithObjects: firstSectionArray, secondSectionArray, nil];
        
        // releases the objects
        [notificationsSwitch release];
        [usersItem release];
        [salesItem release];
        [highlightsItem release];
        [notificationsItem release];
    }

    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didSelectUsersButton {
    NSLog(@"USERS!");
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

- (ButtonItem *)buttonItemAtSection:(NSUInteger)section atRow:(NSUInteger)row {
    // retrieves the specified section array
    NSArray *sectionArray = [self.sectionsArray objectAtIndex:section];
    
    // retrieves the button item at the specified row
    ButtonItem *buttonItem = [sectionArray objectAtIndex:row];
    
    // returns the specified button item
    return buttonItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // retrieves the sections array size
    NSInteger sectionsArraySize = [self.sectionsArray count];
    
    // returns the sections array size
    return sectionsArraySize;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // retrieves the section array
    NSArray *sectionArray = [self.sectionsArray objectAtIndex:section];
                             
    // retrieves the sections array size
    NSInteger sectionArraySize = [sectionArray count];
    
    // returns the section array size
    return sectionArraySize;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // retrieves the section and row
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    // retrieves the button item
    ButtonItem *buttonItem = [self buttonItemAtSection:section atRow:row];
    
    // tries to retrives the cell from cache (reusable)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonItem.name];
    
    // in case the cell is not defined in the cuurrent cache
    // need to create a new cell
    if (cell == nil) {
        // creates the new cell with the given reuse identifier
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buttonItem.name] autorelease];
    }
    
    // sets the button item's attributes in the cell
    cell.accessoryType = buttonItem.accessoryType;
    cell.textLabel.text = buttonItem.name;
    cell.imageView.image = [UIImage imageNamed:buttonItem.icon];
    cell.accessoryView = buttonItem.accessoryView;

    // returns the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // retrieves the section and row
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    // retrieves the button item
    ButtonItem *buttonItem = [self buttonItemAtSection:section atRow:row];
    
    // invokes the button's handler
    [buttonItem.scope performSelector:buttonItem.handler];
}

@end
