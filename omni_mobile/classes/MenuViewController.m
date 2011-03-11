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

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "MenuViewController.h"

@implementation MenuViewController

@synthesize menuDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // defines the cell arrays
        NSArray *usersArray = [NSArray arrayWithObjects: @"Utilizadores", @"disk_32x36.png", nil];
        NSArray *salesArray = [NSArray arrayWithObjects: @"Vendas", @"disk_32x36.png", nil];
        NSArray *highlightsArray = [NSArray arrayWithObjects: @"Destaques", @"disk_32x36.png", nil];
        NSArray *notificationsArray = [NSArray arrayWithObjects: @"Notificações", @"disk_32x36.png", nil];
        
        // populates the menu dictionary
        self.menuDictionary = [NSMutableDictionary dictionary];
        [menuDictionary setValue:usersArray forKey:@"0,0"];
        [menuDictionary setValue:salesArray forKey:@"0,1"];
        [menuDictionary setValue:highlightsArray forKey:@"0,2"];
        [menuDictionary setValue:notificationsArray forKey:@"1,0"];
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // retrieves the section and row
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    // defines the cell identifier
    NSString *cellIdentifier = [NSString stringWithFormat:@"%d,%d", section, row];
    
    // retrieves the cell values
    NSArray *cellArray = [menuDictionary objectForKey:cellIdentifier];
    NSString *cellValue = [cellArray objectAtIndex:0]; 
    NSString *cellImage = [cellArray objectAtIndex:1]; 
    
    // tries to retrives the cell from cache (reusable)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // in case the cell is not defined in the cuurrent cache
    // need to create a new cell
    if (cell == nil) {
        // creates the new cell with the given reuse identifier
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    // sets the text label text
    cell.textLabel.text = cellValue;
    
    // sets the image view image
    cell.imageView.image = [UIImage imageNamed:cellImage];
        
    // returns the cell
    return cell;
}

@end
