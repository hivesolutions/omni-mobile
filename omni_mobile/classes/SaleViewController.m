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

// __author__    = Lu’s Martinho <lmartinho@hive.pt> & Tiago Silva <tsilva@hive.pt>
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
    NSString *saleIdentifier = AVOID_NULL([remoteData objectForKey:@"identifier"]);
    NSNumber *date = AVOID_NULL_NUMBER([remoteData objectForKey:@"date"]);
    NSDictionary *sellerStockHolder = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"seller_stockholder"]);
    NSString *sellerStockHolderName = AVOID_NULL([sellerStockHolder objectForKey:@"name"]);
    NSDictionary *price = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"price"]);
    NSNumber *priceValue = AVOID_NULL_NUMBER([price objectForKey:@"value"]);
    NSNumber *vat = AVOID_NULL_NUMBER([remoteData objectForKey:@"vat"]);
    NSDictionary *personBuyer = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"person_buyer"]);
    NSString *personBuyerName = AVOID_NULL([personBuyer objectForKey:@"name"]);
    NSDictionary *saleLines = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"sale_lines"]);

    // checks if the person is anonymous
    BOOL isPersonAnonymous = [personBuyerName length] == 0;

    // computes the date string from the timestamp
    NSDate *dateDate = [NSDate dateWithTimeIntervalSince1970:[date floatValue]];
    NSString *dateString = AVOID_NULL([dateDate description]);

    // calculates the price vat
    NSNumber *priceVat = [NSNumber numberWithFloat:([priceValue floatValue] + [vat floatValue])];

    // creates the title item
    HMItem *titleItem = [[HMItem alloc] initWithIdentifier:@"title"];
    titleItem.description = saleIdentifier;

    // creates the subtitle item
    HMItem *subTitleItem = [[HMItem alloc] initWithIdentifier:@"subTitle"];
    subTitleItem.description = dateString;

    // creates the image item
    HMItem *imageItem = [[HMItem alloc] initWithIdentifier:@"image"];
    imageItem.description = @"box_building_header.png";

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the store string table cell
    HMStringTableCellItem *storeItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"store"];
    storeItem.name = NSLocalizedString(@"Store", @"Store");
    storeItem.data = sellerStockHolder;
    storeItem.description = sellerStockHolderName;
    storeItem.accessoryType = @"disclosure_indicator";
    storeItem.readViewController = [StoreViewController class];
    storeItem.readNibName = @"StoreViewController";
    storeItem.selectable = YES;

    // creates the price string table cell
    HMStringTableCellItem *priceItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"price"];
    priceItem.name = NSLocalizedString(@"Price", @"Price");
    priceItem.description = [NSString stringWithFormat:@"%.2f", [priceValue floatValue]];
    priceItem.accessoryType = @"badge_label";
    priceItem.accessoryValue = @"EUR";

    // creates the vat string table cell
    HMStringTableCellItem *vatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"vat"];
    vatItem.name = NSLocalizedString(@"VAT", @"VAT");
    vatItem.description = [NSString stringWithFormat:@"%.2f", [vat floatValue]];
    vatItem.accessoryType = @"badge_label";
    vatItem.accessoryValue = @"EUR";

    // creates the price vat string table cell
    HMStringTableCellItem *priceVatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"price_vat"];
    priceVatItem.name = NSLocalizedString(@"Price VAT", @"Price VAT");
    priceVatItem.description = [NSString stringWithFormat:@"%.2f", [priceVat floatValue]];
    priceVatItem.accessoryType = @"badge_label";
    priceVatItem.accessoryValue = @"EUR";

    // creates the customer name string table cell
    HMStringTableCellItem *customerItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"customer"];
    customerItem.name = NSLocalizedString(@"Customer", @"Customer");
    customerItem.description = isPersonAnonymous ? NSLocalizedString(@"Anonymous", @"Anonymous") : personBuyerName;
    customerItem.accessoryType = isPersonAnonymous ? nil : @"disclosure_indicator";
    customerItem.selectable = isPersonAnonymous ? NO : YES;

    // creates the first section item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    firstSectionItemGroup.headerString = NSLocalizedString(@"Sale Lines", @"Sale Lines");

    // creates the second section item group
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];
    secondSectionItemGroup.headerString = NSLocalizedString(@"Sale Details", @"Sale Details");

    // creates remaining section item groups
    HMTableSectionItemGroup *thirdSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"third_section"];
    HMTableSectionItemGroup *fourthSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"fourth_section"];

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:titleItem];
    [menuHeaderGroup addItem:@"subTitle" item:subTitleItem];
    [menuHeaderGroup addItem:@"image" item:imageItem];

    // creates the items for the sale lines
    // and adds them to the fourth item group
    for(NSDictionary *saleLine in saleLines) {
        // retrieves the sale line attributes
        NSNumber *objectId = AVOID_NULL_NUMBER([saleLine objectForKey:@"object_id"]);
        NSString *objectIdString = [objectId stringValue];
        NSNumber *quantityNumber = AVOID_NULL_NUMBER([saleLine objectForKey:@"quantity"]);
        NSString *quantityString = [NSString stringWithFormat:@"%d", [quantityNumber intValue]];
        NSDictionary *merchandise = AVOID_NULL_DICTIONARY([saleLine objectForKey:@"merchandise"]);
        NSString *merchandiseCompanyProductCode = AVOID_NULL([merchandise objectForKey:@"company_product_code"]);

        // creates the sale line item
        HMStringTableCellItem *saleLineItem = [[HMStringTableCellItem alloc] initWithIdentifier:objectIdString];
        saleLineItem.description = merchandiseCompanyProductCode;
        saleLineItem.data = saleLine;
        saleLineItem.icon = @"box_icon.png";
        saleLineItem.highlightedIcon = @"box_icon_white.png";
        saleLineItem.accessoryType = @"badge_label";
        saleLineItem.accessoryValue = quantityString;
        saleLineItem.readViewController = [SaleLineViewController class];
        saleLineItem.readNibName = @"SaleLineViewController";
        saleLineItem.selectable = YES;

        // adds the sale line item to
        // the first section item group
        [firstSectionItemGroup addItem:saleLineItem];

        // releases the sale line item
        [saleLineItem release];
    }

    // populates the second section item group
    [secondSectionItemGroup addItem:storeItem];

    // populates the third section item group
    [thirdSectionItemGroup addItem:priceItem];
    [thirdSectionItemGroup addItem:vatItem];
    [thirdSectionItemGroup addItem:priceVatItem];

    // populates the fourth section item group
    [fourthSectionItemGroup addItem:customerItem];

    // adds the sections to the menu list
    [menuListGroup addItem:firstSectionItemGroup];
    [menuListGroup addItem:secondSectionItemGroup];
    [menuListGroup addItem:thirdSectionItemGroup];
    [menuListGroup addItem:fourthSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"header" item:menuHeaderGroup];
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // sets the attributes
    self.remoteGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [fourthSectionItemGroup release];
    [thirdSectionItemGroup release];
    [secondSectionItemGroup release];
    [firstSectionItemGroup release];
    [customerItem release];
    [priceVatItem release];
    [vatItem release];
    [priceItem release];
    [storeItem release];
    [menuHeaderGroup release];
    [imageItem release];
    [subTitleItem release];
    [titleItem release];
}

- (NSMutableArray *)convertRemoteGroup:(HMItemOperationType)operationType {
    return nil;
}

@end
