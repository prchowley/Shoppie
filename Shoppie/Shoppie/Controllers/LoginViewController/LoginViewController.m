//
//  LoginViewController.m
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constYLogo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constHeightBtnGo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constWidthBtnGo;

@property (weak, nonatomic) IBOutlet CustomButton *btnGo;

@property (weak, nonatomic) IBOutlet UILabel *logo;

@end

@implementation LoginViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //get the Y of half of half of the view
    CGFloat yTransitionValue = self.view.frame.size.height/4;
    
    [PCAnimations animationChangeConstraints:_constYLogo toValueConstant:-yTransitionValue withDuration:0.7 onViewController:self];
    
}

// MARK:- Buttons' Action -
- (IBAction)actionButton:(CustomButton *)btn{
    
    _constWidthBtnGo.constant = self.view.frame.size.width+50;
    
    [UIView animateWithDuration:0.7 animations:^{
    
        [self.view layoutIfNeeded];
    
    } completion:^(BOOL finished) {
        
        double dist = hypot((_logo.center.x-_btnGo.center.x), (_logo.center.y-_btnGo.center.y));
        _constYLogo.constant = - self.view.bounds.size.height + dist;
        
        [UIView animateWithDuration:0.7 animations:^{
            
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            [self gotoViewControllerOfName:@"MainViewController"];
            
        }];
        
    }];
    
}

@end
