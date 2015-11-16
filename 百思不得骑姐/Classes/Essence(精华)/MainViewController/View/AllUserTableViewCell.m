//
//  AllUserTableViewCell.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/25.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "AllUserTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicPlayHelper.h"
#import "UIImageView+PlayGIF.h"
#import "AFNRequestManager.h"
#import "AllVedioViewController.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import <UIProgressView+AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <UIImage+GIF.h>
#import <UIImage+MultiFormat.h>
#import "LoginViewController.h"
#import "SaveUserInfoFMDB.h"
#define  KMusciPlayHelper [MusicPlayHelper sharedPlayMusic]

@interface AllUserTableViewCell ()<UIActionSheetDelegate>

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, copy) NSString *voiceUrl;
@property (nonatomic, copy) NSString *vedioUrl;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) UIButton * lastButton;
@property (nonatomic, strong) UIProgressView *progressV;
@property (nonatomic, strong) UIImageView *imageV;
//@property (nonatomic, strong) KrVideoPlayerController *videoController;
@end

@implementation AllUserTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.profile_image = [[UIImageView alloc] init];
        [self.contentView addSubview:_profile_image];
        
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.font = TextFont;
        _nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
        
        self.created_atLabel = [[UILabel alloc] init];
        _created_atLabel.font = TextFont;
        _created_atLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_created_atLabel];
        
        self.text_Label = [[UILabel alloc] init];
        _text_Label.font = [UIFont systemFontOfSize:15];
        self.text_Label.numberOfLines = 0;
        [self.text_Label sizeToFit];
        _text_Label.textColor = [UIColor blackColor];
        [self.contentView addSubview:_text_Label];
        
        self.webView1 = [[UIImageView alloc] init];
        [self.contentView addSubview:_webView1];
        
        self.loveButton = [[UIButton alloc] init];
        [self.loveButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:_loveButton];
        
        self.hateButton = [[UIButton alloc] init];
        [self.hateButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:_hateButton];
        
        self.repostBtn = [[UIButton alloc] init];
        [self.repostBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:_repostBtn];
        
        self.saveButton = [[UIButton alloc] init];
        [self.contentView addSubview:_saveButton];
        
        self.commentBtn = [[UIButton alloc] init];
        [self.commentBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:_commentBtn];
        [_progressV addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld  context:0];
    }
    return self;
}


- (void)setCellFrame:(CellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    [self loadData:cellFrame];
    [self loadFrame:cellFrame];
    
}

- (void)loadData:(CellFrame *)mode
{
    UserModel *model = mode.model;
    self.webView1.image = nil;
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:model.profile_image]];
    self.nameLabel.text = model.name;
    self.created_atLabel.text = model.created_at;
    if (model.richtxt) {
        self.text_Label.text = model.richModel.title;
    }else{
        self.text_Label.text = model.text;
    }
    if (model.image1) {
        if (model.richtxt) {

            [self.webView1 sd_setImageWithURL:[NSURL URLWithString:model.richModel.img_url] placeholderImage:[UIImage imageNamed:@"icon"]];
        }
        if([model.is_gif isEqualToString:@"1"]){
            [self.webView1 sd_setImageWithURL:[NSURL URLWithString:model.image1] placeholderImage:[UIImage imageNamed:@"perm-settings"]];
            
            [self.progressV setProgressWithDownloadProgressOfOperation:self.webView1.af_imageRequestOperation animated:NO];
//            _progressV setProgressWithDownloadProgressOfOperation:self.webView1. animated:
//            [self.progressV setProgressWithDownloadProgressOfOperation: animated:YES];
            
        }
    }
    [self.loveButton setTitle:model.love forState:(UIControlStateNormal)];
    [self.hateButton setTitle:model.hate forState:(UIControlStateNormal)];
    [self.repostBtn setTitle:model.repost forState:(UIControlStateNormal)];
    [self.commentBtn setTitle:model.comment forState:(UIControlStateNormal)];
}


- (void)loadFrame:(CellFrame *)mode
{
    self.profile_image.frame = mode.profile_imageFrame;
    self.profile_image.layer.cornerRadius = 15;
    self.profile_image.layer.masksToBounds = YES;
    self.nameLabel.frame = mode.nameFrame;
    self.created_atLabel.frame = mode.created_atFrame;
    self.text_Label.frame = mode.textFrame;
    self.webView1.userInteractionEnabled = YES;
    if (mode.model.image1) {
        self.webView1.frame = mode.webViewFrame;
        if ([mode.model.is_gif isEqualToString:@"0"] || mode.model.is_gif == nil) {

            [self.webView1 sd_setImageWithURL:[NSURL URLWithString:mode.model.image1]];
            if (![mode.model.videouri isEqualToString:@""]) {
                self.webView1.frame = mode.webViewFrame;
                _imageV.frame = _webView1.bounds;
                self.vedioUrl = mode.model.videouri;
                UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                btn.centerX = self.webView1.width/2 - 40;
                btn.centerY = self.webView1.height/2 - 36;
                btn.size = CGSizeMake(80, 72);
                btn.userInteractionEnabled = YES;
                btn.tag = 1000;
                [btn setImage:[UIImage imageNamed:@"video-play"] forState:(UIControlStateNormal)];
//                [btn addTarget:self action:@selector(clickToPlay:) forControlEvents:(UIControlEventTouchUpInside)];
                [self.webView1 addSubview:btn];
                
            }
            if (![mode.model.voiceuri isEqualToString:@""]) {
                self.voiceUrl = mode.model.voiceuri;
                UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                btn.centerX = self.webView1.width/2 - 40;
                btn.centerY = self.webView1.height - 72;
                btn.size = CGSizeMake(80, 72);
                btn.userInteractionEnabled = YES;
                btn.tag = 10000;
                [btn setImage:[UIImage imageNamed:@"iconfont-erji-3"] forState:(UIControlStateNormal)];
                [btn setBackgroundImage:[UIImage imageNamed:@"playButton"] forState:(UIControlStateNormal)];
                [btn addTarget:self action:@selector(clickPlayMusic:) forControlEvents:(UIControlEventTouchUpInside)];
                [self.webView1 addSubview:btn];
                _lastButton = btn;
            }
            
        }
    }
    if (mode.model.richtxt != nil) {
        self.webView1.frame = mode.webViewFrame;
        UIImage *currentImage = [UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mode.model.richModel.img_url]]];
        UIImage *cutImage = [self getPartOfImage:currentImage rect:CGRectMake(0, 0, self.webView1.width, self.webView1.height)];
        self.webView1.image = cutImage;
    }
    self.loveButton.frame = mode.loveButtonFrame;
    [self.loveButton setImage:[UIImage imageNamed:@"mainCellDingN"] forState:(UIControlStateNormal)];
    [_loveButton addTarget:self action:@selector(clickLove:) forControlEvents:(UIControlEventTouchUpInside)];
    self.hateButton.frame = mode.hateButtonFrame;
    [self.hateButton setImage:[UIImage imageNamed:@"mainCellCaiN"] forState:(UIControlStateNormal)];
    [_hateButton addTarget:self action:@selector(clickHate:) forControlEvents:(UIControlEventTouchUpInside)];
    self.repostBtn.frame = mode.repostBtnFrame;
    [self.repostBtn setImage:[UIImage imageNamed:@"iconfont-zhuanfa-3"] forState:(UIControlStateNormal)];
    self.commentBtn.frame = mode.commentBtnFrame;
    [self.commentBtn setImage:[UIImage imageNamed:@"mainCellCommentN"] forState:(UIControlStateNormal)];
    
    self.saveButton.x = [UIScreen mainScreen].bounds.size.width - 40;
    _saveButton.y = 10;
    _saveButton.width = 40;
    _saveButton.height = 20;
    [_saveButton setImage:[UIImage imageNamed:@"Profile_reportIconN"] forState:(UIControlStateNormal)];
    [_saveButton addTarget:self action:@selector(clickToSave:) forControlEvents:(UIControlEventTouchUpInside)];
    
//    Profile_reportIconN
}
// 收藏按钮方法
- (void)clickToSave:(UIButton *)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"举报",@"收藏", nil];
    action.delegate = self;
    [action showInView:self.contentView];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"收藏");
        NSString *str = [KUSERDefaults objectForKey:@"isLogin"];
        if ([str isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"还未登陆！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }else if ([str isEqualToString:@"1"]){
            UserModel *user = [[UserModel alloc] init];
            user = self.cellFrame.model;
            [KSaveInfoFMDB insertIntoTable:user];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"收藏成功！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    if (buttonIndex == 0) {
        NSLog(@"举报");
    }
    
}



// 求文本高度
- (CGFloat) stringWithByString:(NSString *)str fontSize:(CGFloat)fontSize contentSize:(CGSize)size
{
    CGRect stringH = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return stringH.size.height;
}

// 截取图片
- (UIImage *)getPartOfImage:(UIImage *)img rect:(CGRect)partRect
{
    CGImageRef imageRef = img.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, partRect);
    UIImage *retImg = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return retImg;
}


// button 点击播放音乐
- (void)clickPlayMusic:(UIButton *)sender
{
    if (self.isPlaying == NO) {
        [KMusciPlayHelper playMusicByUrl:self.voiceUrl];
        [_lastButton setImage:[UIImage imageNamed:@"iconfont-zanting"] forState:(UIControlStateNormal)];
        
        _isPlaying = YES;
    }else{
        [KMusciPlayHelper stop];
//        [sender setImage:[UIImage imageNamed:@"iconfont-erji-3"] forState:(UIControlStateNormal)];
        [_lastButton setImage:[UIImage imageNamed:@"iconfont-erji-3"] forState:(UIControlStateNormal)];
        _isPlaying = NO;
    }
    
//    [self.player play];
    
}

// 点击赞
- (void)clickLove:(UIButton *)sender
{
    int num = sender.titleLabel.text.intValue + 1;
    NSString *text = [NSString stringWithFormat:@"%d",num];
    [sender setTitle:text forState:(UIControlStateNormal)];
    sender.enabled = NO;
}
// 点击hate
- (void)clickHate:(UIButton *)sender
{
    int num = sender.titleLabel.text.intValue + 1;
    NSString *text = [NSString stringWithFormat:@"%d",num];
    [sender setTitle:text forState:(UIControlStateNormal)];
    sender.enabled = NO;
}


//KVO监测进度条状态
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    if (self.progressV.progress<1.0) {
        
        self.progressV.hidden = NO;
        
    }else{
        
        self.progressV.hidden = YES;
        
    }
    
}

// 播放视频
- (void)clickToPlay:(UIButton *)sender
{
    
    
    _videoController.view.hidden = NO;
    sender.hidden = YES;
    NSURL *url = [NSURL URLWithString:self.vedioUrl];
    [self addVideoPlayerWithURL:url];
//    CellFrame *cell = self.dataArray[indexPath.section];
//    AllVedioViewController *vedio = [[AllVedioViewController alloc] init];
    //        UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:vedio];
//    vedio.nameUrl = self.vedioUrl;
//    [self presentViewController:vedio animated:YES completion:^{
//    }];
    
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
//        self.imageV = _webView1;
        self.videoController = [[KrVideoPlayerController alloc] init];
        _videoController.view.x = 0;
        _videoController.view.y = 0;
        _videoController.view.size = _webView1.size;
        _videoController.view.tag = 200;
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            [weakSelf toolbarHidden:YES];
        }];
        [self.webView1 addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
    
}

//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool{
//    self.navigationController.navigationBar.hidden = Bool;
//    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}

@end
