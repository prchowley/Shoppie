//
//  NavigationBar.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBar : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constXlblTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnCart;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@property (weak, nonatomic) IBOutlet UITextField *txtSearch;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constWidthTextSearch;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constHeightTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constYlblTitle;

@end
