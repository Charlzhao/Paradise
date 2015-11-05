//
//  DetailGameViewController.m
//  Paradise
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "DetailGameViewController.h"
#import "MyNetWorkQuery.h"
#import "GiFHUD.h"
#import "DetailModel.h"
#import "DetailCell.h"
#import "UIScrollView+VORefresh.h"
#import "ExplainViewController.h"
@interface DetailGameViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DetailGameViewController
{
    NSString *_page;
    NSMutableArray *_detailDataArray;
    UITableView *_tableView;
    NSString *_urlString;
    NSMutableDictionary *_parmes;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self firstLoad];
}

//已经显示界面的时候执行
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}


- (void)initData
{
    _page = @"0";
    _detailDataArray = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //添加下拉刷新
    [_tableView addTopRefreshWithTarget:self action:@selector(topRefreshing)];
    
    //实现上拉加载更多
    [_tableView addBottomRefreshWithTarget:self action:@selector(bottomRefreshing)];
    
}

-(void)topRefreshing
{
    [self request];
}
-(void)bottomRefreshing
{
    NSInteger index = [_page integerValue];
    index += 1;
    _page = [NSString stringWithFormat:@"%li",index];
    [_parmes setValue:_page forKey:@"offset"];
    [self request];
}

- (void)firstLoad
{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    //GiFHUD透明层
    [GiFHUD showWithOverlay];
    
    _urlString = @"http://api.dotaly.com/lol/api/v1/shipin/latest";
    _parmes = [[NSMutableDictionary alloc] init];
    [_parmes setValue:_author forKey:@"author"];
    [_parmes setValue:@"0" forKey:@"iap"];
    [_parmes setValue:@"0" forKey:@"ident"];
    [_parmes setValue:@"0" forKey:@"jb"];
    [_parmes setValue:@"20" forKey:@"limit"];
    [_parmes setValue:@"0" forKey:@"nc"];
    [_parmes setValue:@"0" forKey:@"tk"];
    [_parmes setValue:_page forKey:@"offset"];
   
    [self request];
}
- (void)request
{
    [MyNetWorkQuery AFRequestData:_urlString
                       HTTPMethod:@"GET"
                           params:_parmes
                 completionHandle:^(id result) {
                     NSArray *videos = result[@"videos"];
                     for (NSDictionary *dic in videos)
                     {
                         DetailModel *model = [[DetailModel alloc] initWithDataDic:dic];
                         model.detailID = dic[@"id"];
                         [_detailDataArray addObject:model];
                     }
                     [_tableView reloadData];
                     [GiFHUD dismiss];
                     
                     //结束上拉加载更多
                     [_tableView.bottomRefresh endRefreshing];
                     //结束下拉刷新
                     [_tableView.topRefresh endRefreshing];
                     
                 }
                      errorHandle:^(NSError *error) {
                          NSLog(@"%@",error);
                      }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _detailDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:nil] lastObject];
    }
    UIImageView * backImage = [[UIImageView alloc]initWithFrame:cell.bounds];
    backImage.image = [UIImage imageNamed:@"circle_bg.png"];
    [cell.backgroundView addSubview:backImage];
    
    cell.model = _detailDataArray[indexPath.row];
    
    
    return cell;
}
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExplainViewController *explain = [[ExplainViewController alloc] init];
    DetailModel *model = _detailDataArray[indexPath.row];
    explain.model = model;
    [self.navigationController pushViewController:explain animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
