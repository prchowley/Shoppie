//
//  Cart+CoreDataProperties.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/7/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Cart.h"

NS_ASSUME_NONNULL_BEGIN

@interface Cart (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *cartid;
@property (nullable, nonatomic, retain) NSNumber *productid;
@property (nullable, nonatomic, retain) NSNumber *userid;

@end

NS_ASSUME_NONNULL_END
