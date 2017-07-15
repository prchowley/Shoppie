//
//  Product+CoreDataProperties.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/5/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface Product (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *productID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *quantity;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSDate *dateAdded;
@property (nullable, nonatomic, retain) NSString *addedBy;
@property (nullable, nonatomic, retain) NSString *productImage;
@property (nullable, nonatomic, retain) NSString *details;
@property (nullable, nonatomic, retain) NSString *availablelocation;

@end

NS_ASSUME_NONNULL_END
