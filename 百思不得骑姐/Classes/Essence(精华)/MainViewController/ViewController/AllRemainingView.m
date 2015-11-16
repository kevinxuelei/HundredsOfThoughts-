//
//  AllRemainingView.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "AllRemainingView.h"
#import "AFHTTPRequestOperationManager.h"
#import "UserDetailModel.h"
#import "LittleUser.h"
#import "UIImageView+WebCache.h"
#import "AllDetailViewController.h"
#import "AllRemainingCell.h"

@interface AllRemainingView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AllRemainingView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myTableView = [[UITableView alloc] init];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        [self addSubview:_myTableView];
        [self loadData];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.myTableView.frame = self.bounds;
    _myTableView.separatorStyle = UITableViewScrollPositionNone;
}


- (void)loadData
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *str111 = [def objectForKey:@"data_id"];
    self.strID = str111;
    self.dataArray = [NSMutableArray array];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    NSString *str = [NSString stringWithFormat:@"http://api.budejie.com/api/api_open.php?a=dataList&appname=baisishequ&asid=56280F3D-FFF0-4D6A-ABA9-C52F3D13282B&c=comment&client=iphone&data_id=%@&device=iPhone",self.strID];
    NSString *str1 = @"%204S&hot=1&jbk=0&mac=&market=&openudid=379ec5e20a2a6ca41a523ed24c985a847b0a580a&page=1&per=50&udid=&ver=3.6.1";
    NSString *urlStr = [str stringByAppendingString:str1];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        NSArray *dataA = responseObject[@"data"];
        for (NSDictionary *dict in dataA) {
            UserDetailModel *userDetail = [[UserDetailModel alloc] init];
            [userDetail setValuesForKeysWithDictionary:dict];
            LittleUser *littleU = [[LittleUser alloc] init];
            [littleU setValuesForKeysWithDictionary:dict[@"user"]];
            userDetail.littleUser = littleU;
            [_dataArray addObject:userDetail];
        }
        [self.myTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"解析失败");
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    AllRemainingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AllRemaining" owner:nil options:nil] lastObject];
    }
    cell.userDetail = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    61
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UserDetailModel *model = self.dataArray[indexPath.row];
    CGFloat height = [self stringWithByString:model.content fontSize:12 contentSize:CGSizeMake(width - 78, MAXFLOAT)];
    return 30 + height;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"最新评论";
}

- (CGFloat) stringWithByString:(NSString *)str fontSize:(CGFloat)fontSize contentSize:(CGSize)size
{
    CGRect stringH = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return stringH.size.height;
}


@end
