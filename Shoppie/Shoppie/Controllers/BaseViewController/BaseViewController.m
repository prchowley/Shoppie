//
//  BaseViewController.m
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

// MARK:- ViewController Functions -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //slide popover controller
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CGFloat leftPaddingOfTitle = 10;
    CGFloat constForXlbl = -((self.view.frame.size.width/2)-self.navBar.lblTitle.frame.size.width/2)+leftPaddingOfTitle;
    
    [PCAnimations animationChangeConstraints:self.navBar.constXlblTitle toValueConstant:constForXlbl withDuration:0.5 onViewController:self];
    
}

// MARK:- Naviation Bar -
- (void)setupNavigationBar{
    
    self.navBar = [[NSBundle mainBundle] loadNibNamed:@"NavigationBar" owner:self options:nil].firstObject;
    CGRect rectForNavBar = CGRectMake(0, 0, self.view.frame.size.width, 64);
    
    self.navBar.frame = rectForNavBar;
    
    [self.view addSubview:self.navBar];
    
    [PCAnimations animationChangeAlpha:self.navBar withDuration:0.5 andFromAlpha:0.0 andToAlpha:1.0];
    
    [self.navBar.btnCart addTarget:self action:@selector(gotoCartController:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)gotoCartController:(UIButton *)btn{
    [self gotoViewControllerOfName:@"CartViewController"];
}

- (void)gotoViewControllerOfName:(NSString *)viewControllerName{
    
    BaseViewController * vcMain = [self.storyboard instantiateViewControllerWithIdentifier:viewControllerName];
    
    [self.navigationController pushViewController:vcMain animated:NO];
    [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionNone animations:nil completion:nil];
    
    
}

// MARK:- Common -
- (CGFloat)widthOfView:(UIView *)view{
    return view.frame.size.width;
}
- (CGFloat)heightOfView:(UIView *)view{
    return view.frame.size.height;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



void updateDefaults(id value, NSString * key) {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

void removeDefaults(NSString * key) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

id getDefaultsValueForKey(NSString * key) {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

@end
