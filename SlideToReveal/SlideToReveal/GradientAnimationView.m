//
//  GradientAnimationView.m
//  SlideToReveal
//
//  Created by fangjiayou on 15/11/19.
//  Copyright © 2015年 方. All rights reserved.
//

#import "GradientAnimationView.h"

@interface GradientAnimationView ()

@property(nonatomic,strong) CAGradientLayer *gradientLayer;

@end

@implementation GradientAnimationView

- (void)setText:(NSString *)text
{
    [self setNeedsDisplay];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:28.0],
                                 NSParagraphStyleAttributeName:style,
                                 };
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    [text drawInRect:self.bounds withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    maskLayer.frame = CGRectOffset(self.bounds, CGRectGetWidth(self.bounds), 0);
    maskLayer.contents = (__bridge id _Nullable)(image.CGImage);
    
    self.gradientLayer.mask = maskLayer;
    
}

- (void)layoutSubviews
{
    self.gradientLayer.frame = CGRectMake(-CGRectGetWidth(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds)*3, CGRectGetHeight(self.bounds));
//    self.gradientLayer.frame = self.bounds;
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    [self.layer addSublayer:self.gradientLayer];
    
    CABasicAnimation *aniamtion = [CABasicAnimation animationWithKeyPath:@"locations"];
//    aniamtion.fromValue = @[@0.0,@0.0,@0.25];
//    aniamtion.toValue = @[@0.75,@1.0,@1.0];
    aniamtion.fromValue = @[@0.0, @0.0, @0.0, @0.0, @0.0, @0.25
                            ];
    aniamtion.toValue = @[@0.65, @0.8, @0.85, @0.9, @0.95, @1.0
                          ];
    aniamtion.duration = 3.0f;
    aniamtion.repeatCount = INFINITY;
    
    [self.gradientLayer addAnimation:aniamtion forKey:nil];
}

- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.backgroundColor = [UIColor clearColor].CGColor;
        _gradientLayer.startPoint = CGPointMake(0.0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        
        NSArray *colors =@[
                           (__bridge id _Nullable)[UIColor blackColor].CGColor,
                           (__bridge id _Nullable)[UIColor whiteColor].CGColor,
                           (__bridge id _Nullable)[UIColor blackColor].CGColor,
                           ];

        NSArray *colorss = @[
                             (__bridge id _Nullable)[UIColor yellowColor].CGColor,
                             (__bridge id _Nullable)[UIColor greenColor].CGColor,
                             (__bridge id _Nullable)[UIColor orangeColor].CGColor,
                             (__bridge id _Nullable)[UIColor cyanColor].CGColor,
                             (__bridge id _Nullable)[UIColor redColor].CGColor,
                             (__bridge id _Nullable)[UIColor yellowColor].CGColor,
                             
                             ];
        
        _gradientLayer.colors = colorss;
        
        NSArray *locations = @[
                               @0.25,
                               @0.5,
                               @0.75,
                               ];
        NSArray *locationss = @[
                              @0.0, @0.0, @0.0, @0.0, @0.0, @0.25
                              ];
        _gradientLayer.locations = locationss;
    }
    return _gradientLayer;
}

@end
