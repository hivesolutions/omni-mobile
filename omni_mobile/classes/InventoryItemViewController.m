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

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"transactional_merchandise" serializerName:@"json"];
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

    // creates the menu header items
    HMItem *title = [[HMItem alloc] initWithIdentifier:name];
    HMItem *subTitle = [[HMItem alloc] initWithIdentifier:companyProductCode];
    HMItem *image = [[HMItem alloc] initWithIdentifier:@"box_header.png"];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the name string table cell item
    HMStringTableCellItem *nameItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"name"];
    nameItem.name = NSLocalizedString(@"Name", @"Name");
    nameItem.description = name;
    nameItem.multipleLines = YES;

    // creates the sections item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:title];
    [menuHeaderGroup addItem:@"subTitle" item:subTitle];
    [menuHeaderGroup addItem:@"image" item:image];

    // populates the first section item list
    [firstSectionItemGroup addItem:nameItem];

    // for each inventory line
    for(int index = 0; index < [inventoryLines count]; index++) {
        // retrieves the current inventory line
        NSDictionary *inventoryLine = [inventoryLines objectAtIndex:index];

        // retrieves the inventory line information
        NSNumber *objectId = AVOID_NULL_NUMBER([inventoryLine objectForKey:@"object_id"]);
        NSString *objectIdString = [objectId stringValue];
        NSDictionary *contactableOrganizationalHierarchyTreeNode = AVOID_NULL_DICTIONARY([inventoryLine objectForKey:@"contactable_organizational_hierarchy_tree_node"]);
        NSNumber *stockOnHandNumber = AVOID_NULL_NUMBER([inventoryLine objectForKey:@"stock_on_hand"]);
        int stockOnHand = [stockOnHandNumber intValue];

        // retrieves the store information
        NSString *storeName = AVOID_NULL([contactableOrganizationalHierarchyTreeNode objectForKey:@"name"]);
        NSString *storeStockOnHand = [NSString stringWithFormat:@"%d", stockOnHand];

        // creates the store string table cell item
        HMStringTableCellItem *storeItem = [[HMStringTableCellItem alloc] initWithIdentifier:objectIdString];
        storeItem.description = storeName;
        storeItem.icon = @"building.png";
        storeItem.highlightedIcon = @"building_white.png";
        storeItem.accessoryType = @"badge_label";
        storeItem.accessoryValue = storeStockOnHand;
        storeItem.selectable = YES;
        storeItem.indentable = NO;
        storeItem.editableRow = NO;
        storeItem.editableCell = NO;

        // populates the second section item list
        [secondSectionItemGroup addItem:storeItem];

        // releases the store item
        [storeItem release];
    }

    // adds the sections to the menu list
    [menuListGroup addItem:firstSectionItemGroup];
    [menuListGroup addItem:secondSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"header" item:menuHeaderGroup];
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // sets the attributes
    self.remoteGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [secondSectionItemGroup release];
    [firstSectionItemGroup release];
    [menuHeaderGroup release];
    [nameItem release];
    [image release];
    [subTitle release];
    [title release];
}

- (NSMutableDictionary *)convertRemoteGroup:(HMItemOperationType)operationType {
    // calls the super
    NSMutableDictionary *remoteData = [super convertRemoteGroup:operationType];

    // retrieves the menu header named group
    HMNamedItemGroup *menuHeaderNamedGroup = (HMNamedItemGroup *) [self.remoteGroup getItem:@"header"];

    // retrieves the items
    HMItem *companyProductCodeItem = [menuHeaderNamedGroup getItem:@"subTitle"];

    // retrieves the menu list group
    HMItemGroup *menuListGroup = (HMItemGroup *) [self.remoteGroup getItem:@"list"];

    // retreves the section item groups
    HMItemGroup *firstSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:0];

    // retrieves the first section items
    HMItem *nameItem = [firstSectionItemGroup getItem:0];

    // sets the items in the remote data
    [remoteData setObject:AVOID_NIL(companyProductCodeItem.identifier, NSString) forKey:@"transactional_merchandise[company_product_code]"];
    [remoteData setObject:AVOID_NIL(nameItem.description, NSString) forKey:@"transactional_merchandise[name]"];

    // returns the remote data
    return remoteData;
}

- (void)convertRemoteGroupUpdate:(NSMutableDictionary *)remoteData {
    // retrieves the object id
    NSNumber *objectId = [self.entity objectForKey:@"object_id"];
    NSString *objectIdString = [objectId stringValue];

    // sets the object id (structured and unstructured)
    [remoteData setObject:AVOID_NIL(objectIdString, NSString) forKey:@"transactional_merchandise[object_id]"];
    [remoteData setObject:AVOID_NIL(objectIdString, NSString) forKey:@"object_id"];
}

- (void)didSelectItemRowWithItem:(HMItem *)item {
    if([item.identifier isEqualToString:@"name"]) {
    }
    else {
        // initializes the inventory item store view controller
        InventoryItemStoreViewController *inventoryItemStoreViewController = [[InventoryItemStoreViewController alloc] initWithNibName:@"InventoryItemStoreViewController" bundle:[NSBundle mainBundle]];

        // pushes the inventory item store view controller into the navigation controller
        [self.navigationController pushViewController:inventoryItemStoreViewController animated:YES];

        // retrieves the item identifier
        NSString *itemIdentifier = item.identifier;

        // sets the entity in the inventory item store
        [inventoryItemStoreViewController changeIdentifier:itemIdentifier];

        // releases the inventory item store view controller reference
        [inventoryItemStoreViewController release];
    }
}

@end
