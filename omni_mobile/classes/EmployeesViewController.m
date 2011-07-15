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
