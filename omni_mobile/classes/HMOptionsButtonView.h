// Hive Mobile
// Copyright (C) 2008 Hive Solutions Lda.
//
// This file is part of Hive Mobile.
//
// Hive Mobile is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Mobile is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Mobile. If not, see <http://www.gnu.org/licenses/>.

// __author__    = Jo‹o Magalh‹es <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

/**
 * The options button view width.
 */
#define HM_OPTIONS_BUTTON_VIEW_WIDTH 106

/**
 * The options button view border width.
 */
#define HM_OPTIONS_BUTTON_VIEW_BORDER_WIDTH 108

/**
 * The options button view height.
 */
#define HM_OPTIONS_BUTTON_VIEW_HEIGHT 120

@interface HMOptionsButtonView : UIView {
    @private
    UIButton *_button;
    UILabel *_label;
    UIImage *_iconImage;
    NSString *_text;
    BOOL _widthBorder;
    BOOL _heightBorder;
}

/**
 * The button to be used internally for
 * state control.
 */
@property (retain) UIButton *button;

/**
 * The label to be used internally for
 * state control.
 */
@property (retain) UILabel *label;

/**
 * The icon image that represents the
 * options button.
 */
@property (retain) UIImage *iconImage;

/**
 * The text to be presented in the label.
 * This text should represent the button.
 */
@property (retain) NSString *text;

/**
 * Controls if a width border should
 * be drawn to separate items.
 */
@property (assign) BOOL widthBorder;

/**
 * Controls if a height border should
 * be drawn to separate items.
 */
@property (assign) BOOL heightBorder;

/**
 * Initializes the structures.
 */
- (void)initStructures;

@end
