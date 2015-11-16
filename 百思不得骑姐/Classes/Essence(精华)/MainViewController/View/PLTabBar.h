//
//  PLTabBar.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PLTabBar;
@protocol PLTabBarDelegate <NSObject>

- (void)tabBarDidClick:(PLTabBar *)tabBar;

@end


@interface PLTabBar : UITabBar

@property (nonatomic, assign) id<PLTabBarDelegate> tabBarDelegate;

@end
