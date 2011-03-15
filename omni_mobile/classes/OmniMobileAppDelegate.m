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

#import "OmniMobileAppDelegate.h"

@implementation OmniMobileAppDelegate

@synthesize window = _window;

@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // sets the window as the key one and visible
    [self.window makeKeyAndVisible];
    
    // loads the settgins
    [self loadSettings];
    
    // returns valid
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveSettings:@"tobias"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

/**
 * Called upon application termination.
 *
 * @param application The application to be terminated.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveSettings:@"tobias"];
}

/**
 * Destructor of the class.
 */
- (void)dealloc {
    // releases the window
    [_window release];

    // releases the navigation controller
    [_navigationController release];

    // calls the super
    [super dealloc];
}

- (void)loadSettings {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // retrieves the notifications value
    BOOL notifications = (BOOL) [preferences objectForKey:@"notifications"];
}

- (void)saveSettings:(NSString *)data {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // syncs the preferences
    [preferences synchronize];
}

@end
