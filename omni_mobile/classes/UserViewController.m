// Hive Omni ERP
// Copyright (c) 2008-2019 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2019 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "UserViewController.h"

@implementation UserViewController

- (NSString *)getTitle {
    return NSLocalizedString(@"User", @"User");
}

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"system_users" serializerName:@"json"];
}

- (NSString *)getItemName {
    return @"user";
}

- (NSString *)getItemTitleName {
    return @"username";
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
    NSString *username = AVOID_NULL([remoteData objectForKey:@"username"]);
    NSString *email = AVOID_NULL([remoteData objectForKey:@"email"]);
    NSString *secretQuestion = AVOID_NULL([remoteData objectForKey:@"secret_question"]);
    NSDictionary *person = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"person"]);
    NSString *personName = AVOID_NULL([person objectForKey:@"name"]);
    NSDictionary *defaultFunctionalUnit = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"default_functional_unit"]);
    NSString *defaultFunctionalUnitName = AVOID_NULL([defaultFunctionalUnit objectForKey:@"name"]);
    NSDictionary *primaryMedia = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_media"]);
    NSString *base64Data = AVOID_NULL([primaryMedia objectForKey:@"base_64_data"]);

    // checks if the persons is available
    BOOL isPersonAvailable = person.count == 0 ? NO : YES;

    // checks if the default functional unit is available
    BOOL isDefaultFunctionalUnitAvailable = defaultFunctionalUnit.count == 0 ? NO : YES;

    // creates the colors
    HMColor *backgroundColor = [[HMColor alloc] initWithColorRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    HMColor *lightGreenColor = [[HMColor alloc] initWithColorRed:0.66 green:0.85 blue:0.36 alpha:1];
    HMColor *darkGreenColor = [[HMColor alloc] initWithColorRed:0.23 green:0.62 blue:0.27 alpha:1];

    // creates the background colors
    NSArray *selectedBackgroundColors = [[NSArray alloc] initWithObjects:lightGreenColor, darkGreenColor, nil];

    // creates the images
    HMImage *disclosureIndicatorImage = [[HMImage alloc] initWithImageName:@"disclosure_indicator"];
    HMImage *disclosureIndicatorHighlightedImage = [[HMImage alloc] initWithImageName:@"disclosure_indicator_highlighted"];

    // creates the functional unit disclosure indicator accessory item
    HMAccessoryItem *functionalUnitDisclosureIndicatorAccessoryItem = [[HMAccessoryItem alloc] init];
    functionalUnitDisclosureIndicatorAccessoryItem.imageNormal = disclosureIndicatorImage;
    functionalUnitDisclosureIndicatorAccessoryItem.imageHighlighted = disclosureIndicatorHighlightedImage;

    // creates the employee disclosure indicator accessory item
    HMAccessoryItem *employeeDisclosureIndicatorAccessoryItem = [[HMAccessoryItem alloc] init];
    employeeDisclosureIndicatorAccessoryItem.imageNormal = disclosureIndicatorImage;
    employeeDisclosureIndicatorAccessoryItem.imageHighlighted = disclosureIndicatorHighlightedImage;

    // creates the title item
    HMStringTableCellItem *titleItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"title"];
    titleItem.defaultValue = NSLocalizedString(@"Username", @"Username");
    titleItem.description = username;
    titleItem.clearable = YES;
    titleItem.backgroundColor = backgroundColor;

    // creates the subtitle item
    HMStringTableCellItem *subTitleItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"subTitle"];
    subTitleItem.description = @"";
    subTitleItem.clearable = YES;
    subTitleItem.backgroundColor = backgroundColor;

    // creates the image item
    HMItem *imageItem = [[HMItem alloc] initWithIdentifier:@"image"];
    imageItem.description = @"person_header.png";
    imageItem.data = [HMBase64Util decodeBase64WithString:base64Data];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the password string table cell
    HMStringTableCellItem *passwordItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"password"];
    passwordItem.name = NSLocalizedString(@"Password", @"Password");
    passwordItem.nameAlignment = HMTextAlignmentRight;
    passwordItem.secure = YES;
    passwordItem.backgroundColor = backgroundColor;

    // creates the email string table cell
    HMStringTableCellItem *emailItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"email"];
    emailItem.name = NSLocalizedString(@"E-mail", @"E-mail");
    emailItem.nameAlignment = HMTextAlignmentRight;
    emailItem.description = email;
    emailItem.backgroundColor = backgroundColor;

    // creates the secret question string table cell
    HMStringTableCellItem *secretQuestionItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"secret_question"];
    secretQuestionItem.name = NSLocalizedString(@"Question", @"Question");
    secretQuestionItem.nameAlignment = HMTextAlignmentRight;
    secretQuestionItem.description = secretQuestion;
    secretQuestionItem.backgroundColor = backgroundColor;

    // creates the secret answer string table cell
    HMStringTableCellItem *secretAnswerItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"secret_answer"];
    secretAnswerItem.name = NSLocalizedString(@"Answer", @"Answer");
    secretAnswerItem.nameAlignment = HMTextAlignmentRight;
    secretAnswerItem.secure = YES;
    secretAnswerItem.backgroundColor = backgroundColor;

    // creates the default functional unit string table cell
    HMConstantStringTableCellItem *defaultFunctionalUnitItem = [[HMConstantStringTableCellItem alloc] initWithIdentifier:@"stores"];
    defaultFunctionalUnitItem.name = NSLocalizedString(@"Store", @"Store");
    defaultFunctionalUnitItem.nameAlignment = HMTextAlignmentRight;
    defaultFunctionalUnitItem.description = defaultFunctionalUnitName;
    defaultFunctionalUnitItem.data = isDefaultFunctionalUnitAvailable ? defaultFunctionalUnit : nil;
    defaultFunctionalUnitItem.accessory = functionalUnitDisclosureIndicatorAccessoryItem;
    defaultFunctionalUnitItem.readViewController = [StoreViewController class];
    defaultFunctionalUnitItem.readNibName = @"StoreViewController";
    defaultFunctionalUnitItem.editViewController = [StoresViewController class];
    defaultFunctionalUnitItem.editNibName = @"StoresViewController";
    defaultFunctionalUnitItem.deletableRow = YES;
    defaultFunctionalUnitItem.deleteActionType = HMTableCellItemDeleteActionTypeClear;
    defaultFunctionalUnitItem.selectable = YES;
    defaultFunctionalUnitItem.selectableEdit = YES;
    defaultFunctionalUnitItem.backgroundColor = backgroundColor;
    defaultFunctionalUnitItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the employee string table cell
    HMConstantStringTableCellItem *employeeItem = [[HMConstantStringTableCellItem alloc] initWithIdentifier:@"employee"];
    employeeItem.name = NSLocalizedString(@"Employee", @"Employee");
    employeeItem.nameAlignment = HMTextAlignmentRight;
    employeeItem.description = personName;
    employeeItem.data = isPersonAvailable ? person : nil;
    employeeItem.accessory = employeeDisclosureIndicatorAccessoryItem;
    employeeItem.readViewController = [EmployeeViewController class];
    employeeItem.readNibName = @"EmployeeViewController";
    employeeItem.editViewController = [EmployeesViewController class];
    employeeItem.editNibName = @"EmployeesViewController";
    employeeItem.deletableRow = YES;
    employeeItem.deleteActionType = HMTableCellItemDeleteActionTypeClear;
    employeeItem.selectable = YES;
    employeeItem.selectableEdit = YES;
    employeeItem.backgroundColor = backgroundColor;
    employeeItem.selectedBackgroundColors = selectedBackgroundColors;

    // creates the sections item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];
    HMTableSectionItemGroup *thirdSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"third_section"];

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:titleItem];
    [menuHeaderGroup addItem:@"subTitle" item:subTitleItem];
    [menuHeaderGroup addItem:@"image" item:imageItem];

    // populates the first section item group
    [firstSectionItemGroup addItem:passwordItem];
    [firstSectionItemGroup addItem:emailItem];

    // populates the second section item group
    [secondSectionItemGroup addItem:secretQuestionItem];
    [secondSectionItemGroup addItem:secretAnswerItem];

    // populates the third section item group
    [thirdSectionItemGroup addItem:defaultFunctionalUnitItem];
    [thirdSectionItemGroup addItem:employeeItem];

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
    [employeeItem release];
    [defaultFunctionalUnitItem release];
    [secretAnswerItem release];
    [secretQuestionItem release];
    [passwordItem release];
    [emailItem release];
    [menuHeaderGroup release];
    [imageItem release];
    [subTitleItem release];
    [titleItem release];
    [employeeDisclosureIndicatorAccessoryItem release];
    [functionalUnitDisclosureIndicatorAccessoryItem release];
    [selectedBackgroundColors release];
    [darkGreenColor release];
    [lightGreenColor release];
    [backgroundColor release];
    [disclosureIndicatorHighlightedImage release];
    [disclosureIndicatorImage release];
}

- (NSMutableArray *)convertRemoteGroup:(HMItemOperationType)operationType {
    // calls the super
    NSMutableArray *remoteData = [super convertRemoteGroup:operationType];

    // retrieves the menu header named group
    HMNamedItemGroup *menuHeaderNamedGroup = (HMNamedItemGroup *) [self.remoteGroup getItem:@"header"];

    // retrieves the header items
    HMItem *usernameItem = [menuHeaderNamedGroup getItem:@"title"];
    HMItem *imageItem = [menuHeaderNamedGroup getItem:@"image"];

    // retrieves the menu list group
    HMItemGroup *menuListGroup = (HMItemGroup *) [self.remoteGroup getItem:@"list"];

    // retreves the section item groups
    HMItemGroup *firstSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:0];
    HMItemGroup *secondSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:1];
    HMItemGroup *thirdSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:2];

    // retrieves the first section items
    HMItem *passwordItem = [firstSectionItemGroup getItem:0];
    HMItem *emailItem = [firstSectionItemGroup getItem:1];

    // retrieves the second section items
    HMItem *secretQuestion = [secondSectionItemGroup getItem:0];
    HMItem *secretAnswer = [secondSectionItemGroup getItem:1];

    // retrieves the third section items
    HMItem *defaultFunctionalUnitItem = [thirdSectionItemGroup getItem:0];
    HMItem *employeeItem = [thirdSectionItemGroup getItem:1];

    // retrieves the default functional unit object id
    NSDictionary *defaultFunctionalUnitData = (NSDictionary *) defaultFunctionalUnitItem.data;
    NSNumber *defaultFunctionalUnitObjectId = [defaultFunctionalUnitData objectForKey:@"object_id"];

    // retrieves the employee object id
    NSDictionary *employeeData = (NSDictionary *) employeeItem.data;
    NSNumber *employeeObjectId = [employeeData objectForKey:@"object_id"];

    // sets the items in the remote data
    [remoteData addObject:[NSArray arrayWithObjects:@"user[username]", AVOID_NIL(usernameItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"user[type]", @"3", nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"user[email]", AVOID_NIL(emailItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"user[secret_question]", AVOID_NIL(secretQuestion.description, NSString), nil]];

    // sets the parameter items in the remote data
    [remoteData addObject:[NSArray arrayWithObjects:@"user[_parameters][password]", AVOID_NIL(passwordItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"user[_parameters][confirm_password]", AVOID_NIL(passwordItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"user[_parameters][secret_answer]", AVOID_NIL(secretAnswer.description, NSString), nil]];

    // sets the default functional unit to null in case it's not defined
    if(defaultFunctionalUnitObjectId == nil) {
        [remoteData addObject:[NSArray arrayWithObjects:@"user[default_functional_unit]", [NSNull null], nil]];
    } else {
        // otherwise sets the related default functional unit
        NSString *defaultFunctionalUnitObjectIdString = [NSString stringWithFormat:@"%d", defaultFunctionalUnitObjectId.intValue];
        [remoteData addObject:[NSArray arrayWithObjects:@"user[default_functional_unit][object_id]", defaultFunctionalUnitObjectIdString, nil]];
    }

    // sets the employee to null in case it's not defined
    if(employeeObjectId == nil) {
        [remoteData addObject:[NSArray arrayWithObjects:@"user[person]", [NSNull null], nil]];
    } else {
        // otherwise sets the related employee
        NSString *employeeObjectIdString = [NSString stringWithFormat:@"%d", employeeObjectId.intValue];
        [remoteData addObject:[NSArray arrayWithObjects:@"user[person][object_id]", employeeObjectIdString, nil]];
    }

    // in case the image data is not set
    if(imageItem.data != nil) {
        // retrieves the base 64 data from the image data
        NSString *base64Data = [HMBase64Util encodeBase64WithData:(NSData *) imageItem.data];

        // sets the primary media attributes
        [remoteData addObject:[NSArray arrayWithObjects:@"user[primary_media][base_64_data]", AVOID_NIL(base64Data, NSString), nil]];
    }

    // returns the remote data
    return remoteData;
}

- (void)convertRemoteGroupUpdate:(NSMutableArray *)remoteData {
    // retrieves the attributes
    NSNumber *objectId = [self.entity objectForKey:@"object_id"];
    NSString *objectIdString = objectId.stringValue;

    // sets the object id (structured and unstructured)
    [remoteData addObject:[NSArray arrayWithObjects:@"user[object_id]", AVOID_NIL(objectIdString, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"object_id", AVOID_NIL(objectIdString, NSString), nil]];
}

@end
