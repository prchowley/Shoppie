//
//  BaseViewController.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCAnimations.h"
#import "CustomButton.h"
#import "NavigationBar.h"
#import "DBManager.h"

@interface BaseViewController : UIViewController

- (void)setupNavigationBar;
- (void)gotoViewControllerOfName:(NSString *)viewControllerName;

@property (nonatomic, strong) NavigationBar * navBar;


- (CGFloat)widthOfView:(UIView *)view;
- (CGFloat)heightOfView:(UIView *)view;
@end


void updateDefaults(id value, NSString * key);
void removeDefaults(NSString * key);
id getDefaultsValueForKey(NSString * key);