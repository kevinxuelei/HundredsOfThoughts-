//
//  MusicPlayHelper.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicPlayHelper : NSObject

+ (instancetype)sharedPlayMusic;

// 根据传过来的url缓存播放音乐
- (void)playMusicByUrl:(NSString *)strUrl;

- (void)stop;

@end
