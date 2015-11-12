//
//  ViewController.m
//  Plane
//
//  Created by fangjiayou on 15/11/12.
//  Copyright © 2015年 方. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) UIImageView *planeImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *bgImageView = [[UIImageView alloc]init];
    bgImageView.frame = self.view.bounds;
    bgImageView.image = [UIImage imageNamed:@"bg-sunny"];
    [self.view addSubview:bgImageView];
    
    
    _planeImageView = [[UIImageView alloc]init];
    _planeImageView.bounds = CGRectMake(0, 0, 85, 36);
    _planeImageView.center = self.view.center;
    _planeImageView.image = [UIImage imageNamed:@"plane"];
    [self.view addSubview:_planeImageView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self planeDepart];
}

- (void)planeDepart
{
    CGPoint originCenter = _planeImageView.center;
    
    [UIView animateKeyframesWithDuration:1.5 delay:2.0 options:0 animations:^{
        //在这里添加动画
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.25 animations:^{
            CGPoint center = self.planeImageView.center;
            center.x += 80.0f;
            center.y -=10.0f;
            self.planeImageView.center = center;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations:^{
            self.planeImageView.transform = CGAffineTransformMakeRotation(-M_PI_4/2);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            CGPoint center = self.planeImageView.center;
            center.x += 100.0f;
            center.y -= 50.0f;
            self.planeImageView.center = center;
            self.planeImageView.alpha = 0.0;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.51 relativeDuration:0.01 animations:^{
            self.planeImageView.transform = CGAffineTransformIdentity;
            self.planeImageView.center = CGPointMake(0, originCenter.y);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.45 animations:^{
            self.planeImageView.alpha = 1.0;
            self.planeImageView.center = originCenter;
        }];
        
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //两秒之后重复执行动画
            [self planeDepart];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
