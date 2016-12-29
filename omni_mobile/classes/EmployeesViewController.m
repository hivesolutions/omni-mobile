// Hive Omni ERP
// Copyright (c) 2008-2017 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2017 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "EmployeesViewController.h"

@implementation EmployeesViewController

- (NSString *)getTitle {
    return NSLocalizedString(@"Employees", @"Employees");
}

- (NSString *)getNewEntityTitle {
    return NSLocalizedString(@"New Employee", @"New Employee");
}

- (UIColor *)getHeaderColor {
    return OMNI_BAR_COLOR;
}

- (id)getViewController {
    // initializes the employee view controller
    EmployeeViewController *employeeViewController = [[EmployeeViewController alloc] initWithNibNameAndType:@"EmployeeViewController" bundle:[NSBundle mainBundle] operationType:HMItemOperationRead];

    // returns the employee view controller
    return [employeeViewController autorelease];
}

- (id)getNewEntityViewController {
    // initializes the employee view controller
    EmployeeViewController *employeeViewController = [[EmployeeViewController alloc] initWithNibNameAndType:@"EmployeeViewController" bundle:[NSBundle mainBundle] operationType:HMItemOperationCreate];

    // returns the employee view controller
    return [employeeViewController autorelease];
}

- (NSString *)getRemoteUrl {
    return [self.entityAbstraction constructClassUrl:@"employees" serializerName:@"json"];
}

- (HMRemoteTableViewSerialized)getRemoteType {
    return HMRemoteTableViewJsonSerialized;
}

- (NSString *)getItemName {
    return @"employee";
}

- (NSString *)getItemTitleName {
    return @"name";
}

@end
