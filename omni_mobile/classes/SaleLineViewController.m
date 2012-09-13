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
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "SaleLineViewController.h"

@implementation SaleLineViewController

- (NSString *)getTitle {
    return NSLocalizedString(@"Sale Line", @"Sale Line");
}

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"sale_lines" serializerName:@"json"];
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
    NSDictionary *unitPrice = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"unit_price"]);
    NSNumber *unitPriceNumber = AVOID_NULL_NUMBER([unitPrice objectForKey:@"value"]);
    NSNumber *unitVatNumber = AVOID_NULL_NUMBER([remoteData objectForKey:@"unit_vat"]);
    NSNumber *unitDiscountVatNumber = AVOID_NULL_NUMBER([remoteData objectForKey:@"unit_discount_vat"]);
    NSNumber *quantityNumber = AVOID_NULL_NUMBER([remoteData objectForKey:@"quantity"]);
    NSDictionary *merchandise = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"merchandise"]);
    NSString *merchandiseCompanyProductCode = AVOID_NULL([merchandise objectForKey:@"company_product_code"]);
    NSDictionary *sale = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"sale"]);
    NSDictionary *moneySaleSlip = AVOID_NULL_DICTIONARY([sale objectForKey:@"money_sale_slip"]);
    NSDictionary *invoice = AVOID_NULL_DICTIONARY([sale objectForKey:@"invoice"]);

    // checks if the money sale slip is available
    BOOL isMoneySaleSlipAvailable = moneySaleSlip.count > 0;

    // retrieves the sale identifier from the
    // money sale slip or the invoice depending
    // on which document is available
    NSString *saleIdentifier = isMoneySaleSlipAvailable ? AVOID_NULL([moneySaleSlip objectForKey:@"identifier"]) : AVOID_NULL([invoice objectForKey:@"identifier"]);

    // calculates the unit price vat
    float unitPriceVat = unitPriceNumber.floatValue + unitVatNumber.floatValue;

    // creates the colors
    HMColor *lightGreenColor = [[HMColor alloc] initWithColorRed:0.66 green:0.85 blue:0.36 alpha:1];
    HMColor *darkGreenColor = [[HMColor alloc] initWithColorRed:0.23 green:0.62 blue:0.27 alpha:1];
    HMColor *descriptionColor = [[HMColor alloc] initWithColorRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    HMColor *descriptionColorHighlighted = [[HMColor alloc] initWithColorRed:0.54 green:0.56 blue:0.62 alpha:1.0];
    HMColor *backgroundColor = [[HMColor alloc] initWithColorRed:0.96 green:0.96 blue:0.96 alpha:1.0];

    // creates the background colors
    NSArray *selectedBackgroundColors = [[NSArray alloc] initWithObjects:lightGreenColor, darkGreenColor, nil];

    // creates the images
    HMImage *badgeImage = [[HMImage alloc] initWithImageName:@"badge" leftCap:4 topCap:4];
    HMImage *badgeHighlightedImage = [[HMImage alloc] initWithImageName:@"badge_highlighted" leftCap:4 topCap:4];
    HMImage *disclosureIndicatorImage = [[HMImage alloc] initWithImageName:@"disclosure_indicator"];
    HMImage *disclosureIndicatorHighlightedImage = [[HMImage alloc] initWithImageName:@"disclosure_indicator_highlighted"];

    // creates the unit price currency accessory item
    HMAccessoryItem *unitPriceCurrencyAccessoryItem = [[HMAccessoryItem alloc] init];
    unitPriceCurrencyAccessoryItem.description = @"EUR";
    unitPriceCurrencyAccessoryItem.descriptionColor = descriptionColor;
    unitPriceCurrencyAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    unitPriceCurrencyAccessoryItem.imageNormal = badgeImage;
    unitPriceCurrencyAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the discount vat currency accessory item
    HMAccessoryItem *discountVatCurrencyAccessoryItem = [[HMAccessoryItem alloc] init];
    discountVatCurrencyAccessoryItem.description = @"EUR";
    discountVatCurrencyAccessoryItem.descriptionColor = descriptionColor;
    discountVatCurrencyAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    discountVatCurrencyAccessoryItem.imageNormal = badgeImage;
    discountVatCurrencyAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the unit accessory item
    HMAccessoryItem *unitAccessoryItem = [[HMAccessoryItem alloc] init];
    unitAccessoryItem.description = @"UN";
    unitAccessoryItem.descriptionColor = descriptionColor;
    unitAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    unitAccessoryItem.imageNormal = badgeImage;
    unitAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the disclosure indicator accessory item
    HMAccessoryItem *disclosureIndicatorAccessoryItem = [[HMAccessoryItem alloc] init];
    disclosureIndicatorAccessoryItem.imageNormal = disclosureIndicatorImage;
    disclosureIndicatorAccessoryItem.imageHighlighted = disclosureIndicatorHighlightedImage;

    // creates the title item
    HMStringTableCellItem *titleItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"title"];
    titleItem.description = saleIdentifier;
    titleItem.clearable = YES;
    titleItem.backgroundColor = backgroundColor;

    // creates the subtitle item
    HMStringTableCellItem *subTitleItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"subTitle"];
    subTitleItem.description = merchandiseCompanyProductCode;
    subTitleItem.clearable = YES;
    subTitleItem.backgroundColor = backgroundColor;

    // creates the image item
    HMItem *imageItem = [[HMItem alloc] initWithIdentifier:@"image"];
    imageItem.description = @"box_building_header.png";

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the unit price table cell
    HMStringTableCellItem *unitPriceVatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"unit_price"];
    unitPriceVatItem.name = NSLocalizedString(@"Unit Price VAT", @"Unit Price VAT");
    unitPriceVatItem.nameAlignment = HMTextAlignmentRight;
    unitPriceVatItem.description = [NSString stringWithFormat:@"%.2f", unitPriceVat];
    unitPriceVatItem.accessory = unitPriceCurrencyAccessoryItem;
    unitPriceVatItem.backgroundColor = backgroundColor;

    // creates the discount vat table cell
    HMStringTableCellItem *discountVatItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"discount_vat"];
    discountVatItem.name = NSLocalizedString(@"Discount VAT", @"Discount VAT");
    discountVatItem.nameAlignment = HMTextAlignmentRight;
    discountVatItem.description = [NSString stringWithFormat:@"%.2f", unitDiscountVatNumber.floatValue];
    discountVatItem.accessory = discountVatCurrencyAccessoryItem;
    discountVatItem.backgroundColor = backgroundColor;

    // creates the quantity table cell
    HMStringTableCellItem *quantityItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"quantity"];
    quantityItem.name = NSLocalizedString(@"Quantity", @"Quantity");
    quantityItem.nameAlignment = HMTextAlignmentRight;
    quantityItem.description = [NSString stringWithFormat:@"%d", quantityNumber.intValue];
    quantityItem.accessory = unitAccessoryItem;
    quantityItem.backgroundColor = backgroundColor;

    // creates the merchandise table cell
    HMStringTableCellItem *merchandiseItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"merchandise"];
    merchandiseItem.name = NSLocalizedString(@"Merchandise", @"Merchandise");
    merchandiseItem.nameAlignment = HMTextAlignmentRight;
    merchandiseItem.description = merchandiseCompanyProductCode;
    merchandiseItem.data = merchandise;
    merchandiseItem.accessory = disclosureIndicatorAccessoryItem;
    merchandiseItem.selectable = YES;
    merchandiseItem.readViewController = [InventoryItemViewController class];
    merchandiseItem.readNibName = @"InventoryItemViewController";
    merchandiseItem.backgroundColor = backgroundColor;
    merchandiseItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the sections item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:titleItem];
    [menuHeaderGroup addItem:@"subTitle" item:subTitleItem];
    [menuHeaderGroup addItem:@"image" item:imageItem];

    // populates the first section item group
    [firstSectionItemGroup addItem:unitPriceVatItem];
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
    [unitPriceVatItem release];
    [menuHeaderGroup release];
    [imageItem release];
    [subTitleItem release];
    [titleItem release];
    [disclosureIndicatorAccessoryItem release];
    [unitAccessoryItem release];
    [discountVatCurrencyAccessoryItem release];
    [unitPriceCurrencyAccessoryItem release];
    [selectedBackgroundColors release];
    [backgroundColor release];
    [descriptionColorHighlighted release];
    [descriptionColor release];
    [darkGreenColor release];
    [lightGreenColor release];
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
