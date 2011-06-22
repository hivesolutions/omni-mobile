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

- (void)dealloc {
    // releases the window
    [_window release];

    // releases the navigation controller
    [_navigationController release];

    // calls the super
    [super dealloc];
}

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
    [self saveSettings:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (id)getAuthenticationViewController {
    // initializes the login view controller
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];

    // returns the login view controller
    return [loginViewController autorelease];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveSettings:nil];
}

- (void)loadSettings {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // sets the preferences default value
    [self setPreferencesDefaultValue:preferences defaultValue:@"http://erp.startomni.com:8080/colony_dynamic/rest/mvc/omni" key:@"baseUrl"];

    // syncs the preferences
    [preferences synchronize];
}

- (void)saveSettings:(NSString *)data {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // syncs the preferences
    [preferences synchronize];
}

- (void)setPreferencesDefaultValue:(NSUserDefaults *)preferences defaultValue:(NSString *)defaultValue key:(NSString *)key {
    // retrieves the preferences value
    NSString *preferencesValue = [preferences valueForKey:key];

    // in case the preferences value is invalid or empty
    if(preferencesValue == nil || [preferencesValue isEqualToString:@""]) {
        // sets the base url
        [preferences setValue:defaultValue forKey:key];
    }
}

@end
