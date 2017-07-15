//
//  Product+CoreDataProperties.m
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/5/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Product+CoreDataProperties.h"

@implementation Product (CoreDataProperties)

@dynamic productID;
@dynamic name;
@dynamic quantity;
@dynamic price;
@dynamic dateAdded;
@dynamic addedBy;
@dynamic productImage;
@dynamic details;
@dynamic availablelocation;

@end
