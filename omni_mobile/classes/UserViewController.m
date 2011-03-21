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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // creates the edit ui bar button
    UIBarButtonItem *editUiBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonClick:extra:)];

    // sets the edit ui bar button
    self.navigationItem.rightBarButtonItem = editUiBarButton;

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the entity
    [self.entity release];

    // calls the super
    [super dealloc];
}

- (NSString *)getRemoteUrl {
    // retrieves the entity object id
    NSNumber *entityObjectId = [self.entity objectForKey:@"object_id"];

    // creates the url from the object id
    NSString *url = [NSString stringWithFormat:@"http://172.16.0.24:8080/colony_mod_python/rest/mvc/omni/users/%@.json", [entityObjectId stringValue]];

    // returns the url
    return url;
}

- (void)changeEntity:(NSDictionary *)entity {
    // sets the entity
    self.entity = entity;

    // updates the remote
    [self updateRemote];
}

- (void)editButtonClick:(id)sender extra:(id)extra {
    // in case the table view is in editing mode
    if(self.tableView.editing) {
        // sets the table view as not editing
        self.tableView.editing = NO;
    }
    // otherwise it must not be editing
    else {
        // sets the table view as editing
        self.tableView.editing = YES;
    }

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
