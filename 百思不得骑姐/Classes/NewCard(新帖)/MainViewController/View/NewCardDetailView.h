//
//  NewCardDetailView.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCardDetailView : UIView

@property (strong, nonatomic) IBOutlet UILabel *fans_count_label;
@property (strong, nonatomic) IBOutlet UIImageView *bg_imageView;
@property (strong, nonatomic) IBOutlet UIImageView *sex_imageV;
@property (strong, nonatomic) IBOutlet UILabel *username_label;
@property (strong, nonatomic) IBOutlet UIButton *follow_countBtn;
@property (strong, nonatomic) IBOutlet UILabel *level_label;
@property (strong, nonatomic) IBOutlet UILabel *credit_label;
@property (strong, nonatomic) IBOutlet UIImageView *profile_imageLV;
@property (strong, nonatomic) IBOutlet UILabel *relationshipLabel;
@property (strong, nonatomic) IBOutlet UILabel *destribution_label;

@end
