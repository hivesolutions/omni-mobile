// Hive Omni Erp
// Copyright (C) 2008-2015 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2015 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "UsersViewController.h"

@implementation UsersViewController

- (NSString *)getTitle {
    return NSLocalizedString(@"Users", @"Users");
}

- (NSString *)getNewEntityTitle {
    return NSLocalizedString(@"New User", @"New User");
}

- (UIColor *)getHeaderColor {
    return OMNI_BAR_COLOR;
}

- (id)getViewController {
    // initializes the user view controller
    UserViewController *userViewController = [[UserViewController alloc] initWithNibNameAndType:@"UserViewController" bundle:[NSBundle mainBundle] operationType:HMItemOperationRead];

    // returns the user view controller
    return [userViewController autorelease];
}

- (id)getNewEntityViewController {
    // initializes the user view controller
    UserViewController *userViewController = [[UserViewController alloc] initWithNibNameAndType:@"UserViewController" bundle:[NSBundle mainBundle] operationType:HMItemOperationCreate];

    // returns the user view controller
    return [userViewController autorelease];
}

- (NSString *)getRemoteUrl {
    return [self.entityAbstraction constructClassUrl:@"system_users" serializerName:@"json"];
}

- (HMRemoteTableViewSerialized)getRemoteType {
    return HMRemoteTableViewJsonSerialized;
}

- (NSString *)getItemTitleName {
    return @"username";
}

@end
