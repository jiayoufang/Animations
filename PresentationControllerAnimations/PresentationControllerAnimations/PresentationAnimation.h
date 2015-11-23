//
//  PresentationAnimation.h
//  PresentationControllerAnimations
//
//  Created by fangjiayou on 15/11/23.
//  Copyright © 2015年 方. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PresentationAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign) BOOL presenting;//表示当前是否展现了
@property(nonatomic,assign) CGRect originFrame;

@end
