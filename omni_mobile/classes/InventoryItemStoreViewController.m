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

#import "InventoryItemStoreViewController.h"

@implementation InventoryItemStoreViewController

@synthesize entity = _entity;
@synthesize identifier = _identifier;
@synthesize entityAbstraction = _entityAbstraction;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the entity
    [_entity release];

    // releases the identifier
    [_identifier release];

    // releases the entity abstraction
    [_entityAbstraction release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // calls the super
    [super initStructures];

    // creates the entity abstraction
    HMEntityAbstraction *entityAbstraction = [[HMEntityAbstraction alloc] initWithEntityDelegate:self];

    // sets the entity abstraction
    self.entityAbstraction = entityAbstraction;

    // releases the entity abstraction
    [entityAbstraction release];
}

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"inventory_lines" serializerName:@"json"];
}

- (void)changeIdentifier:(NSString *)identifier {
    // sets the identifier
    self.identifier = identifier;

    // creates the number formatter
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

    // creates the identifier number from the string
    NSNumber *identifierNumber = [numberFormatter numberFromString:identifier];

    // creates the entity for the identifier
    NSDictionary *entity = [[NSDictionary alloc] initWithObjectsAndKeys:identifierNumber, @"object_id", nil];

    // changes the entity
    [self changeEntity:entity];

    // releases the objects
    [entity release];
    [numberFormatter release];
}

- (void)changeEntity:(NSDictionary *)entity {
    // sets the entity
    self.entity = entity;

    // updates the remote
    [self updateRemote];
}

- (void)processEmpty {
    // calls the super
    [super processEmpty];

    // creates the empty remote data dictionary
    NSDictionary *emptyRemoteData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     @"", @"company_product_code",
                                     @"", @"name",
                                     nil];

    // returns the result of processing an empty remote data
    return [self processRemoteData:emptyRemoteData];
}

- (void)processRemoteData:(NSDictionary *)remoteData {
    // calls the super
    [super processRemoteData:remoteData];

    // retrieves the remote data attributes
    NSDictionary *merchandise = [remoteData objectForKey:@"merchandise"];
    NSDictionary *contactableOrganizationalHierarchyTreeNode = [remoteData objectForKey:@"contactable_organizational_hierarchy_tree_node"];
    NSNumber *stockOnHand = [remoteData objectForKey:@"stock_on_hand"];
    NSDictionary *price = [remoteData objectForKey:@"price"];
    NSDictionary *retailPrice = [remoteData objectForKey:@"retail_price"];
    NSString *merchandiseCompanyProductCode = [merchandise objectForKey:@"company_product_code"];
    NSString *storeName = [contactableOrganizationalHierarchyTreeNode objectForKey:@"name"];
    NSNumber *priceValue = [price objectForKey:@"value"];
    NSNumber *retailPriceValue = [retailPrice objectForKey:@"value"];

    // creates the title string
    NSString *titleString = [NSString stringWithFormat:@"%@ @ %@", merchandiseCompanyProductCode, storeName];

    // creates the menu header items
    HMItem *title = [[HMItem alloc] initWithIdentifier:nil];
    HMItem *subTitle = [[HMItem alloc] initWithIdentifier:titleString];
    HMItem *image = [[HMItem alloc] initWithIdentifier:@"box_building.png"];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the stock on hand string table cell
    HMStringTableCellItem *stockOnHandItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"stock_on_hand"];
    stockOnHandItem.name = NSLocalizedString(@"Stock", @"Stock");
    stockOnHandItem.description = [NSString stringWithFormat:@"%d", [stockOnHand intValue]];
    stockOnHandItem.accessoryType = @"badge_label";
    stockOnHandItem.accessoryValue = @"UN";
    stockOnHandItem.highlightable = NO;

    // creates the price string table cell
    HMStringTableCellItem *priceItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"price"];
    priceItem.name = NSLocalizedString(@"Price", @"Price");
    priceItem.description = [NSString stringWithFormat:@"%.2f", [priceValue floatValue]];
    priceItem.accessoryType = @"badge_label";
    priceItem.accessoryValue = @"EUR";
    priceItem.highlightable = NO;

    // creates the retail price string table cell
    HMStringTableCellItem *retailPriceItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"retail_price"];
    retailPriceItem.name = NSLocalizedString(@"Retail Price", @"Retail Price");
    retailPriceItem.description = [NSString stringWithFormat:@"%.2f", [retailPriceValue floatValue]];
    retailPriceItem.accessoryType = @"badge_label";
    retailPriceItem.accessoryValue = @"EUR";
    retailPriceItem.highlightable = NO;

    // creates the sections item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:title];
    [menuHeaderGroup addItem:@"subTitle" item:subTitle];
    [menuHeaderGroup addItem:@"image" item:image];

    // populates the first section item list
    [firstSectionItemGroup addItem:stockOnHandItem];
    [firstSectionItemGroup addItem:priceItem];
    [firstSectionItemGroup addItem:retailPriceItem];

    // adds the sections to the menu list
    [menuListGroup addItem:firstSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"header" item:menuHeaderGroup];
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // sets the attributes
    self.remoteGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [firstSectionItemGroup release];
    [menuListGroup release];
    [menuHeaderGroup release];
    [priceItem release];
    [retailPriceItem release];
    [stockOnHandItem release];
    [image release];
    [subTitle release];
    [title release];
}

- (NSMutableDictionary *)convertRemoteGroup {
    return nil;
}

- (void)convertRemoteGroupRead:(NSMutableDictionary *)remoteData {
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
    return YES;
}

@end
