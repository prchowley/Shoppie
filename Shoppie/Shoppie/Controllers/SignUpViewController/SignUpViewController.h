//
//  SignUpViewController.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "BaseViewController.h"

@interface SignUpViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constHeightBottomView;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;

@end
