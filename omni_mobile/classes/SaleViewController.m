// Hive Omni ERP
// Copyright (c) 2008-2016 Hive Solutions Lda.
//
// This file is part of Hive Omni ERP.
//
// Hive Omni ERP is free software: you can redistribute it and/or modify
// it under the terms of the Apache License as published by the Apache
// Foundation, either version 2.0 of the License, or (at your option) any
// later version.
//
// Hive Omni ERP is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// Apache License for more details.
//
// You should have received a copy of the Apache License along with
// Hive Omni ERP. If not, see <http://www.apache.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2016 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

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
    HMColor *blackColor = [[HMColor alloc] initWithColorRed:0.0 green:0.0 blue:0.0 alpha:1];
    HMColor *lightGreenColor = [[HMColor alloc] initWithColorRed:0.66 green:0.85 blue:0.36 alpha:1];
    HMColor *darkGreenColor = [[HMColor alloc] initWithColorRed:0.23 green:0.62 blue:0.27 alpha:1];
    HMColor *backgroundColor = [[HMColor alloc] initWithColorRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    HMColor *descriptionColor = [[HMColor alloc] initWithColorRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    HMColor *descriptionColorHighlighted = [[HMColor alloc] initWithColorRed:0.54 green:0.56 blue:0.62 alpha:1.0];
    HMColor *sectionHeaderDescriptionColor = [[HMColor alloc] initWithColorRed:0.29 green:0.34 blue:0.42 alpha:1.0];
    HMColor *sectionHeaderDescriptionShadowColor = [[HMColor alloc] initWithColorRed:1.0 green:1.0 blue:1.0 alpha:1.0];

    // creates the background colors
    NSArray *selectedBackgroundColors = [[NSArray alloc] initWithObjects:lightGreenColor, darkGreenColor, nil];

    // creates the fonts
    HMFont *sectionHeaderFont = [[HMFont alloc] initWithFontName:@"Helvetica-Bold" size:15];

    // creates the images
    HMImage *badgeImage = [[HMImage alloc] initWithImageName:@"badge" leftCap:4 topCap:4];
    HMImage *badgeHighlightedImage = [[HMImage alloc] initWithImageName:@"badge_highlighted" leftCap:4 topCap:4];
    HMImage *disclosureIndicatorImage = [[HMImage alloc] initWithImageName:@"disclosure_indicator"];
    HMImage *disclosureIndicatorHighlightedImage = [[HMImage alloc] initWithImageName:@"disclosure_indicator_highlighted"];

    // creates the discoutn vat currency accessory item
    HMAccessoryItem *discountVatCurrencyAccessoryItem = [[HMAccessoryItem alloc] init];
    discountVatCurrencyAccessoryItem.description = @"EUR";
    discountVatCurrencyAccessoryItem.descriptionColor = descriptionColor;
    discountVatCurrencyAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    discountVatCurrencyAccessoryItem.imageNormal = badgeImage;
    discountVatCurrencyAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the price currency accessory item
    HMAccessoryItem *priceCurrencyAccessoryItem = [[HMAccessoryItem alloc] init];
    priceCurrencyAccessoryItem.description = @"EUR";
    priceCurrencyAccessoryItem.descriptionColor = descriptionColor;
    priceCurrencyAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    priceCurrencyAccessoryItem.imageNormal = badgeImage;
    priceCurrencyAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the vat currency accessory item
    HMAccessoryItem *vatCurrencyAccessoryItem = [[HMAccessoryItem alloc] init];
    vatCurrencyAccessoryItem.description = @"EUR";
    vatCurrencyAccessoryItem.descriptionColor = descriptionColor;
    vatCurrencyAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    vatCurrencyAccessoryItem.imageNormal = badgeImage;
    vatCurrencyAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the price vat currency accessory item
    HMAccessoryItem *priceVatCurrencyAccessoryItem = [[HMAccessoryItem alloc] init];
    priceVatCurrencyAccessoryItem.description = @"EUR";
    priceVatCurrencyAccessoryItem.descriptionColor = descriptionColor;
    priceVatCurrencyAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    priceVatCurrencyAccessoryItem.imageNormal = badgeImage;
    priceVatCurrencyAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the store disclosure indicator accessory item
    HMAccessoryItem *storeDisclosureIndicatorAccessoryItem = [[HMAccessoryItem alloc] init];
    storeDisclosureIndicatorAccessoryItem.imageNormal = disclosureIndicatorImage;
    storeDisclosureIndicatorAccessoryItem.imageHighlighted = disclosureIndicatorHighlightedImage;

    // creates the seller disclosure indicator accessory item
    HMAccessoryItem *sellerDisclosureIndicatorAccessoryItem = [[HMAccessoryItem alloc] init];
    sellerDisclosureIndicatorAccessoryItem.imageNormal = disclosureIndicatorImage;
    sellerDisclosureIndicatorAccessoryItem.imageHighlighted = disclosureIndicatorHighlightedImage;

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
    storeItem.nameAlignment = HMTextAlignmentRight;
    storeItem.data = sellerStockholder;
    storeItem.description = sellerStockHolderName;
    storeItem.accessory = storeDisclosureIndicatorAccessoryItem;
    storeItem.readViewController = [StoreViewController class];
    storeItem.readNibName = @"StoreViewController";
    storeItem.selectable = YES;
    storeItem.backgroundColor = backgroundColor;
    storeItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the seller string table cell
    HMStringTableCellItem *sellerItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"seller"];
    sellerItem.name = NSLocalizedString(@"Seller", @"Seller");
    sellerItem.nameAlignment = HMTextAlignmentRight;
    sellerItem.data = seller;
    sellerItem.description = sellerName;
    sellerItem.accessory = sellerDisclosureIndicatorAccessoryItem;
    sellerItem.readViewController = [EmployeeViewController class];
    sellerItem.readNibName = @"EmployeeViewController";
    sellerItem.selectable = YES;
    sellerItem.backgroundColor = backgroundColor;
    sellerItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the discount vat string table cell
    HMStringTableCellItem *discountVatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"discount_vat"];
    discountVatItem.name = NSLocalizedString(@"Discount VAT", @"Discount VAT");
    discountVatItem.nameAlignment = HMTextAlignmentRight;
    discountVatItem.description = [NSString stringWithFormat:@"%.2f", discountVatNumber.floatValue];
    discountVatItem.backgroundColor = backgroundColor;
    discountVatItem.accessory = discountVatCurrencyAccessoryItem;

    // creates the price string table cell
    HMStringTableCellItem *priceItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"price"];
    priceItem.name = NSLocalizedString(@"Total", @"Total");
    priceItem.nameAlignment = HMTextAlignmentRight;
    priceItem.description = [NSString stringWithFormat:@"%.2f", priceNumber.floatValue];
    priceItem.backgroundColor = backgroundColor;
    priceItem.accessory = priceCurrencyAccessoryItem;

    // creates the vat string table cell
    HMStringTableCellItem *vatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"vat"];
    vatItem.name = NSLocalizedString(@"VAT", @"VAT");
    vatItem.nameAlignment = HMTextAlignmentRight;
    vatItem.description = [NSString stringWithFormat:@"%.2f", vatNumber.floatValue];
    vatItem.backgroundColor = backgroundColor;
    vatItem.accessory = vatCurrencyAccessoryItem;

    // creates the price vat string table cell
    HMStringTableCellItem *priceVatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"price_vat"];
    priceVatItem.name = NSLocalizedString(@"Total VAT", @"Total VAT");
    priceVatItem.nameAlignment = HMTextAlignmentRight;
    priceVatItem.description = [NSString stringWithFormat:@"%.2f", priceVat.floatValue];
    priceVatItem.backgroundColor = backgroundColor;
    priceVatItem.accessory = priceVatCurrencyAccessoryItem;

    // creates the customer name string table cell
    HMStringTableCellItem *customerItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"customer"];
    customerItem.name = NSLocalizedString(@"Customer", @"Customer");
    customerItem.nameAlignment = HMTextAlignmentRight;
    customerItem.description = isPersonAnonymous ? NSLocalizedString(@"Anonymous", @"Anonymous") : personBuyerName;
    customerItem.selectable = NO;
    customerItem.backgroundColor = backgroundColor;

    // creates the first section item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    firstSectionItemGroup.headerString = NSLocalizedString(@"Sale Details", @"Sale Details");
    firstSectionItemGroup.header.descriptionFont = sectionHeaderFont;
    firstSectionItemGroup.header.descriptionColor = sectionHeaderDescriptionColor;
    firstSectionItemGroup.header.descriptionShadowColor = sectionHeaderDescriptionShadowColor;

    // creates the second section item group
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];
    secondSectionItemGroup.headerString = NSLocalizedString(@"Sale Lines", @"Sale Lines");
    secondSectionItemGroup.header.descriptionFont = sectionHeaderFont;
    secondSectionItemGroup.header.descriptionColor = sectionHeaderDescriptionColor;
    secondSectionItemGroup.header.descriptionShadowColor = sectionHeaderDescriptionShadowColor;

    // creates remaining section item groups
    HMTableSectionItemGroup *thirdSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"third_section"];
    thirdSectionItemGroup.headerString = NSLocalizedString(@"Sale Values", @"Sale Values");
    thirdSectionItemGroup.header.descriptionFont = sectionHeaderFont;
    thirdSectionItemGroup.header.descriptionColor = sectionHeaderDescriptionColor;
    thirdSectionItemGroup.header.descriptionShadowColor = sectionHeaderDescriptionShadowColor;

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
        quantityAccessoryItem.descriptionColor = descriptionColor;
        quantityAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
        quantityAccessoryItem.imageNormal = badgeImage;
        quantityAccessoryItem.imageHighlighted = badgeHighlightedImage;

        // creates the sale line item
        HMStringTableCellItem *saleLineItem = [[HMStringTableCellItem alloc] initWithIdentifier:objectIdString];
        saleLineItem.description = merchandiseCompanyProductCode;
        saleLineItem.descriptionColor = blackColor;
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
    [sellerDisclosureIndicatorAccessoryItem release];
    [storeDisclosureIndicatorAccessoryItem release];
    [priceVatCurrencyAccessoryItem release];
    [vatCurrencyAccessoryItem release];
    [priceCurrencyAccessoryItem release];
    [discountVatCurrencyAccessoryItem release];
    [sectionHeaderFont release];
    [selectedBackgroundColors release];
    [sectionHeaderDescriptionShadowColor release];
    [sectionHeaderDescriptionColor release];
    [descriptionColorHighlighted release];
    [descriptionColor release];
    [backgroundColor release];
    [darkGreenColor release];
    [lightGreenColor release];
    [blackColor release];
    [disclosureIndicatorHighlightedImage release];
    [disclosureIndicatorImage release];
    [badgeHighlightedImage release];
    [badgeImage release];
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
