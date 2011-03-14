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

#import <UIKit/UIKit.h>

/**
 * Main entry point function to be called upon
 * initialization.
 *
 * @param argc The number of arguments received.
 * @param argv The argument values received.
 * @return The application return code.
 */
int main(int argc, char *argv[]) {
    // keeps the classes available at runtime
    [MBRemoteTableView _keepAtLinkTime];
    [MBRemoteTableViewDataSource _keepAtLinkTime];
    
    // creates a new auto release pool
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // runs the ui application main and retrieves the return value
    int returnValue = UIApplicationMain(argc, argv, nil, nil);
    
    // releases the (auto release) pool
    [pool release];
    
    // returns the return value
    return returnValue;
}
