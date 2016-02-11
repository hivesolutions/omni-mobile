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

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize remoteAbstraction = _remoteAbstraction;
@synthesize loginItemGroup = _loginItemGroup;
@synthesize usernameItem = _usernameItem;
@synthesize passwordItem = _passwordItem;

- (id)init {
    // calls the super
    self = [super init];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the remote abstraction
    [_remoteAbstraction release];

    // releases the login item group
    [_loginItemGroup release];

    // releases the username item
    [_usernameItem release];

    // releases the password item
    [_passwordItem release];

    // calls the super
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
    // retrieves the first child as the table view
    UITableView *tableView = [self.view.subviews objectAtIndex:0];

    // sets the table view as editing
    tableView.editing = YES;
}

- (void)constructStructures {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // sets the base url from the preferences
    NSString *baseUrl = [preferences objectForKey:@"baseUrl"];

    // creates the url from the base url and the login target
    NSString *url = [NSString stringWithFormat:@"%@/%@", baseUrl, @"login.json"];

    // creates the remote abstraction for the url
    HMRemoteAbstraction *remoteAbstraction = [[HMRemoteAbstraction alloc] initWithIdAndUrl:HMItemOperationRead url:url];
    remoteAbstraction.remoteDelegate = self;
    remoteAbstraction.view = self.view;

    // retrieves the background pattern image
    UIImage *backgroundPatternImage = [UIImage imageNamedDevice:@"login_background.png"];

    // creates the backgroun color with the pattern image
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundPatternImage];

    // retrieves the first child as the table view
    UITableView *tableView = [self.view.subviews objectAtIndex:0];

    // sets the background color in the table view (as transparent)
    tableView.backgroundColor = [UIColor clearColor];

    // sets the view background color
    self.view.backgroundColor = backgroundColor;

    // creates a new background view for transparency in ipad
    UIView *backgroundView = [[UIView alloc] init];

    // creates a new background view and
    [tableView setBackgroundView:backgroundView];

    // changes the title's image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 22)];
    UIImage *logoImage = [UIImage imageNamed:@"header_logo.png"];
    [imageView setImage:logoImage];
    self.navigationItem.titleView = imageView;

    // creates the white color
    HMColor *whiteColor = [[HMColor alloc] initWithColorRed:1.0 green:1.0 blue:1.0 alpha:1.0];

    // creates the username string item
    HMStringTableCellItem *usernameItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"username"];
    usernameItem.indentable = NO;
    usernameItem.defaultValue = NSLocalizedString(@"Username", @"Username");
    usernameItem.returnType = @"done";
    usernameItem.returnDisablesEdit = YES;
    usernameItem.focusEdit = YES;
    usernameItem.autocapitalizationType = nil;

    // creates the username string item
    HMStringTableCellItem *passwordItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"password"];
    passwordItem.secure = YES;
    passwordItem.indentable = NO;
    passwordItem.defaultValue = NSLocalizedString(@"Password", @"Password");
    passwordItem.returnType = @"done";
    passwordItem.returnDisablesEdit = YES;
    passwordItem.autocapitalizationType = nil;

    // creates the first section item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    firstSectionItemGroup.footerString = NSLocalizedString(@"Sentence000002", @"Sentence000002");

    // customizes the first section footer item
    HMLabelItem *firstSectionFooterItem = firstSectionItemGroup.footer;
    firstSectionFooterItem.descriptionFont.size = 14;
    firstSectionFooterItem.descriptionColor = whiteColor;
    firstSectionFooterItem.descriptionShadowColor = nil;
    firstSectionFooterItem.textAlignment = HMLabelItemTextAlignmentCenter;

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu
    [firstSectionItemGroup addItem:usernameItem];
    [firstSectionItemGroup addItem:passwordItem];

    // populates the menu list group
    [menuListGroup addItem:firstSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // sets the remote abstraction
    self.remoteAbstraction = remoteAbstraction;

    // stores the menu item group
    self.loginItemGroup = menuNamedItemGroup;

    // stores the cell items
    self.usernameItem = usernameItem;
    self.passwordItem = passwordItem;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [firstSectionItemGroup release];
    [passwordItem release];
    [usernameItem release];
    [whiteColor release];
    [imageView release];
    [backgroundView release];
    [remoteAbstraction release];
}

- (void)didSelectUsersButton {
    // initializes the users view controller
    UsersViewController *usersViewController = [[UsersViewController alloc] initWithNibName:@"UsersViewController" bundle:[NSBundle mainBundle]];

    // pushes the user view controller
    [self.navigationController pushViewController:usersViewController animated:YES];

    // releases the users view controller reference
    [usersViewController release];
}

- (HMNamedItemGroup *)getItemSpecification {
    return self.loginItemGroup;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)didSelectItemRowWithItem:(HMItem *)item {
}

- (void)didDeselectItemRowWithItem:(HMItem *)item {
}

- (void)setEditingChanged:(BOOL)editing {
    // in case the current state is editing
    if(editing) {
        // returns immediately
        return;
    }

    // retrieves the first child as the table view
    UITableView *tableView = [self.view.subviews objectAtIndex:0];

    // casts the table view as item table view
    HMItemTableView *itemTableView = (HMItemTableView *) tableView;

    // flushes the item specification (transient mode)
    [itemTableView flushItemSpecificationTransient:YES];

    // creates the login dictionary
    NSMutableDictionary *loginDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                            self.usernameItem.description, @"username",
                                            self.passwordItem.description, @"password",
                                            nil];

    // updates the remote abstraction with the remote data
    [self.remoteAbstraction updateRemoteWithData:loginDictionary method:HTTP_POST_METHOD setSession:NO];

    // releases the objects
    [loginDictionary release];
}

- (void)remoteDidSucceed:(HMRemoteAbstraction *)remoteAbstraction data:(NSData *)data connection:(NSURLConnection *)connection response:(NSURLResponse *)response {
    // creates a new json parser and uses it to parse the
    // received (remote) data and sets it into the instance
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *remoteData = [jsonParser objectWithData:data];

    // casts the response as http response
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;

    // in case the status code is valid
    if(httpResponse.statusCode == HTTP_VALID_STATUS_CODE) {
        // retrieves the various attributes from the remote data
        // to be set in the current internal structures (preferences)
        NSString *sessionId = [remoteData objectForKey:@"session_id"];
        NSString *username = [remoteData objectForKey:@"username"];
        NSNumber *objectId = [remoteData objectForKey:@"object_id"];

        // prints an authentication message, outputting the current
        // session identifier in use
        NSLog(@"Authenticated with session id: %@", sessionId);

        // retrieves the preferences structures (global wide for
        // application) and sets the various attributes in it, then
        // flushes its contents using the synchronize call
        NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
        [preferences setValue:sessionId forKey:@"sessionId"];
        [preferences setValue:username forKey:@"username"];
        [preferences setValue:objectId forKey:@"objectId"];
        [preferences synchronize];

        // in case the authentication delegate is set, notifies it
        // about the authentication complete (with success)
        if(self.authenticationDelegate) {
            [self.authenticationDelegate authenticationComplete:YES];
        }

        // pops the view controller
        [self dismissModalViewControllerAnimated:YES];
    }
    // otherwise there must be a problem
    else {
        // retrieves the exception map and uses it to retrieve both
        // the name of the exception and the message contained in it
        NSDictionary *exception = [remoteData objectForKey:@"exception"];
        NSString *exceptionName = [exception objectForKey:@"exception_name"];
        NSString *message = [exception objectForKey:@"message"];

        // prints the error message
        NSLog(@"Error with status: %d name: %@ and message: %@", httpResponse.statusCode, exceptionName, message);

        // creates the alert view to show the error message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"LoginErrorName", @"LoginErrorName") message:NSLocalizedString(message, message) delegate:nil cancelButtonTitle:NSLocalizedString(@"Confirm", @"Confirm") otherButtonTitles: nil];

        // shows the alert view
        [alert show];

        // releases the alert view
        [alert release];

        // retrieves the first child as the table view
        UITableView *tableView = [self.view.subviews objectAtIndex:0];

        // sets the table back to editing mode
        [tableView setEditing:YES animated:YES];
    }

    // releases the json parser
    [jsonParser release];
}

- (void)remoteDidFail:(HMRemoteAbstraction *)remoteAbstraction data:(NSData *)data error:(NSError *)error {
    // retrieves the first child as the table view
    UITableView *tableView = [self.view.subviews objectAtIndex:0];

    // sets the table back to editing mode
    [tableView setEditing:YES animated:YES];
}

@end
