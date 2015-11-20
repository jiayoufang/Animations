//
//  ViewController.m
//  EmitterLayer
//
//  Created by fangjiayou on 15/11/20.
//  Copyright © 2015年 方. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"bg-snowy"];
    [self.view addSubview:bgImageView];
    
    //在实际应用中，我们一般会将其放到可视视图之外的地方，以便更好的模拟效果，不过这里为了测试属性，将其放在可视范围内
    CGRect rect = CGRectMake(0, 100, self.view.bounds.size.width, 50);
    //创建发射器
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = rect;
    [self.view.layer addSublayer:emitter];
    
    //设置发射器类型
    emitter.emitterShape = kCAEmitterLayerRectangle;
    
    emitter.emitterPosition = CGPointMake(rect.size.width*0.5, rect.size.height*0.5);
    emitter.emitterSize = rect.size;
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    //设置粒子展现内容
    emitterCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flake"].CGImage);
    
    //设置粒子创建速率，也就是每秒产生的个数
    emitterCell.birthRate = 200;
    //设置粒子的生命周期，也就是在屏幕上存在的时间
    emitterCell.lifetime = 3.5;
    //设置粒子声明周期范围
    emitterCell.lifetimeRange = 1.0;
    //将粒子赋给发射器
    emitter.emitterCells = @[emitterCell];
    //设置y轴上的加速度
    emitterCell.yAcceleration = 70.0f;
    //设置x轴上的加速度
    emitterCell.xAcceleration = 10.0f;
    //设置粒子的初始速度
    emitterCell.velocity = 20;
    //设置粒子的初始角度 如果不设置这个值，我们发现粒子都是水平发射的
    emitterCell.emissionLongitude = -M_PI_2;
    //设置粒子的初始速度范围 在此例子中范围是 -180~220
    emitterCell.velocityRange = 200.0f;
    //设置粒子的初始角度范围 此例子的范围为 M_PI~0
    emitterCell.emissionRange = M_PI_2;
    //设置粒子的颜色
    emitterCell.color = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1.0].CGColor;
    //我们也可以设置随机颜色，并且限定范围。因为RGB的值最大为1.0,那Red来说，范围并不会变为0.6~1.3,而是0.6~1.0。相似的，如果是负值，则最小为0
    emitterCell.redRange = 0.3;
    emitterCell.greenRange = 0.3;
    emitterCell.blueRange = 0.3;
    
    //设置粒子的大小及其大小范围
    emitterCell.scale = 0.8;
    emitterCell.scaleRange = 0.8;
    
    //设置让粒子随着时间推移每秒减小15%,如果设置为正值则每秒增加
    emitterCell.scaleSpeed = -0.15;
    
    //设置粒子透明度的变化范围
    emitterCell.alphaRange = 0.75;
    //设置粒子变化速度
    emitterCell.alphaSpeed = -0.15;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
