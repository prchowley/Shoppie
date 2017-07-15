//
//  DBHandler.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/5/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DBHandler : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSManagedObjectContext *databaseContext;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (DBHandler *)sharedDatabaseHandler;

- (void)performDatabaseOperationWithContext:(void (^) (NSManagedObjectContext * managedObjectContext))completion;

- (void)resetDB;

@end
