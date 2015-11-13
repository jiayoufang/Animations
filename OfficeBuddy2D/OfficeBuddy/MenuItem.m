//
//  MenuItem.m
//  OfficeBuddy
//
//  Created by fangjiayou on 15/11/13.
//  Copyright © 2015年 方. All rights reserved.
//

#import "MenuItem.h"

@interface MenuItem ()

@end

@implementation MenuItem

- (id)initMenuItemSymbol:(NSString *)symbol color:(UIColor *)color title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.symbol = symbol;
        self.color = color;
        self.title = title;
    }
    return self;
}

+ (NSArray *)sharedMenuItems
{
    NSArray *symbolArray = @[@"☎︎",@"✉︎",@"♻︎",@"♞",@"✾",@"✈︎",@"🃖"];
    NSArray *colorArray = @[
                            [UIColor colorWithRed:249/255.0 green:84/255.0 blue:7/255.0 alpha:1.0],
                            [UIColor colorWithRed:69/255.0 green:59/255.0 blue:55/255.0 alpha:1.0],
                            [UIColor colorWithRed:249/255.0 green:194/255.0 blue:7/255.0 alpha:1.0],
                            [UIColor colorWithRed:32/255.0 green:188/255.0 blue:32/255.0 alpha:1.0],
                            [UIColor colorWithRed:207/255.0 green:34/255.0 blue:156/255.0 alpha:1.0],
                            [UIColor colorWithRed:14/255.0 green:88/255.0 blue:149/255.0 alpha:1.0],
                            [UIColor colorWithRed:15/255.0 green:193/255.0 blue:231/255.0 alpha:1.0],
                            
                            ];
    NSArray *titleArray = @[@"Phone",@"Email",@"Company",@"Games",@"Training",@"Travel",@"Etc."];
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < symbolArray.count; i++) {
        MenuItem *item = [[MenuItem alloc]initMenuItemSymbol:symbolArray[i] color:colorArray[i] title:titleArray[i]];
        [array addObject:item];
    }
    
    return array;
}

@end
