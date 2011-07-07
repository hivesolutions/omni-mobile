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

- (NSString *)getTitle {
    return NSLocalizedString(@"Sale", @"Sale");
}

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"sale_transactions" serializerName:@"json"];
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
    NSNumber *date = AVOID_NULL_NUMBER([remoteData objectForKey:@"date"]);
    NSArray *sellers = AVOID_NULL_ARRAY([remoteData objectForKey:@"sellers"]);
    NSDictionary *seller = AVOID_NULL_DICTIONARY([sellers objectAtIndex:0]);
    NSString *sellerName = AVOID_NULL([seller objectForKey:@"name"]);
    NSDictionary *sellerStockholder = AVOID_NULL([remoteData objectForKey:@"seller_stockholder"]);
    NSString *sellerStockHolderName = AVOID_NULL([sellerStockholder objectForKey:@"name"]);
    NSNumber *discountVatNumber = AVOID_NULL_NUMBER([remoteData objectForKey:@"discount_vat"]);
    NSDictionary *price = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"price"]);
    NSNumber *priceNumber = AVOID_NULL_NUMBER([price objectForKey:@"value"]);
    NSNumber *vatNumber = AVOID_NULL_NUMBER([remoteData objectForKey:@"vat"]);
    NSDictionary *personBuyer = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"person_buyer"]);
    NSString *personBuyerName = AVOID_NULL([personBuyer objectForKey:@"name"]);
    NSDictionary *saleLines = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"sale_lines"]);
    NSDictionary *moneySaleSlip = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"money_sale_slip"]);
    NSDictionary *invoice = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"invoice"]);

    // checks if the money sale slip is available
    BOOL isMoneySaleSlipAvailable = moneySaleSlip.count > 0;

    // checks if the person is anonymous
    BOOL isPersonAnonymous = personBuyerName.length == 0;

    // retrieves the sale identifier from the
    // money sale slip or the invoice depending
    // on which document is available
    NSString *saleIdentifier = isMoneySaleSlipAvailable ? AVOID_NULL([moneySaleSlip objectForKey:@"identifier"]) : AVOID_NULL([invoice objectForKey:@"identifier"]);

    // computes the date string from the timestamp
    NSDate *dateDate = [NSDate dateWithTimeIntervalSince1970:date.floatValue];
    NSString *dateString = AVOID_NULL([dateDate description]);

    // calculates the price vat
    NSNumber *priceVat = [NSNumber numberWithFloat:(priceNumber.floatValue + vatNumber.floatValue)];

    // creates the colors
    HMColor *backgroundColor = [HMColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
    HMColor *lightGreenColor = [HMColor colorWithRed:0.66 green:0.85 blue:0.36 alpha:1];
    HMColor *darkGreenColor = [HMColor colorWithRed:0.23 green:0.62 blue:0.27 alpha:1];

    // creates the background colors
    NSArray *selectedBackgroundColors = [[NSArray alloc] initWithObjects:lightGreenColor, darkGreenColor, nil];

    // creates the currency accessory item
    HMAccessoryItem *currencyAccessoryItem = [[HMAccessoryItem alloc] init];
    currencyAccessoryItem.description = @"EUR";
    currencyAccessoryItem.descriptionColor = [HMColor whiteColor];
    currencyAccessoryItem.descriptionColorHighlighted = [HMColor colorWithRed:0.54 green:0.56 blue:0.62 alpha:1.0];
    currencyAccessoryItem.imageNormal = [HMImage imageNamed:@"badge" leftCap:4 topCap:4];
    currencyAccessoryItem.imageHighlighted = [HMImage imageNamed:@"badge_highlighted" leftCap:4 topCap:4];

    // creates the disclosure indicator accessory item
    HMAccessoryItem *disclosureIndicatorAccessoryItem = [[HMAccessoryItem alloc] init];
    disclosureIndicatorAccessoryItem.imageNormal = [HMImage imageNamed:@"disclosure_indicator"];
    disclosureIndicatorAccessoryItem.imageHighlighted = [HMImage imageNamed:@"disclosure_indicator_highlighted"];

    // creates the title item
    HMStringTableCellItem *titleItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"title"];
    titleItem.description = saleIdentifier;
    titleItem.clearable = YES;
    titleItem.backgroundColor = backgroundColor;

    // creates the subtitle item
    HMStringTableCellItem *subTitleItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"subTitle"];
    subTitleItem.description = dateString;
    subTitleItem.clearable = YES;
    subTitleItem.backgroundColor = backgroundColor;

    // creates the image item
    HMItem *imageItem = [[HMItem alloc] initWithIdentifier:@"image"];
    imageItem.description = @"box_building_header.png";

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the store string table cell
    HMStringTableCellItem *storeItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"store"];
    storeItem.name = NSLocalizedString(@"Store", @"Store");
    storeItem.data = sellerStockholder;
    storeItem.description = sellerStockHolderName;
    storeItem.accessory = disclosureIndicatorAccessoryItem;
    storeItem.readViewController = [StoreViewController class];
    storeItem.readNibName = @"StoreViewController";
    storeItem.selectable = YES;
    storeItem.backgroundColor = backgroundColor;
    storeItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the seller string table cell
    HMStringTableCellItem *sellerItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"seller"];
    sellerItem.name = NSLocalizedString(@"Seller", @"Seller");
    sellerItem.data = seller;
    sellerItem.description = sellerName;
    sellerItem.accessory = disclosureIndicatorAccessoryItem;
    sellerItem.readViewController = [EmployeeViewController class];
    sellerItem.readNibName = @"EmployeeViewController";
    sellerItem.selectable = YES;
    sellerItem.backgroundColor = backgroundColor;
    sellerItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the discount vat string table cell
    HMStringTableCellItem *discountVatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"discount_vat"];
    discountVatItem.name = NSLocalizedString(@"Discount VAT", @"Discount VAT");
    discountVatItem.description = [NSString stringWithFormat:@"%.2f", discountVatNumber.floatValue];
    discountVatItem.backgroundColor = backgroundColor;
    discountVatItem.accessory = currencyAccessoryItem;

    // creates the price string table cell
    HMStringTableCellItem *priceItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"price"];
    priceItem.name = NSLocalizedString(@"Total", @"Total");
    priceItem.description = [NSString stringWithFormat:@"%.2f", priceNumber.floatValue];
    priceItem.backgroundColor = backgroundColor;
    priceItem.accessory = currencyAccessoryItem;

    // creates the vat string table cell
    HMStringTableCellItem *vatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"vat"];
    vatItem.name = NSLocalizedString(@"VAT", @"VAT");
    vatItem.description = [NSString stringWithFormat:@"%.2f", vatNumber.floatValue];
    vatItem.backgroundColor = backgroundColor;
    vatItem.accessory = currencyAccessoryItem;

    // creates the price vat string table cell
    HMStringTableCellItem *priceVatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"price_vat"];
    priceVatItem.name = NSLocalizedString(@"Total VAT", @"Total VAT");
    priceVatItem.description = [NSString stringWithFormat:@"%.2f", priceVat.floatValue];
    priceVatItem.backgroundColor = backgroundColor;
    priceVatItem.accessory = currencyAccessoryItem;

    // creates the customer name string table cell
    HMStringTableCellItem *customerItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"customer"];
    customerItem.name = NSLocalizedString(@"Customer", @"Customer");
    customerItem.description = isPersonAnonymous ? NSLocalizedString(@"Anonymous", @"Anonymous") : personBuyerName;
    customerItem.selectable = NO;
    customerItem.backgroundColor = backgroundColor;

    // creates the first section item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    firstSectionItemGroup.headerString = NSLocalizedString(@"Sale Details", @"Sale Details");

    // creates the second section item group
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];
    secondSectionItemGroup.headerString = NSLocalizedString(@"Sale Lines", @"Sale Lines");

    // creates remaining section item groups
    HMTableSectionItemGroup *thirdSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"third_section"];
    thirdSectionItemGroup.headerString = NSLocalizedString(@"Sale Values", @"Sale Values");

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:titleItem];
    [menuHeaderGroup addItem:@"subTitle" item:subTitleItem];
    [menuHeaderGroup addItem:@"image" item:imageItem];

    // populates the first section item group
    [firstSectionItemGroup addItem:storeItem];
    [firstSectionItemGroup addItem:sellerItem];
    [firstSectionItemGroup addItem:customerItem];

    // creates the items for the sale lines
    // and adds them to the fourth item group
    for(NSDictionary *saleLine in saleLines) {
        // retrieves the sale line attributes
        NSNumber *objectId = AVOID_NULL_NUMBER([saleLine objectForKey:@"object_id"]);
        NSString *objectIdString = objectId.stringValue;
        NSNumber *quantityNumber = AVOID_NULL_NUMBER([saleLine objectForKey:@"quantity"]);
        NSString *quantityString = [NSString stringWithFormat:@"%d", quantityNumber.intValue];
        NSDictionary *merchandise = AVOID_NULL_DICTIONARY([saleLine objectForKey:@"merchandise"]);
        NSString *merchandiseCompanyProductCode = AVOID_NULL([merchandise objectForKey:@"company_product_code"]);

        // creates the currency accessory item
        HMAccessoryItem *quantityAccessoryItem = [[HMAccessoryItem alloc] init];
        quantityAccessoryItem.description = quantityString;
        quantityAccessoryItem.descriptionColor = [HMColor whiteColor];
        quantityAccessoryItem.descriptionColorHighlighted = [HMColor colorWithRed:0.54 green:0.56 blue:0.62 alpha:1.0];
        quantityAccessoryItem.imageNormal = [HMImage imageNamed:@"badge" leftCap:4 topCap:4];
        quantityAccessoryItem.imageHighlighted = [HMImage imageNamed:@"badge_highlighted" leftCap:4 topCap:4];

        // creates the sale line item
        HMStringTableCellItem *saleLineItem = [[HMStringTableCellItem alloc] initWithIdentifier:objectIdString];
        saleLineItem.description = merchandiseCompanyProductCode;
        saleLineItem.data = saleLine;
        saleLineItem.accessory = quantityAccessoryItem;
        saleLineItem.readViewController = [SaleLineViewController class];
        saleLineItem.readNibName = @"SaleLineViewController";
        saleLineItem.selectable = YES;
        saleLineItem.backgroundColor = backgroundColor;
        saleLineItem.selectedBackgroundColors = selectedBackgroundColors;

        // adds the sale line item to
        // the second section item group
        [secondSectionItemGroup addItem:saleLineItem];

        // releases the sale line item
        [saleLineItem release];
        [quantityAccessoryItem release];
    }

    // populates the third section item group
    [thirdSectionItemGroup addItem:discountVatItem];
    [thirdSectionItemGroup addItem:priceItem];
    [thirdSectionItemGroup addItem:vatItem];
    [thirdSectionItemGroup addItem:priceVatItem];

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
    [discountVatItem release];
    [sellerItem release];
    [storeItem release];
    [menuHeaderGroup release];
    [imageItem release];
    [subTitleItem release];
    [titleItem release];
    [disclosureIndicatorAccessoryItem release];
    [currencyAccessoryItem release];
    [selectedBackgroundColors release];
}

- (NSMutableArray *)convertRemoteGroup:(HMItemOperationType)operationType {
    return nil;
}

- (BOOL)editHidden {
    return YES;
}

- (BOOL)deleteHidden {
    return YES;
}

@end
