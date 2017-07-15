//
//  DBManager.m
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/5/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

// MARK:- CRUD -

// MARK:- CREATE -
+ (void)insertData:(NSMutableDictionary *)dict intoEntityType:(kEntityType)type{
    [[DBHandler sharedDatabaseHandler] performDatabaseOperationWithContext:^(NSManagedObjectContext *managedObjectContext) {
        
        NSError *err = nil;
        
        switch (type) {
            case kEntityTypeUser:
            {
                Users *user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Users class]) inManagedObjectContext:managedObjectContext];
                [self getDBValuesOfType:kEntityTypeUser andPerdicate:nil andWithCompletion:^(NSArray *items) {
                    user.userid = [NSNumber numberWithInteger:items.count];
                }];
                user.name           = [dict valueForKey:@"name"];
                user.phoneNumber    = [dict valueForKey:@"phoneNumber"];
                user.username       = [dict valueForKey:@"username"];
                user.password       = [dict valueForKey:@"password"];
                user.type           = [dict valueForKey:@"type"];
                user.email          = [dict valueForKey:@"email"];
                user.address        = [dict valueForKey:@"address"];
                user.cityid         = [[dict valueForKey:@"cityid"] isEqual:@""]?@(1):[dict valueForKey:@"cityid"];
            }
                break;
            case kEntityTypeProduct:
            {
                Product *product = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Product class]) inManagedObjectContext:managedObjectContext];
                [self getDBValuesOfType:kEntityTypeProduct andPerdicate:nil andWithCompletion:^(NSArray *items) {
                    product.productID = [NSNumber numberWithInteger:items.count];
                }];
                product.name               = [dict valueForKey:@"name"];
                product.quantity           = [dict valueForKey:@"quantity"];
                product.price              = [dict valueForKey:@"price"];
                product.dateAdded          = [dict valueForKey:@"dateAdded"];
                product.addedBy            = [dict valueForKey:@"addedBy"];
                product.productImage       = [dict valueForKey:@"productImage"];
                product.details            = [dict valueForKey:@"details"];
                product.availablelocation  = [dict valueForKey:@"availablelocation"];
            }
                break;
            case kEntityTypeCity:
            {
                City *city = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([City class]) inManagedObjectContext:managedObjectContext];
                city.cityid         = [dict valueForKey:@"cityid"];
                city.cityName       = [dict valueForKey:@"cityName"];
            }
                break;
            case kEntityTypeCart:
            {
                Cart *cart = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Cart class]) inManagedObjectContext:managedObjectContext];
                
                cart.productid       = [NSNumber numberWithInt:[[dict valueForKey:@"productid"] intValue]];
                cart.userid          = [NSNumber numberWithInt:1];
                [self getDBValuesOfType:kEntityTypeCart andPerdicate:nil andWithCompletion:^(NSArray *items) {
                    cart.cartid = [NSNumber numberWithInteger:items.count];
                }];
            }
                break;
            default:
                break;
        }
        
        
        if (![managedObjectContext save:&err])
        {
            NSLog(@"Couldn't save: %@", [err localizedDescription]);
        }
    }];
}

// MARK:- READ -
+ (void)getDBValuesOfType:(kEntityType)entity andPerdicate:(NSString *)strPredicate andWithCompletion:(void(^)(NSArray *items))completion{
    [[DBHandler sharedDatabaseHandler] performDatabaseOperationWithContext:^(NSManagedObjectContext *managedObjectContext) {
        
        NSFetchRequest *fetchRequest;
        
        
        NSError *error = nil;
        
        //checking if id exists then fatch the data for that id
        //otherwise fetch all data
        NSPredicate * predicate;
        if (strPredicate && ![strPredicate isEqualToString:@""]) {
            predicate = [NSPredicate predicateWithFormat:strPredicate];
        }
        
        
            switch (entity) {
                case kEntityTypeCart:
                {
                    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Cart class])];
                }
                    break;
                case kEntityTypeUser:
                {
                    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Users class])];
                }
                    break;
                case kEntityTypeProduct:
                {
                    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Product class])];
                }
                    break;
                case kEntityTypeCity:
                {
                    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([City class])];
                }
                    break;
                    
                default:
                    break;
            }
        
        
        [fetchRequest setPredicate:predicate];
        
        NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        NSArray *reverse = [[results reverseObjectEnumerator] allObjects];
        
        if ([reverse count]>0) {
            completion(reverse);
        } else {
            completion(nil);
        }
        
    }];
}

+ (void)buyProduct:(Product *)product{
    [[DBHandler sharedDatabaseHandler] performDatabaseOperationWithContext:^(NSManagedObjectContext *managedObjectContext) {
        
        NSError *err = nil;
        
        product.quantity           = [NSNumber numberWithInt:1];
        
        
        
        if (![managedObjectContext save:&err])
        {
            NSLog(@"Couldn't save: %@", [err localizedDescription]);
        }else{
            [self deleteItemOfID:product.productID.stringValue inType:kEntityTypeCart];
        }
    }];
}



// MARK:- DELETE -
+ (void)deleteItemOfID:(NSString *)strID inType:(kEntityType)entity{
    [[DBHandler sharedDatabaseHandler] performDatabaseOperationWithContext:^(NSManagedObjectContext *managedObjectContext) {
        
        NSFetchRequest *fetchRequest;
        NSError *error = nil;
        
        switch (entity) {
            case kEntityTypeCart:
            {
                fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Cart class])];
            }
                break;
                
            default:
                break;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productid == %d", strID.intValue];
        [fetchRequest setPredicate:predicate];
        
        NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        NSLog(@"%@",results);
        
        for (NSManagedObject *car in results) {
            [managedObjectContext deleteObject:car];
            [managedObjectContext save:&error];
        }
    }];
}

@end
