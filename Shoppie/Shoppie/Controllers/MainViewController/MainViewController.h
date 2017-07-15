//
//  MainViewController.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController  <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *viewSort;

@end
