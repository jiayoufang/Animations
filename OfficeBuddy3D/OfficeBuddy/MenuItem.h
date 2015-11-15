//
//  MenuItem.h
//  OfficeBuddy
//
//  Created by fangjiayou on 15/11/13.
//  Copyright © 2015年 方. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuItem : NSObject

@property(nonatomic,copy) NSString *symbol;
@property(nonatomic,strong) UIColor *color;
@property(nonatomic,copy) NSString *title;

- (id)initMenuItemSymbol:(NSString *)symbol color:(UIColor *)color title:(NSString *)title;

+ (NSArray *)sharedMenuItems;

@end
