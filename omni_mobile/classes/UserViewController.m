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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // creates the edit ui bar button
    UIBarButtonItem *editUiBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:nil];

    // sets the edit ui bar button
    self.navigationItem.rightBarButtonItem = editUiBarButton;

    // sets the selector for the editr ui bar button action
    editUiBarButton.action = @selector(buttonClickedWithSender:extra:);

    UIView *headerView = [[[[[self view] subviews] objectAtIndex:0] subviews] objectAtIndex:0];

    // retrieves the header image
    UIImageView *headerImage = [[headerView subviews] objectAtIndex:0];

    // sets the header image rounded corners
    headerImage.layer.cornerRadius = 4.0;
    headerImage.layer.masksToBounds = YES;
    headerImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    headerImage.layer.borderWidth = 1.0;

    // returns the instance
    return self;
}

- (void)dealloc {
    // calls the super
    [super dealloc];
}

- (void)changeUser:(NSDictionary *)user {
    // retrieves the user attributes
    NSString *username = [user objectForKey:@"username"];
    NSDictionary *person = [user objectForKey:@"person"];

    // retrieves the person attributes
    NSString *personName = [person objectForKey:@"name"];

    // sets the view title
    self.title = username;

    // retrieves the header view
    UIView *headerView = [[[[[self view] subviews] objectAtIndex:0] subviews] objectAtIndex:0];

    // retrieves the header label
    UILabel *headerLabel = [[headerView subviews] objectAtIndex:1];

    // sets the username in the header label
    headerLabel.text = username;
}

- (void)buttonClickedWithSender:(id)sender extra:(id)extra {
    printf("carregou %d\r", (int) sender);
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
