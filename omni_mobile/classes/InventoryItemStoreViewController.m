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

@synthesize identifier = _identifier;

- (NSString *)getTitle {
    return NSLocalizedString(@"Inventory Line", @"Inventory Line");
}

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"inventory_lines" serializerName:@"json"];
}

- (void)processEmpty {
    // calls the super
    [super processEmpty];

    // creates the empty remote data dictionary
    NSDictionary *emptyRemoteData = [[NSDictionary alloc] init];

    // processes the empty remote data
    [self processRemoteData:emptyRemoteData];

    // releases the objects
    [emptyRemoteData release];
}

- (void)processRemoteData:(NSDictionary *)remoteData {
    // calls the super
    [super processRemoteData:remoteData];

    // retrieves the remote data attributes
    NSDictionary *merchandise = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"merchandise"]);
    NSDictionary *contactableOrganizationalHierarchyTreeNode = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"contactable_organizational_hierarchy_tree_node"]);
    NSNumber *stockOnHand = AVOID_NULL_NUMBER([remoteData objectForKey:@"stock_on_hand"]);
    NSDictionary *price = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"price"]);
    NSDictionary *retailPrice = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"retail_price"]);
    NSString *merchandiseCompanyProductCode = AVOID_NULL([merchandise objectForKey:@"company_product_code"]);
    NSString *storeName = AVOID_NULL([contactableOrganizationalHierarchyTreeNode objectForKey:@"name"]);
    NSNumber *priceValue = AVOID_NULL_NUMBER([price objectForKey:@"value"]);
    NSNumber *retailPriceValue = AVOID_NULL_NUMBER([retailPrice objectForKey:@"value"]);

    // creates the colors
    HMColor *backgroundColor = [[HMColor alloc] initWithColorRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    HMColor *descriptionColor = [[HMColor alloc] initWithColorRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    HMColor *descriptionColorHighlighted = [[HMColor alloc] initWithColorRed:0.54 green:0.56 blue:0.62 alpha:1.0];

    // creates the images
    HMImage *badgeImage = [[HMImage alloc] initWithImageName:@"badge" leftCap:4 topCap:4];
    HMImage *badgeHighlightedImage = [[HMImage alloc] initWithImageName:@"badge_highlighted" leftCap:4 topCap:4];

    // creates the unit accessory item
    HMAccessoryItem *unitAccessoryItem = [[HMAccessoryItem alloc] init];
    unitAccessoryItem.description = @"UN";
    unitAccessoryItem.descriptionColor = descriptionColor;
    unitAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    unitAccessoryItem.imageNormal = badgeImage;
    unitAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the currency accessory item
    HMAccessoryItem *priceCurrencyAccessoryItem = [[HMAccessoryItem alloc] init];
    priceCurrencyAccessoryItem.description = @"EUR";
    priceCurrencyAccessoryItem.descriptionColor = descriptionColor;
    priceCurrencyAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    priceCurrencyAccessoryItem.imageNormal = badgeImage;
    priceCurrencyAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the currency accessory item
    HMAccessoryItem *retailPriceCurrencyAccessoryItem = [[HMAccessoryItem alloc] init];
    retailPriceCurrencyAccessoryItem.description = @"EUR";
    retailPriceCurrencyAccessoryItem.descriptionColor = descriptionColor;
    retailPriceCurrencyAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    retailPriceCurrencyAccessoryItem.imageNormal = badgeImage;
    retailPriceCurrencyAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the title item
    HMStringTableCellItem *titleItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"title"];
    titleItem.description = merchandiseCompanyProductCode;
    titleItem.clearable = YES;
    titleItem.backgroundColor = backgroundColor;

    // creates the subtitle item
    HMStringTableCellItem *subTitleItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"subTitle"];
    subTitleItem.description = storeName;
    subTitleItem.clearable = YES;
    subTitleItem.backgroundColor = backgroundColor;

    // creates the image item
    HMItem *imageItem = [[HMItem alloc] initWithIdentifier:@"image"];
    imageItem.description = @"box_building_header.png";

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the stock on hand string table cell
    HMStringTableCellItem *stockOnHandItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"stock_on_hand"];
    stockOnHandItem.name = NSLocalizedString(@"Stock", @"Stock");
    stockOnHandItem.nameAlignment = HMTextAlignmentRight;
    stockOnHandItem.description = [NSString stringWithFormat:@"%d", stockOnHand.intValue];
    stockOnHandItem.accessory = unitAccessoryItem;
    stockOnHandItem.backgroundColor = backgroundColor;

    // creates the price string table cell
    HMConstantStringTableCellItem *priceItem = [[HMConstantStringTableCellItem alloc] initWithIdentifier:@"price"];
    priceItem.name = NSLocalizedString(@"Price", @"Price");
    priceItem.nameAlignment = HMTextAlignmentRight;
    priceItem.description = [NSString stringWithFormat:@"%.2f", priceValue.floatValue];
    priceItem.accessory = priceCurrencyAccessoryItem;
    priceItem.backgroundColor = backgroundColor;

    // creates the retail price string table cell
    HMStringTableCellItem *retailPriceItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"retail_price"];
    retailPriceItem.name = NSLocalizedString(@"Retail Price", @"Retail Price");
    retailPriceItem.nameAlignment = HMTextAlignmentRight;
    retailPriceItem.description = [NSString stringWithFormat:@"%.2f", retailPriceValue.floatValue];
    retailPriceItem.accessory = retailPriceCurrencyAccessoryItem;
    retailPriceItem.backgroundColor = backgroundColor;

    // creates the sections item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:titleItem];
    [menuHeaderGroup addItem:@"subTitle" item:subTitleItem];
    [menuHeaderGroup addItem:@"image" item:imageItem];

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
    [imageItem release];
    [subTitleItem release];
    [titleItem release];
    [retailPriceCurrencyAccessoryItem release];
    [priceCurrencyAccessoryItem release];
    [unitAccessoryItem release];
    [descriptionColorHighlighted release];
    [descriptionColor release];
    [backgroundColor release];
    [badgeHighlightedImage release];
    [badgeImage release];
}

- (NSMutableArray *)convertRemoteGroup:(HMItemOperationType)operationType {
    // calls the super
    NSMutableArray *remoteData = [super convertRemoteGroup:operationType];

    // retrieves the menu list group
    HMItemGroup *menuListGroup = (HMItemGroup *) [self.remoteGroup getItem:@"list"];

    // retreves the section item groups
    HMItemGroup *firstSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:0];

    // retrieves the first section items
    HMItem *stockItem = [firstSectionItemGroup getItem:0];
    HMItem *retailPriceItem = [firstSectionItemGroup getItem:2];

    // sets the items in the remote data
    [remoteData addObject:[NSArray arrayWithObjects:@"inventory_line[stock_on_hand]", AVOID_NIL(stockItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"inventory_line[_parameters][retail_price]", AVOID_NIL(retailPriceItem.description, NSString), nil]];

    // returns the remote data
    return remoteData;
}

- (void)convertRemoteGroupUpdate:(NSMutableArray *)remoteData {
    // retrieves the attributes
    NSNumber *objectId = [self.entity objectForKey:@"object_id"];
    NSString *objectIdString = objectId.stringValue;

    // sets the object id (structured and unstructured)
    [remoteData addObject:[NSArray arrayWithObjects:@"inventory_line[object_id]", AVOID_NIL(objectIdString, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"object_id", AVOID_NIL(objectIdString, NSString), nil]];
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

- (BOOL)deleteHidden {
    return YES;
}

@end
