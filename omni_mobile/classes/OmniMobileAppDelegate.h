// Hive Omni ERP
// Copyright (c) 2008-2020 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2020 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#import "LoginViewController.h"

@interface OmniMobileAppDelegate : NSObject<UIApplicationDelegate, HMApplicationDelegate> {
}

/**
 * The application's main window.
 */
@property (nonatomic, retain) IBOutlet UIWindow *window;

/**
 * The main navigation controller to be used by the application.
 */
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

/**
 * Checks the launch options trying to find the user
 * information map.
 *
 * @param launchOptions The options used to launch the application.
 */
- (void)checkUserInformation:(NSDictionary *)launchOptions;

/**
 * Loads the current user settings.
 */
- (void)loadSettings;

/**
 * Loads the notifications sub system (apn), this
 * call should trigger the loading of the token
 * identifier and generate a call.
 */
- (void)loadNotifications;

/**
 * Saves the current user settings.
 *
 * @param data The data to be used in the saving.
 */
- (void)saveSettings:(NSString *)data;

/**
 * Sets the preferneces default value using the given
 * preferences structure.
 *
 * @param preferences The preferences structure to be used to set
 * the default value.
 * @param defaultValue The default value to be set.
 * @param key The key value to be used.
 */
- (void)setPreferencesDefaultValue:(NSUserDefaults *)preferences defaultValue:(NSObject *)defaultValue key:(NSString *)key;

@end
