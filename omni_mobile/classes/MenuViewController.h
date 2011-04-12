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

#import "Dependencies.h"

#import "LoginViewController.h"
#import "UsersViewController.h"
#import "SalesViewController.h"
#import "InventoryViewController.h"
#import "EmployeesViewController.h"
#import "CreditsViewController.h"
#import "OptionsMenuViewController.h"

/**
 * The description font size for menu items.
 */
#define MENU_VIEW_CONTROLLER_ITEM_DESCRIPTION_FONT_SIZE 18

@interface MenuViewController : HMTableViewController<HMItemTableViewProvider, HMItemTableViewDelegate> {
    @private
    HMNamedItemGroup *_menuItemGroup;
}

/**
 * The named item group that represent the menu.
 */
@property (retain) HMNamedItemGroup *menuItemGroup;

/**
 * Constructs the internal data structures.
 */
- (void)constructStructures;

/**
 * Refreshes the login structures, showing the login screen
 * if necessary.
 */
- (void)refreshLogin;

/**
 * Callback called when logout button was clicked.
 *
 * @param sender The sender of the event.
 * @param exrtra Extra parameter for the event.
 */
- (void)logoutButtonClicked:(id)sender extra:(id)extra;

/**
 * Callback called when accoutn button was clicked.
 *
 * @param sender The sender of the event.
 * @param exrtra Extra parameter for the event.
 */
- (void)accountButtonClicked:(id)sender extra:(id)extra;

@end
