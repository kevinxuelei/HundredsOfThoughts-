//
//  NewPhotoViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "NewPhotoViewController.h"
#import "NewCardDetaiolController.h"

@interface NewPhotoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableViewAll;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSNumber  *maxTime;
@end

@implementation NewPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor redColor];
    self.tableViewAll = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    self.tableViewAll.delegate = self;
    self.tableViewAll.dataSource  = self;
    [self.view addSubview:self.tableViewAll];
    [self loadData];
    
    // 刷新加载
    [self setUpNewData];
    [self setUpMoreData];
    
}

- (void)setUpNewData
{
    __weak UITableView *tableV = self.tableViewAll;
    self.tableViewAll.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadData];
            [tableV reloadData];
            [tableV.header endRefreshing];
        });
    }];
    tableV.header.automaticallyChangeAlpha = YES;
}

- (void)setUpMoreData
{
    __block int count = 1;
    __weak UITableView *tableV = self.tableViewAll;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            count++;

            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
            NSString *str = @"http://api.budejie.com/api/api_open.php?a=newlist&appname=baisishequ&asid=56280F3D-FFF0-4D6A-ABA9-C52F3D13282B&c=data&client=iphone&device=iPhone%";
            NSString *str1 = [NSString stringWithFormat:@"204S&from=ios&jbk=0&mac=&market=&maxtime=%@&openudid=379ec5e20a2a6ca41a523ed24c985a847b0a580a&page=%d&per=20&sub_flag=1&type=10&udid=&ver=3.6.1",self.maxTime,count];
            NSString *str2 = [str stringByAppendingString:str1];
            [manager GET:str2 parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                NSArray *allDataArray = responseObject[@"list"];
                NSDictionary *infoDict = (NSDictionary *)responseObject[@"info"];
                self.maxTime = (NSNumber *)infoDict[@"maxtime"];
                
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
                
                [tableV reloadData];
                [tableV.footer endRefreshing];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            }];
        });
    }];
    footer.hidden = YES;
    tableV.footer = footer;
}



- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager GET:NEWCardPhoto parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        NSArray *allDataArray = responseObject[@"list"];
        NSDictionary *infoDict = (NSDictionary *)responseObject[@"info"];
        self.maxTime = (NSNumber *)infoDict[@"maxtime"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in allDataArray) {
            UserModel *model = [[UserModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            NSDictionary *dic = [dict valueForKey:@"richtxt"];
            if (dic.count != 0) {
                RichTextModel *richModel = [[RichTextModel alloc] init];
                [richModel setValuesForKeysWithDictionary:dic];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *identifier = [NSString stringWithFormat:@"%ld%ld",indexPath.section,indexPath.row];
    static NSString *identifier = @"newPhoto";
    AllUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        cell = [[AllUserTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }else{
        NSArray *array = [cell.webView1 subviews];
        for (UIButton *button in array) {
            if (button.tag == 1000) {
                [button removeFromSuperview];
            }
            if (button.tag == 10000) {
                [button removeFromSuperview];
            }
        }
    }
    
    cell.cellFrame = self.dataArray[indexPath.section];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  [self.dataArray[indexPath.section] cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    CellFrame *cell = self.dataArray[indexPath.section];
    [def setObject:cell.model.ID forKey:@"id"];
    [def setObject:cell.model.user_id forKey:@"user_id"];
    NewCardDetaiolController *detail = [[NewCardDetaiolController alloc] init];
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:detail];
    detail.cellF = cell;
    [self.view.window.rootViewController presentViewController:NC animated:YES completion:^{
    }];


}

@end
