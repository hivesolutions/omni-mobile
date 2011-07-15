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
 * Loads the notifications system.
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
