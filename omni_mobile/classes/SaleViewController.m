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

#import "SaleViewController.h"

@implementation SaleViewController

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"sale_transactions" serializerName:@"json"];
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
                                     @"", @"money_sale_slip",
                                     @"", @"date",
                                     @"", @"seller_stock_holder",
                                     @"", @"price",
                                     @"", @"discount_vat",
                                     @"", @"person_buyer",
                                     nil];

    // processes the empty remote data
    [self processRemoteData:emptyRemoteData];

    // releases the objects
    [emptyRemoteData release];
}

- (void)processRemoteData:(NSDictionary *)remoteData {
    // calls the super
    [super processRemoteData:remoteData];

    // retrieves the remote data attributes
    NSDictionary *moneySaleSlip = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"money_sale_slip"]);
    NSNumber *date = AVOID_NULL([remoteData objectForKey:@"date"]);
    NSDictionary *sellerStockHolder = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"seller_stockholder"]);
    NSDictionary *price = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"price"]);
    NSNumber *vat = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"vat"]);
    NSDictionary *personBuyer = AVOID_NULL([remoteData objectForKey:@"person_buyer"]);
    NSString *moneySaleSlipIdentifier = AVOID_NULL([moneySaleSlip objectForKey:@"identifier"]);
    NSString *sellerStockHolderName = AVOID_NULL([sellerStockHolder objectForKey:@"name"]);
    NSNumber *priceValue = AVOID_NULL([price objectForKey:@"value"]);
    NSString *personBuyerName = AVOID_NULL([personBuyer objectForKey:@"name"]);

    // computes the date string from the timestamp
    NSDate *dateDate = [NSDate dateWithTimeIntervalSince1970:[date floatValue]];

    // retrieves the formatted date
    NSString *dateString = [dateDate description];

    // computes the price vat
    NSNumber *priceVat = [NSNumber numberWithFloat:([priceValue floatValue] + [vat floatValue])];

    // creates the menu header items
    HMItem *title = [[HMItem alloc] initWithIdentifier:AVOID_NULL(moneySaleSlipIdentifier)];
    HMItem *subTitle = [[HMItem alloc] initWithIdentifier:AVOID_NULL(dateString)];
    HMItem *image = [[HMItem alloc] initWithIdentifier:AVOID_NULL(@"box_building_header.png")];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the store string table cell
    HMStringTableCellItem *storeItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"store"];
    storeItem.name = NSLocalizedString(@"Store", @"Store");
    storeItem.description = sellerStockHolderName;
    storeItem.highlightable = NO;

    // creates the price string table cell
    HMStringTableCellItem *priceItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"price"];
    priceItem.name = NSLocalizedString(@"Price", @"Price");
    priceItem.description = [NSString stringWithFormat:@"%.2f", [priceValue floatValue]];
    priceItem.accessoryType = @"badge_label";
    priceItem.accessoryValue = @"EUR";
    priceItem.highlightable = NO;

    // creates the vat string table cell
    HMStringTableCellItem *vatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"vat"];
    vatItem.name = NSLocalizedString(@"VAT", @"VAT");
    vatItem.description = [NSString stringWithFormat:@"%.2f", [vat floatValue]];
    vatItem.accessoryType = @"badge_label";
    vatItem.accessoryValue = @"EUR";
    vatItem.highlightable = NO;

    // creates the price vat string table cell
    HMStringTableCellItem *priceVatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"price_vat"];
    priceVatItem.name = NSLocalizedString(@"Price VAT", @"Price VAT");
    priceVatItem.description = [NSString stringWithFormat:@"%.2f", [priceVat floatValue]];
    priceVatItem.accessoryType = @"badge_label";
    priceVatItem.accessoryValue = @"EUR";
    priceVatItem.highlightable = NO;

    // creates the customer name string table cell
    HMStringTableCellItem *customerItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"customer"];
    customerItem.name = NSLocalizedString(@"Customer", @"Customer");
    customerItem.description = personBuyerName;
    customerItem.highlightable = NO;

    // creates the sections item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];
    HMTableSectionItemGroup *thirdSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"third_section"];

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:title];
    [menuHeaderGroup addItem:@"subTitle" item:subTitle];
    [menuHeaderGroup addItem:@"image" item:image];

    // populates the first section item group
    [firstSectionItemGroup addItem:storeItem];

    // populates the second section item group
    [secondSectionItemGroup addItem:priceItem];
    [secondSectionItemGroup addItem:vatItem];
    [secondSectionItemGroup addItem:priceVatItem];

    // populates the third section item group
    [thirdSectionItemGroup addItem:customerItem];

    // adds the sections to the menu list
    [menuListGroup addItem:firstSectionItemGroup];
    [menuListGroup addItem:secondSectionItemGroup];
    [menuListGroup addItem:thirdSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"header" item:menuHeaderGroup];
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // sets the attributes
    self.remoteGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [thirdSectionItemGroup release];
    [secondSectionItemGroup release];
    [firstSectionItemGroup release];
    [customerItem release];
    [priceVatItem release];
    [vatItem release];
    [priceItem release];
    [storeItem release];
    [menuHeaderGroup release];
    [image release];
    [subTitle release];
    [title release];
}

- (NSMutableDictionary *)convertRemoteGroup:(HMItemOperationType)operationType {
    return nil;
}

- (void)convertRemoteGroupUpdate:(NSMutableDictionary *)remoteData {
}

@end
