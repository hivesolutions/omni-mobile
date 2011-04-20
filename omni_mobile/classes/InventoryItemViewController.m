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

#import "InventoryItemViewController.h"

@implementation InventoryItemViewController

- (NSString *)getTitle {
    return NSLocalizedString(@"Item", @"Item");
}

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"products" serializerName:@"json"];
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
    NSString *companyProductCode = AVOID_NULL([remoteData objectForKey:@"company_product_code"]);
    NSString *name = AVOID_NULL([remoteData objectForKey:@"name"]);
    NSArray *inventoryLines = AVOID_NULL_ARRAY([remoteData objectForKey:@"inventory_lines"]);
    NSDictionary *primaryMedia = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_media"]);
    NSString *base64Data = AVOID_NULL([primaryMedia objectForKey:@"base_64_data"]);

    // creates the title item
    HMItem *titleItem = [[HMItem alloc] initWithIdentifier:@"title"];
    titleItem.defaultValue = NSLocalizedString(@"Name", @"Name");
    titleItem.description = name;

    // creates the subtitle item
    HMItem *subTitleItem = [[HMItem alloc] initWithIdentifier:@"subTitle"];
    subTitleItem.defaultValue = NSLocalizedString(@"Code", @"Code");
    subTitleItem.description = companyProductCode;

    // creates the image item
    HMItem *imageItem = [[HMItem alloc] initWithIdentifier:@"image"];
    imageItem.description = @"box_header.png";
    imageItem.data = [HMBase64Util decodeBase64WithString:base64Data];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the first section item group
    HMTableMutableSectionItemGroup *firstSectionItemGroup = [[HMTableMutableSectionItemGroup alloc] initWithIdentifier:@"stores"];
    firstSectionItemGroup.name = NSLocalizedString(@"Add Inventory Line", @"Add Inventory Line");
    firstSectionItemGroup.addViewController = [StoresViewController class];
    firstSectionItemGroup.addNibName = @"StoresViewController";
    firstSectionItemGroup.tableCellItemCreationDelegate = self;

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];
    menuListGroup.mutableParent = YES;

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:titleItem];
    [menuHeaderGroup addItem:@"subTitle" item:subTitleItem];
    [menuHeaderGroup addItem:@"image" item:imageItem];

    // for each inventory line
    for(NSDictionary *inventoryLine in inventoryLines) {
        // retrieves the inventory line information
        NSNumber *objectId = AVOID_NULL_NUMBER([inventoryLine objectForKey:@"object_id"]);
        NSString *objectIdString = [objectId stringValue];
        NSDictionary *contactableOrganizationalHierarchyTreeNode = AVOID_NULL_DICTIONARY([inventoryLine objectForKey:@"contactable_organizational_hierarchy_tree_node"]);
        NSNumber *stockOnHandNumber = AVOID_NULL_NUMBER([inventoryLine objectForKey:@"stock_on_hand"]);
        int stockOnHand = [stockOnHandNumber intValue];

        // retrieves the store information
        NSString *storeName = AVOID_NULL([contactableOrganizationalHierarchyTreeNode objectForKey:@"name"]);
        NSString *storeStockOnHand = [NSString stringWithFormat:@"%d", stockOnHand];

        // creates the inventory line string table cell item
        HMConstantStringTableCellItem *inventoryLineItem = [[HMConstantStringTableCellItem alloc] initWithIdentifier:objectIdString];
        inventoryLineItem.description = storeName;
        inventoryLineItem.data = inventoryLine;
        inventoryLineItem.icon = @"building.png";
        inventoryLineItem.highlightedIcon = @"building_white.png";
        inventoryLineItem.accessoryType = @"badge_label";
        inventoryLineItem.accessoryValue = storeStockOnHand;
        inventoryLineItem.selectable = YES;
        inventoryLineItem.selectableEdit = NO;
        inventoryLineItem.indentable = YES;
        inventoryLineItem.deletableRow = YES;
        inventoryLineItem.deleteActionType = HMTableCellItemDeleteActionTypeDelete;
        inventoryLineItem.readViewController = [InventoryItemStoreViewController class];
        inventoryLineItem.readNibName = @"InventoryItemStoreViewController";

        // populates the first section item group
        [firstSectionItemGroup addItem:inventoryLineItem];

        // releases the store item
        [inventoryLineItem release];
    }

    // adds the sections to the menu list
    [menuListGroup addItem:firstSectionItemGroup];;

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"header" item:menuHeaderGroup];
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // sets the attributes
    self.remoteGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [firstSectionItemGroup release];
    [menuHeaderGroup release];
    [imageItem release];
    [subTitleItem release];
    [titleItem release];
}

- (NSMutableArray *)convertRemoteGroup:(HMItemOperationType)operationType {
    // calls the super
    NSMutableArray *remoteData = [super convertRemoteGroup:operationType];

    // retrieves the menu header named group
    HMNamedItemGroup *menuHeaderNamedGroup = (HMNamedItemGroup *) [self.remoteGroup getItem:@"header"];

    // retrieves the header items
    HMItem *nameItem = [menuHeaderNamedGroup getItem:@"title"];
    HMItem *companyProductCodeItem = [menuHeaderNamedGroup getItem:@"subTitle"];
    HMItem *imageItem = [menuHeaderNamedGroup getItem:@"image"];

    // retrieves the menu list group
    HMItemGroup *menuListGroup = (HMItemGroup *) [self.remoteGroup getItem:@"list"];

    // retreves the section item groups
    HMTableMutableSectionItemGroup *firstSectionItemGroup = (HMTableMutableSectionItemGroup *) [menuListGroup getItem:0];

    // retrieves the data items
    NSArray *dataItems = [firstSectionItemGroup dataItems];

    // iterates over the second item group enumerator
    for(HMTableCellItem *inventoryLineItem in dataItems) {
        // retrieves the inventory line object id
        NSDictionary *inventoryLineItemData = (NSDictionary *) inventoryLineItem.data;
        NSNumber *inventoryLineObjectId = [inventoryLineItemData objectForKey:@"object_id"];

        // sets the object id in case it's defined
        if(inventoryLineObjectId != nil) {
            NSString *inventoryLineObjectIdString = [NSString stringWithFormat:@"%d", [inventoryLineObjectId intValue]];
            [remoteData addObject:[NSArray arrayWithObjects:@"product[inventory_lines][][object_id]", AVOID_NIL(inventoryLineObjectIdString, NSString), nil]];
        }

        // retrieves the inventory line's attributes
        NSDictionary *inventoryLineContactableOrganizationalHierarchyTreeNode = [inventoryLineItemData objectForKey:@"contactable_organizational_hierarchy_tree_node"];
        NSNumber *inventoryLineContactableOrganizationalHierarchyTreeNodeObjectId = [inventoryLineContactableOrganizationalHierarchyTreeNode objectForKey:@"object_id"];
        NSString *inventoryLineContactableOrganizationalHierarchyTreeNodeObjectIdString = [NSString stringWithFormat:@"%d", [inventoryLineContactableOrganizationalHierarchyTreeNodeObjectId intValue]];

        // sets the items in the remote data
        [remoteData addObject:[NSArray arrayWithObjects:@"product[inventory_lines][][contactable_organizational_hierarchy_tree_node][object_id]", AVOID_NIL(inventoryLineContactableOrganizationalHierarchyTreeNodeObjectIdString, NSString), nil]];
    }

    // sets the items in the remote data
    [remoteData addObject:[NSArray arrayWithObjects:@"product[company_product_code]", AVOID_NIL(companyProductCodeItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"product[name]", AVOID_NIL(nameItem.description, NSString), nil]];

    // in case the image data is not set
    if(imageItem.data != nil) {
        // retrieves the base 64 data from the image data
        NSString *base64Data = [HMBase64Util encodeBase64WithData:(NSData *) imageItem.data];

        // sets the primary media attributes
        [remoteData addObject:[NSArray arrayWithObjects:@"product[primary_media][base_64_data]", AVOID_NIL(base64Data, NSString), nil]];
    }

    // returns the remote data
    return remoteData;
}

- (void)convertRemoteGroupUpdate:(NSMutableArray *)remoteData {
    // retrieves the object id
    NSNumber *objectId = [self.entity objectForKey:@"object_id"];
    NSString *objectIdString = [objectId stringValue];

    // retrieves the data items count
    HMItemGroup *menuListGroup = (HMItemGroup *) [self.remoteGroup getItem:@"list"];
    HMTableMutableSectionItemGroup *firstSectionItemGroup = (HMTableMutableSectionItemGroup *) [menuListGroup getItem:0];
    NSArray *dataItems = [firstSectionItemGroup dataItems];
    NSUInteger dataItemsCount = [dataItems count];

    // sets the object id (structured and unstructured)
    [remoteData addObject:[NSArray arrayWithObjects:@"product[object_id]", AVOID_NIL(objectIdString, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"object_id", AVOID_NIL(objectIdString, NSString), nil]];

    // in case there are no
    // inventory lines
    if(dataItemsCount == 0) {
        // sets an empty inventory lines entry to
        // erase all inventory lines in the data base
        [remoteData addObject:[NSArray arrayWithObjects:@"product[inventory_lines]", [NSNull null], nil]];
    }
}

- (HMTableCellItem *)createTableCellItem:(NSDictionary *)data {
    // retrieves the attributes
    NSNumber *objectId = AVOID_NULL_NUMBER([data objectForKey:@"object_id"]);
    NSString *objectIdString = [objectId stringValue];
    NSString *storeName = [data objectForKey:@"name"];

    // creates the inventory line's identifier
    NSString *identifier = [NSString stringWithFormat:@"new_inventory_line_%d", [objectId intValue]];

    // creates the contactable organizational hierarchy tree node
    NSDictionary *contactableOrganizationalHierarchyTreeNode = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                objectIdString, @"object_id", nil];

    // creates the inventory line
    NSDictionary *inventoryLine = [NSDictionary dictionaryWithObjectsAndKeys:
                                   contactableOrganizationalHierarchyTreeNode, @"contactable_organizational_hierarchy_tree_node",
                                   nil];

    // creates the inventory line item
    HMConstantStringTableCellItem *inventoryLineItem = [[[HMConstantStringTableCellItem alloc] initWithIdentifier:identifier] autorelease];
    inventoryLineItem.transientState = HMItemStateNew;
    inventoryLineItem.description = storeName;
    inventoryLineItem.data = inventoryLine;
    inventoryLineItem.icon = @"building.png";
    inventoryLineItem.highlightedIcon = @"building_white.png";
    inventoryLineItem.accessoryType = @"badge_label";
    inventoryLineItem.accessoryValue = @"0";
    inventoryLineItem.selectable = YES;
    inventoryLineItem.selectableEdit = NO;
    inventoryLineItem.indentable = YES;
    inventoryLineItem.deletableRow = YES;
    inventoryLineItem.deleteActionType = HMTableCellItemDeleteActionTypeDelete;
    inventoryLineItem.readViewController = [InventoryItemStoreViewController class];
    inventoryLineItem.readNibName = @"InventoryItemStoreViewController";

    // returns the inventory line item
    return inventoryLineItem;
}

- (BOOL)deleteHidden {
    return YES;
}

- (BOOL)updateRemoteUpdate {
    return YES;
}

@end
