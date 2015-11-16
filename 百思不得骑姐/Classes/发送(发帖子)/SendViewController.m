//
//  SendViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "SendViewController.h"
#import "SendCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface SendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, self.view.width - 80, 40)];
    imageV.image = [UIImage imageNamed:@"app_slogan"];
    [self.view addSubview:imageV];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.size = CGSizeMake(self.view.width - 40,40);
    button.centerX = self.view.width / 2;
    button.centerY = self.view.height - 40;
    [button setBackgroundImage:[UIImage imageNamed:@"comment-bar-record"] forState:(UIControlStateNormal)];
    [button setTitle:@"取消" forState:(UIControlStateNormal)];
     button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)click:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 1.加载collectionView
    [self loadCollectionView];
    [self loadData];
}

- (void)loadData
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"发视频",@"name",@"publish-video",@"imageName" ,nil];
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"发图片",@"name",@"publish-picture",@"imageName" ,nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"发段子",@"name",@"publish-text",@"imageName" ,nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"发声音",@"name",@"publish-audio",@"imageName" ,nil];
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"审帖",@"name",@"publish-review",@"imageName" ,nil];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"离线下载",@"name",@"publish-offline",@"imageName" ,nil];
    self.dataArray = [NSMutableArray arrayWithObjects:dict,dict1,dict2,dict3,dict4,dict5, nil];
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(90, 120);
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.height/4, self.view.width, self.view.height/2) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"SendViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SendCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.imageCellView.image = [UIImage imageNamed:dict[@"imageName"]];
    cell.imageCellView.layer.cornerRadius = cell.imageCellView.height/2;
    cell.imageCellView.layer.masksToBounds = YES;
    cell.text_Label.text = dict[@"name"];
    return cell;
}

@end
