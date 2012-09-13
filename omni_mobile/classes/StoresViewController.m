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

// __author__    = Luís Martinho <lmartinho@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "StoresViewController.h"

@implementation StoresViewController

- (NSString *)getTitle {
    return NSLocalizedString(@"Stores", @"Stores");
}

- (NSString *)getNewEntityTitle {
    return NSLocalizedString(@"New Store", @"New Store");
}

- (UIColor *)getHeaderColor {
    return OMNI_BAR_COLOR;
}

- (id)getViewController {
    // initializes the store view controller
    StoreViewController *storeViewController = [[StoreViewController alloc] initWithNibNameAndType:@"StoreViewController" bundle:[NSBundle mainBundle] operationType:HMItemOperationRead];

    // returns the store view controller
    return [storeViewController autorelease];
}

- (id)getNewEntityViewController {
    // initializes the store view controller
    StoreViewController *storeViewController = [[StoreViewController alloc] initWithNibNameAndType:@"StoreViewController" bundle:[NSBundle mainBundle] operationType:HMItemOperationCreate];

    // returns the store view controller
    return [storeViewController autorelease];
}

- (NSString *)getRemoteUrl {
    return [self.entityAbstraction constructClassUrl:@"stores" serializerName:@"json"];
}

- (HMRemoteTableViewSerialized)getRemoteType {
    return HMRemoteTableViewJsonSerialized;
}

- (NSString *)getItemName {
    return @"stores";
}

- (NSString *)getItemTitleName {
    return @"name";
}

@end
