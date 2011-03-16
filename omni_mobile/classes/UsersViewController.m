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

#import "UsersViewController.h"

@implementation UsersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // sets the attributes
    self.title = @"Users";

    // sets the new bar button in the navigation item
    UIBarButtonItem *newBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newUser)];
    self.navigationItem.rightBarButtonItem = newBarButton;

    // returns self
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)newUser {
    // initializes the users view controller
    UserViewController *userViewController = [[UserViewController alloc] initWithNibName:@"UserViewController" bundle:[NSBundle mainBundle]];

    // presents the user view controller into the navigation controller
    [self presentModalViewController:userViewController animated:YES];

    // releases the user view controller reference
    [userViewController release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (NSString *)getRemoteUrl {
    return @"http://172.16.0.24:8080/colony_mod_python/rest/mvc/omni/users.json";
}

- (HMRemoteTableViewSerialized)getRemoteType {
    return HMRemoteTableViewJsonSerialized;
}

- (void)didSelectRemoteRowWidthData:(NSDictionary *)data {
    // initializes the users view controller
    UserViewController *userViewController = [[UserViewController alloc] initWithNibName:@"UserViewController" bundle:[NSBundle mainBundle]];

    // changes the user in the user view
    [userViewController changeUser:data];

    // pushes the user view controller into the navigation controller
    [self.navigationController pushViewController:userViewController animated:YES];

    // releases the user view controller reference
    [userViewController release];
}

- (void)didDeselectRemoteRowWidthData:(NSDictionary *)data {
}

@end
