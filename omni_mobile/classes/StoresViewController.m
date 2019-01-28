// Hive Omni ERP
// Copyright (c) 2008-2019 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2019 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

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
