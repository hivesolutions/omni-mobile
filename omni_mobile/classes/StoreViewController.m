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

#import "StoreViewController.h"

@implementation StoreViewController

@synthesize entity = _entity;
@synthesize entityAbstraction = _entityAbstraction;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the entity
    [_entity release];

    // releases the entity abstraction
    [_entityAbstraction release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // calls the super
    [super initStructures];

    // creates the entity abstraction
    HMEntityAbstraction *entityAbstraction = [[HMEntityAbstraction alloc] initWithEntityDelegate:self];

    // sets the entity abstraction
    self.entityAbstraction = entityAbstraction;

    // releases the entity abstraction
    [entityAbstraction release];
}

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"stores" serializerName:@"json"];
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
                                     @"", @"name",
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
    NSString *name = AVOID_NULL([remoteData objectForKey:@"name"]);
    NSDictionary *primaryContactInformation = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_contact_information"]);
    NSString *email = AVOID_NULL([primaryContactInformation objectForKey:@"email"]);
    NSString *phoneNumber = AVOID_NULL([primaryContactInformation objectForKey:@"phone_number"]);

    // creates the menu header items
    HMItem *title = [[HMItem alloc] initWithIdentifier:AVOID_NULL(name)];
    HMItem *subTitle = [[HMItem alloc] initWithIdentifier:AVOID_NULL(name)];
    HMItem *image = [[HMItem alloc] initWithIdentifier:AVOID_NULL(@"building_header.png")];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the phone number string table cell
    HMStringTableCellItem *phoneNumberItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"phone_number"];
    phoneNumberItem.name = NSLocalizedString(@"Phone", @"Phone");
    phoneNumberItem.description = phoneNumber;
    phoneNumberItem.highlightable = NO;

    // creates the email string table cell
    HMStringTableCellItem *emailItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"email"];
    emailItem.name = NSLocalizedString(@"Email", @"Email");
    emailItem.description = email;
    emailItem.highlightable = NO;

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

    // populates the sections
    [firstSectionItemGroup addItem:phoneNumberItem];
    [firstSectionItemGroup addItem:emailItem];

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
    [menuHeaderGroup release];
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
    HMItem *nameItem = [menuHeaderNamedGroup getItem:@"title"];

    // retrieves the menu list group
    HMItemGroup *menuListGroup = (HMItemGroup *) [self.remoteGroup getItem:@"list"];

    // retreves the section item groups
    HMItemGroup *firstSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:0];

    // retrieves the first section items
    HMItem *phoneNumberItem = [firstSectionItemGroup getItem:0];
    HMItem *emailItem = [firstSectionItemGroup getItem:1];

    // sets the items in the remote data
    [remoteData setObject:AVOID_NIL(nameItem.identifier, NSString) forKey:@"store[username]"];
    [remoteData setObject:AVOID_NIL(phoneNumberItem.description, NSString) forKey:@"store[primary_contact_information][phone_number]"];
    [remoteData setObject:AVOID_NIL(emailItem.description, NSString) forKey:@"store[primary_contact_information][email]"];

    // returns the remote data
    return remoteData;
}

- (void)convertRemoteGroupUpdate:(NSMutableDictionary *)remoteData {
    // retrieves the object id
    NSNumber *objectId = [self.entity objectForKey:@"object_id"];
    NSString *objectIdString = [objectId stringValue];

    // sets the object id (structured and unstructured)
    [remoteData setObject:AVOID_NIL(objectIdString, NSString) forKey:@"store[object_id]"];
    [remoteData setObject:AVOID_NIL(objectIdString, NSString) forKey:@"object_id"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
