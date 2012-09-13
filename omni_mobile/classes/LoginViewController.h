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
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

/**
 * View controller responsible for the login view.
 */
@interface LoginViewController : HMAuthenticationViewController<HMItemTableViewProvider, HMItemTableViewDelegate, HMRemoteDelegate> {
    @private
    HMRemoteAbstraction *_remoteAbstraction;
    HMNamedItemGroup *_loginItemGroup;
    HMStringTableCellItem *_usernameItem;
    HMStringTableCellItem *_passwordItem;
}

/**
 * The remote abstraction to be used to perform
 * requests.
 */
@property (retain) HMRemoteAbstraction *remoteAbstraction;

/**
 * The login item group used to the describe the
 * login items.
 */
@property (retain) HMNamedItemGroup *loginItemGroup;

/**
 * The item describing the username.
 */
@property (retain) HMStringTableCellItem *usernameItem;

/**
 * The item describing the password.
 */
@property (retain) HMStringTableCellItem *passwordItem;

/**
 * Constructs the internal data structures.
 */
- (void)constructStructures;

@end
