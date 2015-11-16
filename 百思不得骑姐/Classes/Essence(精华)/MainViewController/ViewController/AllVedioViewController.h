//
//  AllVedioViewController.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASIHTTPRequest;

@interface AllVedioViewController : UIViewController
{
    ASIHTTPRequest *videoRequest;
    unsigned long long Recordull;
    BOOL isPlay;
}

+ (instancetype)sharedViewController;

@property (nonatomic,copy) NSString * nameUrl;

//@property (nonatomic, strong) CellFrame *cellF;

@end
