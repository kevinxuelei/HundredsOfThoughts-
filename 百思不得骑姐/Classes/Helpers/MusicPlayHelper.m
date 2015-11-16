//
//  MusicPlayHelper.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "MusicPlayHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayHelper ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation MusicPlayHelper

+(instancetype)sharedPlayMusic
{
    static dispatch_once_t onceToken;
    static MusicPlayHelper *music = nil;
    dispatch_once(&onceToken, ^{
        if (music == nil) {
            music = [[MusicPlayHelper alloc] init];
        }
    });
    return music;
}


- (void)playMusicByUrl:(NSString *)strUrl
{
    NSURL *url = [[NSURL alloc]initWithString:strUrl];
    NSData * audioData = [NSData dataWithContentsOfURL:url];
    
    //将数据保存到本地指定位置
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"temp"];
    [audioData writeToFile:filePath atomically:YES];
    
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [player prepareToPlay];
    [player play];
    self.player = player;
}

- (void)stop
{
    [self.player stop];
}

@end
