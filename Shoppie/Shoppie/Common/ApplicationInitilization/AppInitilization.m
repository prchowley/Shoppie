//
//  AppInitilization.m
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/10/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "AppInitilization.h"

@implementation AppInitilization


+ (void)appDataInitialization{
    
    NSMutableDictionary * dicCityKolkata = [NSMutableDictionary dictionary];
    [dicCityKolkata setValue:@(1) forKey:@"cityid"];
    [dicCityKolkata setValue:@"Kolkata" forKey:@"cityName"];
    
    NSMutableDictionary * dicCityMumbai = [NSMutableDictionary dictionary];
    [dicCityMumbai setValue:@(2) forKey:@"cityid"];
    [dicCityMumbai setValue:@"Mumbai" forKey:@"cityName"];
    
    //Over here we have to insert all the values into the database
    //as this project only use offline data
    //so we just need to insert product and users (with type)
    //into the database
    
    if (!getDefaultsValueForKey(@"firstRun")) {
        
        [DBManager insertData:dicCityKolkata intoEntityType:kEntityTypeCity];
        [DBManager insertData:dicCityMumbai intoEntityType:kEntityTypeCity];
        updateDefaults(@"firstRun", @"firstRun");
        
        
        for (int retailerCount = 0; retailerCount < 2; retailerCount++) {
            
            //inserting some retailers
            //here retailers are also user
            
            NSMutableDictionary * dicFirstRetailer = [NSMutableDictionary dictionary];
            [dicFirstRetailer setObject:[NSNumber numberWithInt:retailerCount] forKey:@"userid"];
            [dicFirstRetailer setValue:[NSString stringWithFormat:@"Test Retailer %d",retailerCount] forKey:@"name"];
            [dicFirstRetailer setValue:@(2) forKey:@"cityid"];
            [dicFirstRetailer setValue:@"test@test.com" forKey:@"email"];
            [dicFirstRetailer setValue:@"12345676543" forKey:@"phoneNumber"];
            [dicFirstRetailer setValue:@"12345" forKey:@"password"];
            [dicFirstRetailer setValue:[NSString stringWithFormat:@"Test Retailer %d",retailerCount] forKey:@"username"];
            [dicFirstRetailer setValue:@(0) forKey:@"type"];
            
            [DBManager insertData:dicFirstRetailer intoEntityType:kEntityTypeUser];
            
            
            for (int productCount = 0; productCount < 5; productCount++) {
                
                NSMutableDictionary * dictProductForFirstRetailer = [NSMutableDictionary dictionary];
                
                [dictProductForFirstRetailer setValue:[NSString stringWithFormat:@"Product %d",productCount] forKey:@"name"];
                [dictProductForFirstRetailer setValue:@((retailerCount * 100)-productCount) forKey:@"quantity"];
                [dictProductForFirstRetailer setValue:@((retailerCount * 100)+productCount) forKey:@"price"];
                [dictProductForFirstRetailer setValue:[NSDate date] forKey:@"dateAdded"];
                [dictProductForFirstRetailer setValue:[NSString stringWithFormat:@"%d",retailerCount] forKey:@"addedBy"];
                [dictProductForFirstRetailer setValue:@"placeholder" forKey:@"productImage"];
                [dictProductForFirstRetailer setValue:@"Lorem ipsum" forKey:@"details"];
                [dictProductForFirstRetailer setValue:@"1" forKey:@"availablelocation"];
                
                [DBManager insertData:dictProductForFirstRetailer intoEntityType:kEntityTypeProduct];
                
            }
            
        }
        
    }
    
    
}

@end
