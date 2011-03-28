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
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"users" serializerName:@"json"];
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
                                     @"", @"username",
                                     @"", @"password_hash",
                                     @"", @"email",
                                     @"", @"secret_question",
                                     @"", @"secret_answer_hash",
                                     nil];

    // returns the result of processing an empty remote data
    return [self processRemoteData:emptyRemoteData];
}

- (void)processRemoteData:(NSDictionary *)remoteData {
    // calls the super
    [super processRemoteData:remoteData];

    // retrieves the remote data attributes
    NSString *username = [remoteData objectForKey:@"username"];
    NSString *password = [remoteData objectForKey:@"password_hash"];
    NSString *email = [remoteData objectForKey:@"email"];
    NSString *secretQuestion = [remoteData objectForKey:@"secret_question"];
    NSString *secretAnswer = [remoteData objectForKey:@"secret_answer_hash"];

    // creates the menu header items
    HMItem *title = [[HMItem alloc] initWithIdentifier:username];
    HMItem *subTitle = [[HMItem alloc] initWithIdentifier:username];
    HMItem *image = [[HMItem alloc] initWithIdentifier:@"user.png"];

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

    // populates the first section item list
    [firstSectionItemGroup addItem:passwordItem];
    [firstSectionItemGroup addItem:emailItem];

    // populates the second section item list
    [secondSectionItemGroup addItem:secretQuestionItem];
    [secondSectionItemGroup addItem:secretAnswerItem];

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
    [secretAnswerItem release];
    [secretQuestionItem release];
    [passwordItem release];
    [emailItem release];
    [menuHeaderGroup release];
    [image release];
    [subTitle release];
    [title release];
}

- (NSMutableDictionary *)convertRemoteGroup {
    // calls the super
    NSMutableDictionary *remoteData = [super convertRemoteGroup];

    // retrieves the menu header named group
    HMNamedItemGroup *menuHeaderNamedGroup = (HMNamedItemGroup *) [self.remoteGroup getItem:@"header"];

    // retrieves the items
    HMItem *username = [menuHeaderNamedGroup getItem:@"title"];

    // retrieves the menu list group
    HMItemGroup *menuListGroup = (HMItemGroup *) [self.remoteGroup getItem:@"list"];

    // retreves the section item groups
    HMItemGroup *firstSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:0];
    HMItemGroup *secondSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:1];

    // retrieves the first section items
    HMItem *passwordItem = [firstSectionItemGroup getItem:0];
    HMItem *emailItem = [firstSectionItemGroup getItem:1];

    // retrieves the second section items
    HMItem *secretQuestion = [secondSectionItemGroup getItem:0];
    HMItem *secretAnswer = [secondSectionItemGroup getItem:1];

    // sets the items in the remote data
    [remoteData setObject:username.identifier forKey:@"user[username]"];
    [remoteData setObject:emailItem.description forKey:@"user[email]"];
    [remoteData setObject:secretQuestion.description forKey:@"user[secret_question]"];

    // sets the parameter items in the remote data
    [remoteData setObject:passwordItem.description forKey:@"user[_parameters][password]"];
    [remoteData setObject:passwordItem.description forKey:@"user[_parameters][confirm_password]"];
    [remoteData setObject:secretAnswer.description forKey:@"user[_parameters][secret_answer]"];

    // @TODO CHANGE THIS HARDCODE
    switch(self.operationType) {
        // in case the operation is read
        case HMItemOperationRead:
            // converts teh remote group for read
            [self convertRemoteGroupRead:remoteData];

            // breaks the switch
            break;

        default:
            break;
    }

    // returns the remote data
    return remoteData;
}

- (void)convertRemoteGroupRead:(NSMutableDictionary *)remoteData {
    // retrieves the object id
    NSNumber *objectId = [self.entity objectForKey:@"object_id"];
    NSString *objectIdString = [objectId stringValue];

    // sets the object id (structured and unstructured)
    [remoteData setObject:objectIdString forKey:@"user[object_id]"];
    [remoteData setObject:objectIdString forKey:@"object_id"];
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
