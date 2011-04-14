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

#import "EmployeeViewController.h"

@implementation EmployeeViewController

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"employees" serializerName:@"json"];
}

- (NSString *)getItemName {
    return @"employee";
}

- (NSString *)getItemTitleName {
    return @"name";
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
    NSString *name = AVOID_NULL([remoteData objectForKey:@"name"]);
    NSDictionary *primaryAddress = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_address"]);
    NSDictionary *primaryContactInformation = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_contact_information"]);
    NSString *streetName = AVOID_NULL([primaryAddress objectForKey:@"street_name"]);
    NSString *country = AVOID_NULL([primaryAddress objectForKey:@"country"]);
    NSString *email = AVOID_NULL([primaryContactInformation objectForKey:@"email"]);
    NSString *phoneNumber = AVOID_NULL([primaryContactInformation objectForKey:@"phone_number"]);

    // creates the menu header items
    HMItem *title = [[HMItem alloc] initWithIdentifier:AVOID_NULL(name)];
    HMItem *subTitle = [[HMItem alloc] initWithIdentifier:AVOID_NULL(@"")];
    HMItem *image = [[HMItem alloc] initWithIdentifier:AVOID_NULL(@"person_header.png")];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the street name string table cell item
    HMStringTableCellItem *streetNameItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"street_name"];
    streetNameItem.name = NSLocalizedString(@"Street Name", @"Street Name");
    streetNameItem.description = streetName;
    streetNameItem.multipleLines = YES;

    // creates the country string table cell item
    HMStringTableCellItem *countryItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"country"];
    countryItem.name = NSLocalizedString(@"Country", @"Country");
    countryItem.description = country;

    // creates the phone number string table cell item
    HMStringTableCellItem *phoneNumberItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"phone_number"];
    phoneNumberItem.name = NSLocalizedString(@"Phone", @"Phone");
    phoneNumberItem.description = phoneNumber;

    // creates the email string table cell item
    HMStringTableCellItem *emailItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"email"];
    emailItem.name = NSLocalizedString(@"E-mail", @"E-mail");
    emailItem.description = email;

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
    [firstSectionItemGroup addItem:streetNameItem];
    [firstSectionItemGroup addItem:countryItem];

    // populates the second section item group
    [secondSectionItemGroup addItem:phoneNumberItem];
    [secondSectionItemGroup addItem:emailItem];

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
    [emailItem release];
    [phoneNumberItem release];
    [countryItem release];
    [streetNameItem release];
    [menuHeaderGroup release];
    [image release];
    [subTitle release];
    [title release];
}

- (NSMutableArray *)convertRemoteGroup:(HMItemOperationType)operationType {
    // calls the super
    NSMutableArray *remoteData = [super convertRemoteGroup:operationType];

    // retrieves the menu header named group
    HMNamedItemGroup *menuHeaderNamedGroup = (HMNamedItemGroup *) [self.remoteGroup getItem:@"header"];

    // retrieves the items
    HMItem *nameItem = [menuHeaderNamedGroup getItem:@"title"];

    // retrieves the menu list group
    HMItemGroup *menuListGroup = (HMItemGroup *) [self.remoteGroup getItem:@"list"];

    // retrieves the section item groups
    HMItemGroup *firstSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:0];
    HMItemGroup *secondSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:1];

    // retrieves the first section items
    HMItem *streetNameItem = [firstSectionItemGroup getItem:0];
    HMItem *countryItem = [firstSectionItemGroup getItem:1];

    // retrieves the second section items
    HMItem *phoneNumberItem = [secondSectionItemGroup getItem:0];
    HMItem *emailItem = [secondSectionItemGroup getItem:1];

    // sets the items in the remote data
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[name]", AVOID_NIL(nameItem.identifier, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_address][street_name]", AVOID_NIL(streetNameItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_address][country]", AVOID_NIL(countryItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_contact_information][phone_number]", AVOID_NIL(phoneNumberItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_contact_information][email]", AVOID_NIL(emailItem.description, NSString), nil]];

    // returns the remote data
    return remoteData;
}

- (void)convertRemoteGroupUpdate:(NSMutableArray *)remoteData {
    // retrieves the object id
    NSNumber *objectId = [self.entity objectForKey:@"object_id"];
    NSDictionary *primaryAddress = AVOID_NULL_DICTIONARY([self.entity objectForKey:@"primary_address"]);
    NSDictionary *primaryContactInformation = AVOID_NULL_DICTIONARY([self.entity objectForKey:@"primary_contact_information"]);
    NSNumber *primaryAddressObjectId = [primaryAddress objectForKey:@"object_id"];
    NSNumber *primaryContactInformationObjectId = [primaryContactInformation objectForKey:@"object_id"];

    // sets the object id (structured and unstructured)
    NSString *objectIdString = [objectId stringValue];
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[object_id]", AVOID_NIL(objectIdString, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"object_id", AVOID_NIL(objectIdString, NSString), nil]];

    // sets the primary address's object id in case it's defined
    if(primaryAddressObjectId != nil) {
        NSString *primaryAddressObjectIdString = [primaryAddressObjectId stringValue];
        [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_address][object_id]", AVOID_NIL(primaryAddressObjectIdString, NSString), nil]];
    }

    // sets the primary contact information's object id in case it's defined
    if(primaryContactInformationObjectId != nil) {
        NSString *primaryContactInformationObjectIdString = [primaryContactInformationObjectId stringValue];
        [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_contact_information][object_id]", AVOID_NIL(primaryContactInformationObjectIdString, NSString), nil]];
    }
}

@end
