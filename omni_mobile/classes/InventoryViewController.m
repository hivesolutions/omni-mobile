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

#import "InventoryViewController.h"

@implementation InventoryViewController

@synthesize entityAbstraction = _entityAbstraction;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // initializes the structures
    [self initStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the entity abstraction
    [_entityAbstraction release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // sets the attributes
    self.title = NSLocalizedString(@"Inventory", @"Inventory");

    // sets the new bar button in the navigation item
    UIBarButtonItem *newBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newInventoryItem)];
    [self.navigationItem setRightBarButtonItem:newBarButton animated:YES];

    // creates the entity abstraction
    HMEntityAbstraction *entityAbstraction = [[HMEntityAbstraction alloc] init];

    // sets the attributes
    self.entityAbstraction = entityAbstraction;

    // releases the objects
    [entityAbstraction release];
    [newBarButton release];
}

- (void)newInventoryItem {
    // initializes the inventory item view controller
    InventoryItemViewController *inventoryItemViewController = [[InventoryItemViewController alloc] initWithNibNameAndType:@"InventoryItemViewController" bundle:[NSBundle mainBundle] operationType:HMItemOperationCreate];

    // sets the title in the inventory item view controller
    inventoryItemViewController.title = NSLocalizedString(@"New Item", @"New Item");

    // creates the navigation controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:inventoryItemViewController];

    // sets the navigation navigation bar tint color
    navigationController.navigationBar.tintColor = OMNI_BAR_COLOR;

    // presents the user view controller into the navigation controller
    [self presentModalViewController:navigationController animated:YES];

    // releases the user view controller reference
    [inventoryItemViewController release];

    // releases the navigation controller reference
    [navigationController release];
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
    return [self.entityAbstraction constructClassUrl:@"transactional_merchandise" serializerName:@"json"];
}

- (HMRemoteTableViewSerialized)getRemoteType {
    return HMRemoteTableViewJsonSerialized;
}

- (NSString *)getItemTitleName {
    return @"company_product_code";
}

- (void)didSelectRemoteRowWithData:(NSDictionary *)data {
    // initializes the inventory item view controller
    InventoryItemViewController *inventoryItemViewController = [[InventoryItemViewController alloc] initWithNibNameAndType:@"InventoryItemViewController" bundle:[NSBundle mainBundle] operationType:HMItemOperationRead];

    // changes the inventory item in the entity
    [inventoryItemViewController changeEntity:data];

    // pushes the inventory item view controller into the navigation controller
    [self.navigationController pushViewController:inventoryItemViewController animated:YES];

    // releases the inventory item view controller reference
    [inventoryItemViewController release];
}

- (void)didDeselectRemoteRowWithData:(NSDictionary *)data {
}

@end
