//
//  MenuButton.h
//  OfficeBuddy
//
//  Created by fangjiayou on 15/11/13.
//  Copyright © 2015年 方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuButton : UIView

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,copy) void (^tapHandler)();

@end
