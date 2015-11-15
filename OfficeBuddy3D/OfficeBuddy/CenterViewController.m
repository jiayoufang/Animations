//
//  CenterViewController.m
//  OfficeBuddy
//
//  Created by fangjiayou on 15/11/13.
//  Copyright © 2015年 方. All rights reserved.
//

#import "CenterViewController.h"
#import "MenuButton.h"
#import "ContainerViewController.h"

@interface CenterViewController ()

@property(nonatomic,strong) MenuButton *menuButton;

@property(nonatomic,strong) UILabel *symbolLabel;

@end

@implementation CenterViewController

@synthesize menuItem = _menuItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    __weak typeof(self) weakSelf = self;
    _menuButton = [[MenuButton alloc]init];
    _menuButton.tapHandler = ^(){
        ContainerViewController *containerVC = (ContainerViewController *)weakSelf.navigationController.parentViewController;
        [containerVC toggleSideMenu];
//        NSLog(@"");
    };
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_menuButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    _symbolLabel = [[UILabel alloc]init];
    _symbolLabel.bounds = CGRectMake(0, 0, 100, 100);
    _symbolLabel.center = self.view.center;
    _symbolLabel.font = [UIFont fontWithName:@"Helvetica" size:66.0f];
    _symbolLabel.textColor = [UIColor whiteColor];
    _symbolLabel.backgroundColor = [UIColor clearColor];
    _symbolLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_symbolLabel];
    
    self.menuItem = [[MenuItem sharedMenuItems]firstObject];
}

- (void)setMenuItem:(MenuItem *)menuItem
{
    _menuItem = menuItem;
    self.navigationItem.title = menuItem.title;
    _symbolLabel.text = menuItem.symbol;
}

- (MenuItem *)menuItem
{
    return _menuItem;
}

@end
