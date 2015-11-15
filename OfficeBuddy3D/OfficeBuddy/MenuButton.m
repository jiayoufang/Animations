//
//  MenuButton.m
//  OfficeBuddy
//
//  Created by fangjiayou on 15/11/13.
//  Copyright © 2015年 方. All rights reserved.
//

#import "MenuButton.h"

@implementation MenuButton

- (void)didMoveToSuperview
{
    self.frame = CGRectMake(0, 0, 20.0, 20.0);
    
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu"]];
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
    [_imageView addGestureRecognizer:tap];
    [self addSubview:_imageView];
}

- (void)didTap:(UITapGestureRecognizer *)tap
{
    if (self.tapHandler) {
        self.tapHandler();
    }
}

@end
