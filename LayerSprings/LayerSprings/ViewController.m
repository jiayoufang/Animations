//
//  ViewController.m
//  LayerSprings
//
//  Created by fangjiayou on 15/11/18.
//  Copyright © 2015年 方. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) UIView *springView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.springView = [[UIView alloc]init];
    self.springView.frame = CGRectMake(100, 100, 100, 100);
    self.springView.backgroundColor = [UIColor blueColor];
    self.springView.layer.borderWidth = 15;//搞大一点，方便看
    self.springView.layer.borderColor = [UIColor clearColor].CGColor;
    [self.view addSubview:self.springView];
}

- (void)springAniamtion
{
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    animation.damping = 100.0;
    animation.fromValue = [NSNumber numberWithFloat:1.25];
    animation.toValue = [NSNumber numberWithFloat:1.0];
//    animation.duration = 0.25f;
    animation.initialVelocity = -100;
    animation.mass = 5.0f;
    animation.stiffness = 1500;
    animation.duration = animation.settlingDuration;
    [self.springView.layer addAnimation:animation forKey:@"AnimationKey"];
    
    NSLog(@"time = %f",animation.settlingDuration);
}

- (void)jumpAnimation
{
    CASpringAnimation *jump = [CASpringAnimation animationWithKeyPath:@"position.y"];
    jump.fromValue = [NSNumber numberWithFloat:self.springView.frame.origin.y + 1];
    jump.toValue = [NSNumber numberWithFloat:self.springView.frame.origin.y];
    jump.duration = jump.settlingDuration;
    jump.initialVelocity = 100;
    jump.mass = 1.0f;
    [self.springView.layer addAnimation:jump forKey:@"Jump"];
}

- (void)borderAnimation
{
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"borderColor"];
    animation.damping = 7.0f;
    animation.stiffness = 200.0f;
    animation.mass = 100;
    animation.fromValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
    animation.toValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    animation.duration = animation.settlingDuration;
    [self.springView.layer addAnimation:animation forKey:@"AnimationBorder"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self springAniamtion];
//    [self jumpAnimation];
    [self borderAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
