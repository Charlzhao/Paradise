//
//  ConnptationViewController.m
//  Paradise
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ConnptationViewController.h"
#import "UIScrollView+VORefresh.h"
#import "GiFHUD.h"
#import "MyNetWorkQuery.h"
#import "ConnotationPictureModel.h"
#import "ConnptationPictureCell.h"
#import "UIImageView+WebCache.h"

@interface ConnptationViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_timeString;
    UITableView *_tableView;
    NSString *_page;
    NSMutableArray *_pictureArray;
    NSString *_urlString;
    NSMutableDictionary *_params;
    CGFloat _height;
}
@end

@implementation ConnptationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内涵图片";
    //改变导航栏文字颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [self initData];
    
}

- (void) initData
{
    
    //获取系统当前的时间戳
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    _timeString=[NSString stringWithFormat:@"%f",a];
   
    _pictureArray = [[NSMutableArray alloc] init];
    
    [self _createTableView];
    [self startDownloadData];
}

- (void)_createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //    self.navigationController.navigationBarHidden = YES;
    //上滑影藏导航栏下滑出现
    self.navigationController.hidesBarsOnSwipe=YES;
    [self.view addSubview:_tableView];
    
    //添加下拉刷新
    [_tableView addTopRefreshWithTarget:self action:@selector(topRefreshing)];
    
    //实现上拉加载更多
    [_tableView addBottomRefreshWithTarget:self action:@selector(bottomRefreshing)];

}

-(void)topRefreshing
{
    _page = @"1";
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    _timeString=[NSString stringWithFormat:@"%f",a];
    [_params setValue:_timeString forKey:@"max_timestamp"];
    [_params setValue:_page forKey:@"page"];
    [self request];
    //结束下拉刷新
    [_tableView.topRefresh endRefreshing];
    
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
    //结束上拉加载更多
    [_tableView.bottomRefresh endRefreshing];
}

-(void)startDownloadData
{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    //GiFHUD透明层
    [GiFHUD showWithOverlay];
    _page = @"1";
//    "http://223.6.252.214/weibofun/weibo_list.php?apiver=10500&category=weibo_pics&page=%d&page_size=15&max_timestamp=%d&vip=1&platform=0&appver=0&udid=0"
    _urlString = @"http://223.6.252.214/weibofun/weibo_list.php";
    _params = [[NSMutableDictionary alloc] init];
    [_params setValue:@"10500" forKey:@"apiver"];
    [_params setValue:@"weibo_pics" forKey:@"category"];
    [_params setValue:_page forKey:@"page"];
    [_params setValue:@"10" forKey:@"page_size"];
    [_params setValue:_timeString forKey:@"max_timestamp"];
    [_params setValue:@"1" forKey:@"vip"];
    [_params setValue:@"0" forKey:@"platform"];
    [_params setValue:@"0" forKey:@"appver"];
    [_params setValue:@"0" forKey:@"udid"];
    [self request];
}

- (void)request
{
    NSLog(@"%@",_page);
    [MyNetWorkQuery AFRequestData:_urlString
                       HTTPMethod:@"GET"
                           params:_params
                 completionHandle:^(id result) {
                     //NSLog(@"%@",result);
                     NSArray *items = result[@"items"];
                     for (NSDictionary *dic in items)
                     {
                         ConnotationPictureModel *model = [[ConnotationPictureModel alloc] initWithDataDic:dic];
                         [_pictureArray addObject:model];
                        
                     }
                     
                     [_tableView reloadData];
                     [GiFHUD dismiss];
                 } errorHandle:^(NSError *error) {
                     NSLog(@"%@",error);
                     
                     
                 }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pictureArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConnptationPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConnptationCell"];
    if (cell == nil)
    {
        cell = [[ConnptationPictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConnptationCell"];
    }
    
    ConnotationPictureModel *model = _pictureArray[indexPath.row];
    cell.wbodyLabel.text = model.wbody;
    CGSize size = CGSizeMake(365, MAXFLOAT);
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:15.0]
                                 };
    CGRect frame = [model.wbody boundingRectWithSize:size
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
    CGSize contentSize = frame.size;
    CGFloat titleW = contentSize.width;
    CGFloat titleH = contentSize.height;
    cell.wbodyLabel.frame = CGRectMake(10, 10, titleW, titleH);
    
    CGFloat imageY = CGRectGetMaxY(cell.wbodyLabel.frame) + 10;
    cell.wpic_middleImageView.image = nil;
    [cell.wpic_middleImageView sd_setImageWithURL:[NSURL URLWithString:model.wpic_middle]placeholderImage:[UIImage imageNamed:@"284338.jpg"]];
    cell.wpic_middleImageView.frame = CGRectMake(10, imageY, [UIScreen mainScreen].bounds.size.width - 20, model.wpic_m_height.intValue);
    
    _height = CGRectGetMaxY(cell.wpic_middleImageView.frame) + 10;
    return cell;
}

#pragma mark 改表格视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    ConnotationPictureModel *model = _pictureArray[indexPath.row];
    return _height + 30;
    
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
