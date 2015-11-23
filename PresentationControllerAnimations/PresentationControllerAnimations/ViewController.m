//
//  ViewController.m
//  PresentationControllerAnimations
//
//  Created by fangjiayou on 15/11/23.
//  Copyright © 2015年 方. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "PresentationAnimation.h"

static const CGFloat ScrollViewHeight = 200;

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) UIImageView *bgImageView;
@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) NSArray *images;

@property(nonatomic,strong) UIImageView *selectedImageView;

@property(nonatomic,strong) PresentationAnimation *presentAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _images = @[@"basil",@"marjorana",@"rosemary",@"saffron",@"anise"];
    
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.scrollView];
    
//    [self setupScrollView];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presasdented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.presentAnimation.originFrame = _selectedImageView.frame;
    self.presentAnimation.presenting = YES;
    return self.presentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.presentAnimation.presenting = NO;
    return self.presentAnimation;
}

- (PresentationAnimation *)presentAnimation
{
    if (!_presentAnimation) {
        _presentAnimation = [[PresentationAnimation alloc]init];
    }
    return _presentAnimation;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.scrollView.subviews.count < _images.count) {
        [self.scrollView viewWithTag:0].tag = 1000;
        [self setupScrollView];
    }
}

- (void)setupScrollView
{
    for (NSInteger i = 0; i<_images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_images[i]]];
        imageView.tag = i;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        imageView.layer.cornerRadius = 20.0f;
        imageView.layer.masksToBounds = YES;
        [self.scrollView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapImageView:)];
        [imageView addGestureRecognizer:tap];
    }
    
    [self positionListItems];
}

- (void)positionListItems
{
    CGFloat itemHeight = self.scrollView.bounds.size.height * 1.33;
    CGFloat aspectRatio = [UIScreen mainScreen].bounds.size.height/[UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = itemHeight/aspectRatio;
    
    CGFloat horizontalPadding = 10.0f;
    
    for (NSInteger i = 0; i< _images.count; i++) {
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:i];
        imageView.frame = CGRectMake(horizontalPadding + (horizontalPadding+itemWidth)*i, 0, itemWidth, itemHeight);
    }
    
    self.scrollView.contentSize = CGSizeMake(horizontalPadding + (horizontalPadding + itemWidth)*_images.count, 0);
}

- (void)didTapImageView:(UITapGestureRecognizer*)tapGesture
{
    _selectedImageView = (UIImageView *)tapGesture.view;
    
    NSInteger index = _selectedImageView.tag;
    
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.imageName = _images[index];
    detail.transitioningDelegate = self;
    [self presentViewController:detail animated:YES completion:^{
        
    }];
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.frame = self.view.bounds;
        _bgImageView.image = [UIImage imageNamed:@"bg"];
    }
    return _bgImageView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - ScrollViewHeight, CGRectGetWidth(self.view.bounds), ScrollViewHeight)];
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
