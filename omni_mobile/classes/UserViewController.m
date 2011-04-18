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

// __author__    = Jo‹o Magalh‹es <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "UserViewController.h"

@implementation UserViewController

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"users" serializerName:@"json"];
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
    NSString *password = AVOID_NULL([remoteData objectForKey:@"password_hash"]);
    NSString *email = AVOID_NULL([remoteData objectForKey:@"email"]);
    NSString *secretQuestion = AVOID_NULL([remoteData objectForKey:@"secret_question"]);
    NSString *secretAnswer = AVOID_NULL([remoteData objectForKey:@"secret_answer_hash"]);
    NSDictionary *person = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"person"]);
    NSString *personName = AVOID_NULL([person objectForKey:@"name"]);

    // checks if the persons is available
    BOOL isPersonAvailable = [person count] == 0 ? NO : YES;

    // creates the title item
    HMItem *titleItem = [[HMItem alloc] initWithIdentifier:@"title"];
    titleItem.defaultValue = NSLocalizedString(@"Username", @"Username");
    titleItem.description = username;

    // creates the subtitle item
    HMItem *subTitleItem = [[HMItem alloc] initWithIdentifier:@"subTitle"];
    subTitleItem.description = @"";

    // creates the image item
    HMItem *imageItem = [[HMItem alloc] initWithIdentifier:@"image"];
    imageItem.description = @"person_header.png";

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the password string table cell
    HMStringTableCellItem *passwordItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"password"];
    passwordItem.name = NSLocalizedString(@"Password", @"Password");
    passwordItem.description = password;
    passwordItem.secure = YES;

    // creates the email string table cell
    HMStringTableCellItem *emailItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"email"];
    emailItem.name = NSLocalizedString(@"E-mail", @"E-mail");
    emailItem.description = email;

    // creates the secret question string table cell
    HMStringTableCellItem *secretQuestionItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"secret_question"];
    secretQuestionItem.name = NSLocalizedString(@"Question", @"Question");
    secretQuestionItem.description = secretQuestion;

    // creates the secret answer string table cell
    HMStringTableCellItem *secretAnswerItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"secret_answer"];
    secretAnswerItem.name = NSLocalizedString(@"Answer", @"Answer");
    secretAnswerItem.description = secretAnswer;
    secretAnswerItem.secure = YES;

    // creates the employee string table cell
    HMConstantStringTableCellItem *employeeItem = [[HMConstantStringTableCellItem alloc] initWithIdentifier:@"employee"];
    employeeItem.name = NSLocalizedString(@"Employee", @"Employee");
    employeeItem.description = personName;
    employeeItem.data = person;
    employeeItem.accessoryType = @"disclosure_indicator";
    employeeItem.readViewController = [EmployeeViewController class];
    employeeItem.readNibName = @"EmployeeViewController";
    employeeItem.editViewController = [EmployeesViewController class];
    employeeItem.editNibName = @"EmployeesViewController";
    employeeItem.deletableRow = YES;
    employeeItem.deleteActionType = HMTableCellItemDeleteActionTypeClear;
    employeeItem.selectable = isPersonAvailable;
    employeeItem.selectableEdit = YES;

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
    [secretAnswerItem release];
    [secretQuestionItem release];
    [passwordItem release];
    [emailItem release];
    [menuHeaderGroup release];
    [imageItem release];
    [subTitleItem release];
    [titleItem release];
}

- (NSMutableArray *)convertRemoteGroup:(HMItemOperationType)operationType {
    // calls the super
    NSMutableArray *remoteData = [super convertRemoteGroup:operationType];

    // retrieves the menu header named group
    HMNamedItemGroup *menuHeaderNamedGroup = (HMNamedItemGroup *) [self.remoteGroup getItem:@"header"];

    // configures the username item
    HMItem *usernameItem = [menuHeaderNamedGroup getItem:@"title"];

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
    HMItem *employee = [thirdSectionItemGroup getItem:0];

    // retrieves the employee object id
    NSDictionary *employeeData = (NSDictionary *) employee.data;
    NSNumber *employeeObjectId = [employeeData objectForKey:@"object_id"];

    // sets the items in the remote data
    [remoteData addObject:[NSArray arrayWithObjects:@"user[username]", AVOID_NIL(usernameItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"user[email]", AVOID_NIL(emailItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"user[secret_question]", AVOID_NIL(secretQuestion.description, NSString), nil]];

    // sets the parameter items in the remote data
    [remoteData addObject:[NSArray arrayWithObjects:@"user[_parameters][password]", AVOID_NIL(passwordItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"user[_parameters][confirm_password]", AVOID_NIL(passwordItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"user[_parameters][secret_answer]", AVOID_NIL(secretAnswer.description, NSString), nil]];

    // sets the employee to null in case it's not defined
    if(employeeObjectId == nil) {
        [remoteData addObject:[NSArray arrayWithObjects:@"user[person]", [NSNull null], nil]];
    } else {
        // otherwise sets the related employee
        NSString *employeeObjectIdString = [NSString stringWithFormat:@"%d", [employeeObjectId intValue]];
        [remoteData addObject:[NSArray arrayWithObjects:@"user[person][object_id]", employeeObjectIdString, nil]];
    }

    // returns the remote data
    return remoteData;
}

- (void)convertRemoteGroupUpdate:(NSMutableArray *)remoteData {
    // retrieves the object id
    NSNumber *objectId = [self.entity objectForKey:@"object_id"];
    NSString *objectIdString = [objectId stringValue];

    // sets the object id (structured and unstructured)
    [remoteData addObject:[NSArray arrayWithObjects:@"user[object_id]", AVOID_NIL(objectIdString, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"object_id", AVOID_NIL(objectIdString, NSString), nil]];
}

@end
