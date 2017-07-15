//
//  NavigationBar.m
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnSearchAction:(id)sender {
    
    [self.txtSearch becomeFirstResponder];
    
    if (_constWidthTextSearch.constant == 0) {
        
        
        _constWidthTextSearch.constant = self.bounds.size.width-(_btnCart.frame.size.width*2)-30;
        
        [UIView animateWithDuration:0.5 animations:^{
            _lblTitle.alpha = 0.0;
            [self layoutIfNeeded];
        }];
    }else{
        [_txtSearch resignFirstResponder];
        _constWidthTextSearch.constant = 0;
        [UIView animateWithDuration:0.5 animations:^{
            _lblTitle.alpha = 1.0;
            [self layoutIfNeeded];
        }];
        
    }
    
    
    
}

@end
