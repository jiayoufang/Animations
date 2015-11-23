//
//  ViewController.m
//  UIImageViewAniamtions
//
//  Created by fangjiayou on 15/11/23.
//  Copyright © 2015年 方. All rights reserved.
//

#import "ViewController.h"

static const NSTimeInterval AniamtionDuration = 1.0;

@interface ViewController ()

@property(nonatomic,strong) UIImageView *penguinImageView;
@property(nonatomic,strong) UIButton *leftButton;
@property(nonatomic,strong) UIButton *rightButton;
@property(nonatomic,strong) UIButton *slideButton;

@property(nonatomic,assign) BOOL isLookingRight;
@property(nonatomic,assign) CGSize walkSize;
@property(nonatomic,assign) CGSize slideSize;
@property(nonatomic,assign) CGFloat penguinY;

@property(nonatomic,strong) NSMutableArray *walkFrames;
@property(nonatomic,strong) NSMutableArray *slideFrames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _penguinImageView = [[UIImageView alloc]init];
    _penguinImageView.bounds = CGRectMake(0, 0, 108, 96);
    _penguinImageView.center = CGPointMake(100, 245);
    _penguinImageView.image = [UIImage imageNamed:@"walk01"];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.bounds = CGRectMake(0, 0, 55, 55);
    _leftButton.center = CGPointMake(60, 320);
    [_leftButton setImage:[UIImage imageNamed:@"btn-left"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(actionLeft:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.bounds = CGRectMake(0, 0, 55, 55);
    _rightButton.center = CGPointMake(60+55+40, 320);
    [_rightButton setImage:[UIImage imageNamed:@"btn-right"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(actionRight:) forControlEvents:UIControlEventTouchUpInside];
    
    _slideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _slideButton.bounds = CGRectMake(0, 0, 55, 55);
    _slideButton.center = CGPointMake(CGRectGetWidth(self.view.bounds)-70, 320);
    [_slideButton setImage:[UIImage imageNamed:@"btn-slide"] forState:UIControlStateNormal];
    [_slideButton addTarget:self action:@selector(actionSlide:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _walkFrames = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i< 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"walk0%ld",(long)(i+1)]];
        [_walkFrames addObject:image];
    }
    
    _slideFrames = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"slide0%ld",(long)(i%2+1)]];
        [_slideFrames addObject:image];
    }
    
    UIImage *walkImage = (UIImage *)[_walkFrames firstObject];
    _walkSize = walkImage.size;
    UIImage *slideImage = (UIImage *)[_slideFrames firstObject];
    _slideSize = slideImage.size;
    
    _penguinY = _penguinImageView.frame.origin.y;
    
    self.isLookingRight = YES;
    
    [self loadWalkAnimation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view addSubview:_penguinImageView];
    [self.view addSubview:_leftButton];
    [self.view addSubview:_rightButton];
    [self.view addSubview:_slideButton];
}

- (void)actionLeft:(id)sender
{
    if (self.penguinImageView.isAnimating) {
        NSLog(@"正在点击向左走");
        return;
    }
    self.isLookingRight = NO;
    [_penguinImageView startAnimating];
    
    [UIView animateWithDuration:AniamtionDuration animations:^{
        CGPoint center = self.penguinImageView.center;
        center.x -= self.walkSize.width;
        self.penguinImageView.center = center;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)actionRight:(id)sender
{
    if (self.penguinImageView.isAnimating) {
        NSLog(@"正在点击向右走");
        return;
    }
    self.isLookingRight = YES;
    [_penguinImageView startAnimating];
    
    [UIView animateWithDuration:AniamtionDuration animations:^{
        CGPoint center = self.penguinImageView.center;
        center.x += self.walkSize.width;
        self.penguinImageView.center = center;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)actionSlide:(id)sender
{
    NSLog(@"正在点击滑行");
    if (self.penguinImageView.isAnimating) {
        return;
    }
    [self loadSlideAnimation];
    
    self.penguinImageView.frame = CGRectMake(self.penguinImageView.frame.origin.x, self.penguinY+(self.walkSize.height - self.slideSize.height), self.slideSize.width, self.slideSize.height);
    
    [self.penguinImageView startAnimating];
    
    [UIView animateWithDuration:(AniamtionDuration - 0.02) delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGPoint center = self.penguinImageView.center;
        CGFloat xSpace = self.isLookingRight ? self.slideSize.width : - self.slideSize.width;
        center.x += xSpace;
        self.penguinImageView.center = center;
    } completion:^(BOOL finished) {
        self.penguinImageView.frame = CGRectMake(self.penguinImageView.frame.origin.x, self.penguinY, self.walkSize.width, self.walkSize.height);
        
        [self loadWalkAnimation];
    }];
}

- (void)loadWalkAnimation
{
    _penguinImageView.animationImages = _walkFrames;
    _penguinImageView.animationDuration = AniamtionDuration/3.0;
    _penguinImageView.animationRepeatCount = 3;
    
    [self.penguinImageView stopAnimating];
}

- (void)loadSlideAnimation
{
    _penguinImageView.animationImages = _slideFrames;
    _penguinImageView.animationDuration = AniamtionDuration;
    _penguinImageView.animationRepeatCount = 1;
}

- (void)setIsLookingRight:(BOOL)isLookingRight
{
    if (_isLookingRight == isLookingRight) {
        return;
    }
    
    _isLookingRight = isLookingRight;
    
    CGFloat xScale = isLookingRight ? 1 : -1;
    _penguinImageView.transform = CGAffineTransformMakeScale(xScale, 1);
    _slideButton.transform = _penguinImageView.transform;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
