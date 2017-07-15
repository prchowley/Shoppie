//
//  Users+CoreDataProperties.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/5/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Users.h"

NS_ASSUME_NONNULL_BEGIN

@interface Users (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *userid;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSString * username;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSNumber *cityid;

@end

NS_ASSUME_NONNULL_END
