//
//  ConnptationVideoController.m
//  Paradise
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ConnptationVideoController.h"
#import "UIScrollView+VORefresh.h"
#import "GiFHUD.h"
#import "MyNetWorkQuery.h"
#import "FunnyVideoModel.h"
#import "FunnyVideoCell.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ConnptationVideoController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ConnptationVideoController
{
    UITableView *_tableView;
    NSString *_page;
    NSMutableDictionary *_params;
    NSMutableArray *_dataArray;
    NSString *_timerString;
    NSString *_urlString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内涵视频";
    //改变导航栏文字颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self initData];
}

- (void) initData
{
    _page = @"0";
    
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    _timerString = [NSString stringWithFormat:@"%f",a];
    
    _params = [[NSMutableDictionary alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    _urlString = @"http://223.6.252.214/weibofun/weibo_list.php";
    
    [self _createTableView];
    [self startDownloadData];
    
}
- (void)_createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //    self.navigationController.navigationBarHidden = YES;
    //上滑影藏导航栏下滑出现
//    self.navigationController.hidesBarsOnSwipe=YES;
    [self.view addSubview:_tableView];
    
    //添加下拉刷新
    [_tableView addTopRefreshWithTarget:self action:@selector(topRefreshing)];
    
    //实现上拉加载更多
    [_tableView addBottomRefreshWithTarget:self action:@selector(bottomRefreshing)];
    
}
-(void)topRefreshing
{
    _page = @"0";
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    _timerString = [NSString stringWithFormat:@"%f",a];
    [_params setValue:_page forKey:@"page"];
    [_params setValue:_timerString forKey:@"max_timestamp"];
    [self request];
}
-(void)bottomRefreshing
{
    NSInteger index = _page.integerValue;
    index += 1;
    _page = [NSString stringWithFormat:@"%li",index];
    
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    _timerString=[NSString stringWithFormat:@"%f",a];
    NSInteger timer = _timerString.integerValue - 3600*_page.integerValue*24;
    _timerString = [NSString stringWithFormat:@"%li",timer];
    [_params setValue:_timerString forKey:@"max_timestamp"];
    [_params setValue:_page forKey:@"page"];
    
    [self request];
}

-(void)startDownloadData
{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    //GiFHUD透明层
    [GiFHUD showWithOverlay];
    [_params setValue:@"10500" forKey:@"apiver"];
    [_params setValue:@"weibo_videos" forKey:@"category"];
    [_params setValue:_page forKey:@"page"];
    [_params setValue:@"15" forKey:@"page_size"];
    [_params setValue:_timerString forKey:@"max_timestamp"];
    [_params setValue:@"1" forKey:@"vip"];
    
    [self request];
}

- (void)request
{
    
    [MyNetWorkQuery AFRequestData:_urlString
                       HTTPMethod:@"GET"
                           params:_params
                 completionHandle:^(id result) {
                     //NSLog(@"%@",result);
                     NSArray *items = result[@"items"];
                     for (NSDictionary *dic in items)
                     {
                         FunnyVideoModel *model = [[FunnyVideoModel alloc] initWithDataDic:dic];
                         [_dataArray addObject:model];
                         
                     }
                     
                     [_tableView reloadData];
                     [GiFHUD dismiss];
                     [_tableView.bottomRefresh endRefreshing];
                     [_tableView.topRefresh endRefreshing];
                 }
                      errorHandle:^(NSError *error) {
                          
                      }];
    
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FunnyVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FunnyCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FunnyVideoCell" owner:self options:nil] lastObject];
    }
    cell.model = _dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}

//加入如下代码实现对齐cell分割线
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FunnyVideoModel *model=_dataArray[indexPath.row];
    NSString *string=[NSString stringWithFormat:@"%@",model.vplay_url];
    NSString *urlString=string;
    MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:urlString]];
    [self presentViewController:mpvc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
