//
//  ViewController.m
//  KeyframeLayer
//
//  Created by fangjiayou on 15/11/19.
//  Copyright © 2015年 方. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) UILabel *headingLabel;

@property(nonatomic,strong) CALayer *ballon;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *bgImageView = [[UIImageView alloc]init];
    bgImageView.frame = self.view.bounds;
    bgImageView.image = [UIImage imageNamed:@"bg-sunny"];
    [self.view addSubview:bgImageView];
    
    _headingLabel = [[UILabel alloc]init];
    _headingLabel.bounds = CGRectMake(0, 0, 300, 30);
    _headingLabel.center = CGPointMake(CGRectGetMidX(self.view.frame), 100);
    _headingLabel.font = [UIFont systemFontOfSize:30];
    _headingLabel.text = @"摇晃摇晃";
    _headingLabel.textColor = [UIColor whiteColor];
    _headingLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_headingLabel];
    
    _ballon = [CALayer layer];
    _ballon.contents = (__bridge id _Nullable)([UIImage imageNamed:@"balloon"].CGImage);
    _ballon.frame = CGRectMake(-50, 0, 50, 65);
    [self.view.layer insertSublayer:_ballon below:_headingLabel.layer];
}

- (void)ballonAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 12.0f;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(-50, 0)],
                         [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width+50, 160)],
                         [NSValue valueWithCGPoint:CGPointMake(-50, 300)],
                         ];
    animation.keyTimes = @[@0.0,@0.5,@1.0];
    [_ballon addAnimation:animation forKey:@"AnimationPositionKey"];
}

- (void)keyframeAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 0.25;
    animation.repeatCount = 4;
    animation.values = @[@0.0,@(-M_PI_4/4),@0.0,@(M_PI_4/4),@0.0];
    animation.keyTimes = @[@0.0,@0.25,@0.5,@0.75,@1.0];
    [_headingLabel.layer addAnimation:animation forKey:@"AnimationKey"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self keyframeAnimation];
    [self ballonAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
