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

// __author__    = Lu�s Martinho <lmartinho@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

@interface InventoryItemStoreViewController : HMRemoteHeaderItemTableViewController<HMEntityDelegate> {
    @private
    NSDictionary *_entity;
    NSString *_identifier;
    HMEntityAbstraction *_entityAbstraction;
}

/**
 * The entity represented by the view.
 */
@property (retain) NSDictionary *entity;

/**
 * The identifier of the represented by the view.
 */
@property (retain) NSString *identifier;

/**
 * The entity abstraction to be used for operations
 * in the entity.
 */
@property (retain) HMEntityAbstraction *entityAbstraction;

/**
 * Changes the entity in the view.
 * The argument is a map with all the entity attributes.
 *
 * @param user The entity to change to.
 */
- (void)changeEntity:(NSDictionary *)entity;

/**
 * Changes the identifier of the entity in the view.
 *
 * @param identifier The identifier of the entity to change to.
 */
- (void) changeIdentifier:(NSString *)identifier;

@end
