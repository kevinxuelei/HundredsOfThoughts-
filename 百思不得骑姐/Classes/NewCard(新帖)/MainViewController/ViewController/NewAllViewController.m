//
//  NewAllViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "NewAllViewController.h"
#import "NewCardDetaiolController.h"

@interface NewAllViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableViewAll;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSNumber  *maxTime;
@end

@implementation NewAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableViewAll = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    self.tableViewAll.delegate = self;
    self.tableViewAll.dataSource  = self;
    [self.view addSubview:self.tableViewAll];
    //    [self.tableViewAll registerClass:[AllUserTableViewCell class] forCellReuseIdentifier:@"cell"];
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


- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager GET:NEWCardAll parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        NSArray *allDataArray = responseObject[@"list"];
        NSDictionary *infoDict = (NSDictionary *)responseObject[@"info"];
        self.maxTime = infoDict[@"maxtime"];
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
        //        NSArray *modelArray = [UserModel objectArrayWithKeyValuesArray:allDataArray];
        self.dataArray = [NSMutableArray arrayWithArray:modelArray];
        [self.tableViewAll reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
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
            NSString *str1 = [NSString stringWithFormat:@"04S&from=ios&jbk=0&mac=&market=&maxtime=%@&openudid=379ec5e20a2a6ca41a523ed24c985a847b0a580a&page=%d&per=20&sub_flag=1&type=1&udid=&ver=3.6.1",self.maxTime,count];
            NSString *str2 = [str stringByAppendingString:str1];
            [manager GET:str2 parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                NSArray *allDataArray = responseObject[@"list"];
                NSDictionary *infoDict = (NSDictionary *)responseObject[@"info"];
                self.maxTime = infoDict[@"maxtime"];
                
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"allNew";
    AllUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if ([cell.webView1 isGIFPlaying]) {
//        [cell.webView1 stopGIF];
//    }
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
        [cell.videoController stop];
        cell.videoController.view.hidden = YES;
    }
    cell.cellFrame = self.dataArray[indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //     [self.tableViewAll reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    return  [self.dataArray[indexPath.section] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    CellFrame *cell = self.dataArray[indexPath.section];
    [def setObject:cell.model.ID forKey:@"id"];
    [def setObject:cell.model.user_id forKey:@"user_id"];
    [def synchronize];
    if ([cell.model.videouri isEqualToString:@""]) {
        NewCardDetaiolController *detail = [[NewCardDetaiolController alloc] init];
        UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:detail];
        detail.cellF = cell;
        [self.view.window.rootViewController presentViewController:NC animated:YES completion:^{
        }];
    }else{
        AllVedioViewController *vedio = [[AllVedioViewController alloc] init];
        //        UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:vedio];
        vedio.nameUrl = cell.model.videouri;
        [self.view.window.rootViewController presentViewController:vedio animated:YES completion:^{
        }];
    }

}
	




@end
