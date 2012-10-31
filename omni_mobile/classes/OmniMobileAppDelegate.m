// Hive Omni Erp
// Copyright (C) 2008-2012 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
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
    // checks for user information in the launch options
    [self checkUserInformation:launchOptions];

    // sets the window as the key one and visible
    [self.window makeKeyAndVisible];

    // loads the settings
    [self loadSettings];

    // loads the notifications
    [self loadNotifications];

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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)notificationToken {
    // converts the notification token into hexadecimal and then
    // into a base 64 code to be used in text sending
    NSString *notificationTokenHexadecimal = [HMHexadecimalUtil hexlifyData:notificationToken];
    NSString *notificationTokenBase64 = [HMBase64Util encodeBase64WithData:notificationToken];

    // prints a debug message with the notification token values
    // to be displayed
    NSLog(@"Registered with token: %@ / %@", notificationTokenHexadecimal, notificationTokenBase64);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // prints a debug message containing the error context
    NSLog(@"Error in registration: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInformation {
    // retrievs the aps map item to alert abou the
    // notification item
    NSDictionary *apsMap = [userInformation objectForKey:@"aps"];

    // prints a debug message
    NSLog(@"Received notification: %@", [apsMap objectForKey:@"alert"]);
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

- (void)checkUserInformation:(NSDictionary *)launchOptions {
    // tries to retrieve the user information from the launch options
    NSDictionary *userInformation = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];

    // in case the user information is not defined
    // must return immediately
    if(!userInformation) { return; }

    // retrievs the aps map
    NSDictionary *apsMap = [userInformation objectForKey:@"aps"];

    // prints a debug message
    NSLog(@"Called with message: %@", [apsMap objectForKey:@"alert"]);
}

- (void)loadSettings {
    // retrieves the preferences structure to be updated
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // sets the preferences default values, some of this values should
    // be static and others dynamic (configuration oriented)
    [self setPreferencesDefaultValue:preferences defaultValue:@"http://localhost:8080/dynamic/rest/mvc/omni" key:@"baseUrl"];
    [self setPreferencesDefaultValue:preferences defaultValue:[NSNumber numberWithInt:1] key:@"backgroundImage"];

    // syncs the preferences, updating the values in the cache
    // should enforce changes in other users
    [preferences synchronize];
}

- (void)loadNotifications {
    // retrieves the current (shared) application, then creates the
    // notification types for the notification registration and registers
    // the current system for the remote notifications (callback pending)
    UIApplication *currentApplication = [UIApplication sharedApplication];
    UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
    [currentApplication registerForRemoteNotificationTypes:notificationTypes];
}

- (void)saveSettings:(NSString *)data {
    // retrieves the preferences and syncs it forcing the
    // update of the current internal structures (should
    // some time to update)
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences synchronize];
}

- (void)setPreferencesDefaultValue:(NSUserDefaults *)preferences defaultValue:(NSObject *)defaultValue key:(NSString *)key {
    // retrieves the preferences value
    NSObject *preferencesValue = [preferences valueForKey:key];

    // in case the preferences value is invalid
    if(preferencesValue == nil) {
        // sets the base url
        [preferences setValue:defaultValue forKey:key];
    }
}

@end
