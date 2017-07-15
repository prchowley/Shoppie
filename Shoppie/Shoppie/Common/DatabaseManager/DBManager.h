//
//  DBManager.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/5/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBHandler.h"
#import "DBClasses.h"


typedef NS_ENUM(NSInteger, kEntityType) {
    kEntityTypeUser,
    kEntityTypeProduct,
    kEntityTypeCity,
    kEntityTypeCart
};

@interface DBManager : NSObject

+ (void)insertData:(NSMutableDictionary *)dictBehaviour intoEntityType:(kEntityType)type;
+ (void)getDBValuesOfType:(kEntityType)entity andPerdicate:(NSString *)strPredicate andWithCompletion:(void(^)(NSArray *items))completion;
+ (void)deleteItemOfID:(NSString *)strID inType:(kEntityType)entity;
+ (void)buyProduct:(Product *)product;

@end
