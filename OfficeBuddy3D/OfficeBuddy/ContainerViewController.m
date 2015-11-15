//
//  ContainerViewController.m
//  OfficeBuddy
//
//  Created by fangjiayou on 15/11/13.
//  Copyright © 2015年 方. All rights reserved.
//

#import "ContainerViewController.h"
#import "CenterViewController.h"
#import "SideMenuViewController.h"

static CGFloat MenuWidth = 80.0f;
static NSTimeInterval AnimationDuration = 0.5f;

@interface ContainerViewController ()

@property(nonatomic,strong) UIViewController *menuViewController;
@property(nonatomic,strong) UIViewController *centerViewController;

@property(nonatomic,assign) BOOL isOpening;//表示是否在正在做打开的动作还是关闭

@end

@implementation ContainerViewController

- (id)initWithSideMenu:(UIViewController *)sideMenu center:(UIViewController *)center
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.menuViewController = sideMenu;
        self.centerViewController = center;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self addChildViewController:self.centerViewController];
    [self.view addSubview:self.centerViewController.view];
    [self.centerViewController didMoveToParentViewController:self];
    
    [self addChildViewController:self.menuViewController];
    [self.view addSubview:self.menuViewController.view];
    [self.menuViewController didMoveToParentViewController:self];
    
    CGPoint aa = self.menuViewController.view.layer.anchorPoint;
    aa.x = 1.0;
    self.menuViewController.view.layer.anchorPoint = aa;
    self.menuViewController.view.frame = CGRectMake(-MenuWidth, 0, MenuWidth, CGRectGetHeight(self.view.frame));
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    
    _isOpening = NO;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:panGesture.view.superview];
    
    CGFloat progress = translation.x / MenuWidth * (_isOpening ? 1.0:-1.0);
    progress = MIN(MAX(progress,0.0), 1.0);
    UIGestureRecognizerState state = panGesture.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
        {
            CGFloat open = floor(self.centerViewController.view.frame.origin.x/MenuWidth);//向下取整
            _isOpening = (open != 1.0);
            
            //去锯齿
            self.menuViewController.view.layer.shouldRasterize = YES;
            self.menuViewController.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        }
            break;
            case UIGestureRecognizerStateChanged:
        {
            [self setToPercent:(_isOpening ? progress :(1 - progress))];
        }
            break;
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateFailed:
        {
            CGFloat targetProgress;
            if (_isOpening) {
                targetProgress = progress < 0.5 ? 0.0:1.0;
            }
            else{
                targetProgress = progress < 0.5 ? 1.0:0.0;
            }
            
            [UIView animateWithDuration:AnimationDuration animations:^{
                [self setToPercent:targetProgress];
            } completion:^(BOOL finished) {
                
            }];
            
            self.menuViewController.view.layer.shouldRasterize = NO;
            
        }
            break;
            
        default:
            break;
    }
}

- (void)toggleSideMenu
{
    CGFloat isOpen = floor(self.centerViewController.view.frame.origin.x/MenuWidth);
    CGFloat targetProgress = (isOpen == 1.0f ? 0.0:1.0);
     
    [UIView animateWithDuration:AnimationDuration animations:^{
        [self setToPercent:targetProgress];
    } completion:^(BOOL finished) {
        self.menuViewController.view.layer.shouldRasterize = NO;
    }];
}

- (void)setToPercent:(CGFloat)progress
{
    CGRect centerFrame = self.centerViewController.view.frame;
    centerFrame.origin.x = MenuWidth * progress;
    self.centerViewController.view.frame =centerFrame;
    
    self.menuViewController.view.alpha = MAX(0.2, progress);
    
    CGRect menuFrame = self.menuViewController.view.frame;
    menuFrame.origin.x = (progress - 1)*MenuWidth;
//    self.menuViewController.view.frame = menuFrame;
    self.menuViewController.view.layer.transform = [self menuTransformForPercent:progress];
    
}

- (CATransform3D )menuTransformForPercent:(CGFloat)percent
{
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0/1000;
    
    CGFloat remainingPercent = 1.0 - percent;
    CGFloat angle = remainingPercent * (-M_PI_2);
    CATransform3D rotationTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0);
    CATransform3D translationTransform = CATransform3DMakeTranslation(MenuWidth * percent, 0, 0);
    CATransform3D restultTransform = CATransform3DConcat(rotationTransform, translationTransform);
//    return CATransform3DConcat(rotationTransform, translationTransform);
    return restultTransform;
}

@end
