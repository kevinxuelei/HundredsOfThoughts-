//
//  TableViewCell.m
//  FDSlideBarDemo
//
//  Created by fergusding on 15/7/14.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "TableViewCell.h"
#import "AFNetworking.h"
#import "CellFrame.h"
#import "UserModel.h"
#import "AllUserTableViewCell.h"
#import "RichTextModel.h"
#import "MJRefresh.h"


@interface TableViewCell ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewAll;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *vedioArray;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, strong) NSMutableArray *segmentArray;
@property (nonatomic, strong) NSMutableArray *rankingArray;
@property (nonatomic, copy) NSString *maxTime;
@end

@implementation TableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tableViewAll = [[UITableView alloc] init];
        self.tableViewAll.delegate = self;
        self.tableViewAll.dataSource  = self;
        [self.contentView addSubview:self.tableViewAll];
    }
    return self;
}


- (void)setText:(NSString *)text
{
    _text = text;
    if ([text isEqualToString:@"全部"]) {
        [self getDataAll];
        [self setUpNewData];
        [self setUpMoreData];
    }
    if ([text isEqualToString:@"图片"]) {
        [self getDataPhoto];
        [self setUpPhotoData];
        [self setUpPhotoMoreData];
    }
    if ([text isEqualToString:@"段子"]) {
        [self getDataSession];
    }
    if ([text isEqualToString:@"排行"]) {
        [self getDataRanking];
    }
    
    
}
// 下拉刷新加载全部
- (void)setUpNewData
{
    __weak UITableView *tableV = self.tableViewAll;
    self.tableViewAll.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getDataAll];
            [tableV reloadData];
            [tableV.header endRefreshing];
        });
    }];
    tableV.header.automaticallyChangeAlpha = YES;
}
// 上拉刷新加载全部
- (void)setUpMoreData
{
    __block int count = 1;
    __weak UITableView *tableV = self.tableViewAll;
//    __weak typeof dataArrray = self.dataArray;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        count++;
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
        NSString *str = @"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=56280F3D-FFF0-4D6A-ABA9-C52F3D13282B&c=data&client=iphone&device=iPhone%";
        NSString *str1 = [NSString stringWithFormat:@"204S&from=ios&jbk=0&mac=&market=&maxtime=%@&openudid=379ec5e20a2a6ca41a523ed24c985a847b0a580a&page=%d&per=20&sub_flag=1&type=1&udid=&ver=3.6.1",self.maxTime,count];
        NSString *str2 = [str stringByAppendingString:str1];
        [manager GET:str2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *allDataArray = responseObject[@"list"];
            NSDictionary *infoDict = (NSDictionary *)responseObject[@"info"];
            self.maxTime = (NSString *)infoDict[@"maxtime"];

//            NSMutableArray *modelArray = [NSMutableArray array];
            for (NSDictionary *dict in allDataArray) {
                UserModel *model = [[UserModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                if (dict[@"richtxt"] != nil) {
                    RichTextModel *richModel = [[RichTextModel alloc] init];
                    [richModel setValuesForKeysWithDictionary:dict[@"richtxt"]];
                    model.richModel = richModel;
                }
                CellFrame *cellFrame = [[CellFrame alloc] init];
                cellFrame.model = model;
                [self.dataArray addObject:cellFrame];
            }
//            [self.dataArray insertObject:modelArray atIndex:self.dataArray.count];
            [tableV reloadData];
            [tableV.footer endRefreshing];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            
        }];
    }];
    footer.hidden = YES;
    tableV.footer = footer;
}

// 下拉刷新加载图片
- (void)setUpPhotoData
{
    __weak UITableView *tableV = self.tableViewAll;
    self.tableViewAll.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getDataPhoto];
            [tableV reloadData];
            [tableV.header endRefreshing];
        });
    }];
    tableV.header.automaticallyChangeAlpha = YES;
}
// 上拉刷新加载图片
- (void)setUpPhotoMoreData
{
    __block int count = 1;
    __weak UITableView *tableV = self.tableViewAll;
    //    __weak typeof dataArrray = self.dataArray;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        count++;
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
        NSString *str = @"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=56280F3D-FFF0-4D6A-ABA9-C52F3D13282B&c=data&client=iphone&device=iPhone%";
        NSString *str1 = [NSString stringWithFormat:@"204S&from=ios&jbk=0&mac=&market=&maxtime=%@&openudid=379ec5e20a2a6ca41a523ed24c985a847b0a580a&page=%d&per=20&sub_flag=1&type=10&udid=&ver=3.6.1",self.maxTime,count];
        NSString *str2 = [str stringByAppendingString:str1];
        [manager GET:str2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *allDataArray = responseObject[@"list"];
            NSDictionary *infoDict = (NSDictionary *)responseObject[@"info"];
            self.maxTime = (NSString *)infoDict[@"maxtime"];
            
            for (NSDictionary *dict in allDataArray) {
                UserModel *model = [[UserModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                if (dict[@"richtxt"] != nil) {
                    RichTextModel *richModel = [[RichTextModel alloc] init];
                    [richModel setValuesForKeysWithDictionary:dict[@"richtxt"]];
                    model.richModel = richModel;
                }
                CellFrame *cellFrame = [[CellFrame alloc] init];
                cellFrame.model = model;
                [self.photoArray addObject:cellFrame];
            }
            [tableV reloadData];
            [tableV.footer endRefreshing];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            
        }];
    }];
    footer.hidden = YES;
    tableV.footer = footer;
}



// 获取全部数据
- (void)getDataAll
{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager GET:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=56280F3D-FFF0-4D6A-ABA9-C52F3D13282B&c=data&client=iphone&device=iPhone%204S&from=ios&jbk=0&mac=&market=&openudid=379ec5e20a2a6ca41a523ed24c985a847b0a580a&page=1&per=20&sub_flag=1&type=1&udid=&ver=3.6.1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *allDataArray = responseObject[@"list"];
        NSDictionary *infoDict = (NSDictionary *)responseObject[@"info"];
        self.maxTime = (NSString *)infoDict[@"maxtime"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in allDataArray) {
            UserModel *model = [[UserModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if (dict[@"richtxt"] != nil) {
                RichTextModel *richModel = [[RichTextModel alloc] init];
                [richModel setValuesForKeysWithDictionary:dict[@"richtxt"]];
                model.richModel = richModel;
            }
            CellFrame *cellFrame = [[CellFrame alloc] init];
            cellFrame.model = model;
            [modelArray addObject:cellFrame];
        }
        self.dataArray = [NSMutableArray arrayWithArray:modelArray];
        [self.tableViewAll reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
}


// 获取图片数据
- (void)getDataPhoto
{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager GET:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=56280F3D-FFF0-4D6A-ABA9-C52F3D13282B&c=data&client=iphone&device=iPhone%204S&from=ios&jbk=0&mac=&market=&openudid=379ec5e20a2a6ca41a523ed24c985a847b0a580a&page=0&per=20&sub_flag=1&type=10&udid=&ver=3.6.1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *allDataArray = responseObject[@"list"];
        NSDictionary *infoDict = (NSDictionary *)responseObject[@"info"];
        self.maxTime = (NSString *)infoDict[@"maxtime"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in allDataArray) {
            UserModel *model = [[UserModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if (dict[@"richtxt"] != nil) {
                RichTextModel *richModel = [[RichTextModel alloc] init];
                [richModel setValuesForKeysWithDictionary:dict[@"richtxt"]];
                model.richModel = richModel;
            }
            CellFrame *cellFrame = [[CellFrame alloc] init];
            cellFrame.model = model;
            [modelArray addObject:cellFrame];
        }
        self.photoArray = [NSMutableArray arrayWithArray:modelArray];
        [self.tableViewAll reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

// 获取段子数据
- (void)getDataSession
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager GET:@"http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=56280F3D-FFF0-4D6A-ABA9-C52F3D13282B&c=data&client=iphone&device=iPhone%204S&from=ios&jbk=0&mac=&market=&openudid=379ec5e20a2a6ca41a523ed24c985a847b0a580a&page=0&per=20&sub_flag=1&type=29&udid=&ver=3.6.1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *allDataArray = responseObject[@"list"];
        self.dataArray = [NSMutableArray arrayWithArray:allDataArray];
        [self.tableViewAll reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

// 获取排行数据
- (void)getDataRanking
{
    
}


#pragma mark - Custom Accessors
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.text isEqualToString:@"全部"]) {
        return self.dataArray.count;
        
    }else if([self.text isEqualToString:@"图片"]){
        return self.photoArray.count;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *identifier = @"all";
//    static NSString *identifier1 = @"photo";
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)indexPath.row];
    AllUserTableViewCell *cell = (AllUserTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if ([self.text isEqualToString:@"全部"]) {
        if (cell == nil) {
            cell = [[AllUserTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
        }
        
        cell.cellFrame = self.dataArray[indexPath.section];
        return cell;
    }else if([self.text isEqualToString:@"图片"]){
        AllUserTableViewCell *cell = (AllUserTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[AllUserTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
        }
        
        cell.cellFrame = self.photoArray[indexPath.section];
        return cell;
    }else{
        cell.textLabel.text = @"123";
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.text isEqualToString:@"全部"]) {
        CellFrame *cellF = self.dataArray[indexPath.section];
        return cellF.cellHeight;
    }else if([self.text isEqualToString:@"图片"]){
        CellFrame *cellF = self.photoArray[indexPath.section];
        return cellF.cellHeight;
    }else{
        return 44;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height- 66;
    self.tableViewAll.frame = CGRectMake(0, 0, width, height);
}



@end
