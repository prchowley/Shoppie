//
//  ProductTableViewCell.h
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;
@property (weak, nonatomic) IBOutlet UIButton *btnView;
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProduct;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constWidthButton;
@end
