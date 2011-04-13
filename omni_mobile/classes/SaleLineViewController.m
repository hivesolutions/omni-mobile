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

// __author__    = Tiago Silva <tsilva@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "SaleLineViewController.h"

@implementation SaleLineViewController

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"sale_lines" serializerName:@"json"];
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
    NSString *identifier = AVOID_NULL([remoteData objectForKey:@"identifier"]);
    NSDictionary *unitPrice = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"unit_price"]);
    NSNumber *unitPriceNumber = AVOID_NULL_NUMBER([unitPrice objectForKey:@"value"]);
    NSNumber *unitVatNumber = AVOID_NULL_NUMBER([remoteData objectForKey:@"unit_vat"]);
    NSNumber *discountNumber = AVOID_NULL_NUMBER([remoteData objectForKey:@"discount"]);
    NSNumber *discountVatNumber = AVOID_NULL_NUMBER([remoteData objectForKey:@"discount_vat"]);
    NSNumber *quantityNumber = AVOID_NULL_NUMBER([remoteData objectForKey:@"quantity"]);
    NSDictionary *merchandise = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"merchandise"]);
    NSString *merchandiseCompanyProductCode = AVOID_NULL([merchandise objectForKey:@"company_product_code"]);

    // creates the menu header items
    HMItem *title = [[HMItem alloc] initWithIdentifier:AVOID_NULL(identifier)];
    HMItem *subTitle = [[HMItem alloc] initWithIdentifier:AVOID_NULL(merchandiseCompanyProductCode)];
    HMItem *image = [[HMItem alloc] initWithIdentifier:AVOID_NULL(@"box_building_header.png")];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the unit price table cell
    HMStringTableCellItem *unitPriceItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"unit_price"];
    unitPriceItem.name = NSLocalizedString(@"Unit Price", @"Unit Price");
    unitPriceItem.description = [NSString stringWithFormat:@"%.2f", [unitPriceNumber floatValue]];
    unitPriceItem.accessoryType = @"badge_label";
    unitPriceItem.accessoryValue = @"EUR";

    // creates the unit vat table cell
    HMStringTableCellItem *unitVatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"unit_vat"];
    unitVatItem.name = NSLocalizedString(@"Unit VAT", @"Unit VAT");
    unitVatItem.description = [NSString stringWithFormat:@"%.2f", [unitVatNumber floatValue]];
    unitVatItem.accessoryType = @"badge_label";
    unitVatItem.accessoryValue = @"EUR";

    // creates the discount table cell
    HMStringTableCellItem *discountItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"discount"];
    discountItem.name = NSLocalizedString(@"Discount", @"Discount");
    discountItem.description = [NSString stringWithFormat:@"%.2f", [discountNumber floatValue]];
    discountItem.accessoryType = @"badge_label";
    discountItem.accessoryValue = @"EUR";

    // creates the discount vat table cell
    HMStringTableCellItem *discountVatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"discount_vat"];
    discountVatItem.name = NSLocalizedString(@"Discount VAT", @"Discount VAT");
    discountVatItem.description = [NSString stringWithFormat:@"%.2f", [discountVatNumber floatValue]];
    discountVatItem.accessoryType = @"badge_label";
    discountVatItem.accessoryValue = @"EUR";

    // creates the quantity table cell
    HMStringTableCellItem *quantityItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"quantity"];
    quantityItem.name = NSLocalizedString(@"Quantity", @"Quantity");
    quantityItem.description = [NSString stringWithFormat:@"%d", [quantityNumber intValue]];
    quantityItem.accessoryType = @"badge_label";
    quantityItem.accessoryValue = @"UN";

    // creates the merchandise table cell
    HMStringTableCellItem *merchandiseItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"merchandise"];
    merchandiseItem.name = NSLocalizedString(@"Merchandise", @"Merchandise");
    merchandiseItem.description = merchandiseCompanyProductCode;
    merchandiseItem.data = merchandise;
    merchandiseItem.accessoryType = @"disclosure_indicator";
    merchandiseItem.selectable = YES;
    merchandiseItem.readViewController = [InventoryItemViewController class];
    merchandiseItem.readNibName = @"InventoryItemViewController";

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

    // populates the first section item group
    [firstSectionItemGroup addItem:unitPriceItem];
    [firstSectionItemGroup addItem:unitVatItem];
    [firstSectionItemGroup addItem:discountItem];
    [firstSectionItemGroup addItem:discountVatItem];
    [firstSectionItemGroup addItem:quantityItem];

    // populates the second section item group
    [secondSectionItemGroup addItem:merchandiseItem];

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
    [merchandiseItem release];
    [quantityItem release];
    [discountVatItem release];
    [discountItem release];
    [unitVatItem release];
    [unitPriceItem release];
    [menuHeaderGroup release];
    [image release];
    [subTitle release];
    [title release];
}

- (NSMutableArray *)convertRemoteGroup:(HMItemOperationType)operationType {
    return nil;
}

@end