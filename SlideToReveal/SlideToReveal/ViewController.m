//
//  ViewController.m
//  SlideToReveal
//
//  Created by fangjiayou on 15/11/19.
//  Copyright © 2015年 方. All rights reserved.
//

#import "ViewController.h"
#import "GradientAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
    GradientAnimationView *aa = [[GradientAnimationView alloc]init];
    aa.bounds = CGRectMake(0, 0, 230, 44);
    aa.center = self.view.center;
    aa.backgroundColor = [UIColor clearColor];
    aa.text = @"ASDASDASDASDASD";
    [self.view addSubview:aa];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
