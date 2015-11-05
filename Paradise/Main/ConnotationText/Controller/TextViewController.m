//
//  TextViewController.m
//  Paradise
//
//  Created by mac on 15/10/31.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "TextViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIScrollView+VORefresh.h"
#import "GiFHUD.h"
#import "MyNetWorkQuery.h"
#import "TextViewCell.h"

@interface TextViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TextViewController
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSString *_page;
    NSString *_timeString;
    NSMutableDictionary *_params;
    NSString *_urlString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

- (void)initData
{
    _dataArray = [[NSMutableArray alloc] init];
    _page = @"0";
    
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    _timeString = [NSString stringWithFormat:@"%f",a];
    
    _params = [[NSMutableDictionary alloc] init];
    _urlString = @"http://223.6.252.214/weibofun/weibo_list.php";
    
    [self createView];
    [self createTableView];
    [self startDownloadData];
    
}
- (void)createView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"12.png"];
    [self.view addSubview:imageView];
    
    UIImageView *myView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.view.userInteractionEnabled = YES;
    myView.userInteractionEnabled = YES;
    myView.image = [UIImage imageNamed:@"changeShowTimeBg.png"];
    [self.view addSubview:myView];
    UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.frame = CGRectMake(20, 20, 40, 40);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:button];
    
}

-(void)createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    _tableView.backgroundColor = [UIColor clearColor];
    //添加下拉刷新
    [_tableView addTopRefreshWithTarget:self action:@selector(topRefreshing)];
    
    //实现上拉加载更多
    [_tableView addBottomRefreshWithTarget:self action:@selector(bottomRefreshing)];
    
}

-(void)btnClick:(UIButton *)button
{
    [self.mm_drawerController openDrawerSide:1 animated:YES completion:nil];
    
}

-(void)topRefreshing
{
    _page = @"0";
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    _timeString = [NSString stringWithFormat:@"%f",a];
    [_params setValue:_page forKey:@"page"];
    [_params setValue:_timeString forKey:@"max_timestamp"];
    [self request];
    
}
-(void)bottomRefreshing
{
    NSInteger index = _page.integerValue;
    index += 1;
    _page = [NSString stringWithFormat:@"%li",index];
    
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    _timeString=[NSString stringWithFormat:@"%f",a];
    NSInteger timer = _timeString.integerValue - 3600*_page.integerValue*24;
    _timeString = [NSString stringWithFormat:@"%li",timer];
    [_params setValue:_timeString forKey:@"max_timestamp"];
    [_params setValue:_page forKey:@"page"];
    
    [self request];
}

-(void)startDownloadData
{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    //GiFHUD透明层
    [GiFHUD showWithOverlay];
    
    [_params setValue:@"10500" forKey:@"apiver"];
    [_params setValue:@"weibo_jokes" forKey:@"category"];
    [_params setValue:_page forKey:@"page"];
    [_params setValue:@"15" forKey:@"page_size"];
    [_params setValue:_timeString forKey:@"max_timestamp"];
    [_params setValue:@"1" forKey:@"vip"];
    [self request];
    
}
- (void)request
{
    [MyNetWorkQuery AFRequestData:_urlString
                       HTTPMethod:@"GET"
                           params:_params
                 completionHandle:^(id result) {
//                     NSLog(@"%@",result);
                     NSArray *items = result[@"items"];
                     for (NSDictionary *dic in items)
                     {
                         TextModel *model = [[TextModel alloc] initWithDataDic:dic];
                         [_dataArray addObject:model];
                        // NSLog(@"%@",model.wbody);
                     }
                     
                     
                     [_tableView reloadData];
                     [GiFHUD dismiss];
                     [_tableView.bottomRefresh endRefreshing];
                     [_tableView.topRefresh endRefreshing];
                     
                 } errorHandle:^(NSError *error) {
                     
                 }];
    
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
    if (cell == nil)
    {
        cell = [[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TextCell"];
    }
    cell.model = _dataArray[indexPath.row];
    [cell layoutFram];
    _height = cell.height;
     //NSLog(@"%f",_height);
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _height;
    
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
