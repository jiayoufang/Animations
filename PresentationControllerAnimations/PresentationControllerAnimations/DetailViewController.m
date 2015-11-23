//
//  DetailViewController.m
//  PresentationControllerAnimations
//
//  Created by fangjiayou on 15/11/23.
//  Copyright © 2015年 方. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc]init];
    bgImageView.frame = self.view.bounds;
    bgImageView.image = [UIImage imageNamed:self.imageName];
    [self.view addSubview:bgImageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
