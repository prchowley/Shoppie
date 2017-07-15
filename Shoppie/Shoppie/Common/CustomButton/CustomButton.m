//
//  CustomButton.m
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (_isRound) {
        self.layer.cornerRadius = self.frame.size.width/2;
        self.layer.masksToBounds = YES;
    }
}


@end
