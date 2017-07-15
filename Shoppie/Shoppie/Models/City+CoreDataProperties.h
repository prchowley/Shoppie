//
//  City+CoreDataProperties.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/5/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@interface City (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber * cityid;
@property (nullable, nonatomic, retain) NSString * cityName;

@end

NS_ASSUME_NONNULL_END
