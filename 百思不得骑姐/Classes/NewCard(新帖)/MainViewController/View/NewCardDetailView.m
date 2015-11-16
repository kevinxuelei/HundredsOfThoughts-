//
//  NewCardDetailView.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "NewCardDetailView.h"
#import "NewCardUserModel.h"
#import "UIImageView+WebCache.h"

@implementation NewCardDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    
    
    
}

- (void)awakeFromNib
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    http://api.budejie.com/api/api_open.php?a=profile&appname=baisishequ&asid=56280F3D-FFF0-4D6A-ABA9-C52F3D13282B&c=user&client=iphone&device=iPhone%204S&jbk=0&mac=&market=&openudid=379ec5e20a2a6ca41a523ed24c985a847b0a580a&sex=m&udid=&userid=15148073&ver=3.6.1
    NSString *str = @"http://api.budejie.com/api/api_open.php?a=profile&appname=baisishequ&asid=56280F3D-FFF0-4D6A-ABA9-C52F3D13282B&c=user&client=iphone&device=iPhone%204S&jbk=0&mac=&market=&openudid=379ec5e20a2a6ca41a523ed24c985a847b0a580a&sex=m&udid=";
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *useriD = [def objectForKey:@"user_id"];
    NSString *str2 = [NSString stringWithFormat:@"&userid=%@&ver=3.6.1",useriD];
    NSString *str3 = [str stringByAppendingString:str2];
    [manager GET:str3 parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
//        if (![responseObject[@"data"] isEqualToString:@""]) {
            NSDictionary *dic = responseObject[@"data"];
//            if ([dic isEqual:NULL]) {
                NewCardUserModel *model = [[NewCardUserModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self loadControlData:model];
//            }
//        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
- (void)loadControlData:(NewCardUserModel *)model
{

    self.fans_count_label.text = model.fans_count;
    [self.bg_imageView sd_setImageWithURL:[NSURL URLWithString:model.background_image]];
    self.sex_imageV.image = [UIImage imageNamed:@"iconfont-nan"];
    self.username_label.text = model.username;
    [self.follow_countBtn setTitle:model.follow_count forState:(UIControlStateNormal)];
    self.level_label.text = [NSString stringWithFormat:@"%ld",model.level];
    self.credit_label.text = [NSString stringWithFormat:@"%ld",model.credit];
    [self.profile_imageLV sd_setImageWithURL:[NSURL URLWithString:model.profile_image]];
    _profile_imageLV.layer.cornerRadius = 30;
    _profile_imageLV.layer.masksToBounds = YES;
    self.relationshipLabel.text = model.relationship;
    self.destribution_label.text = model.introduction;
    
}


@end
