//
//  BeautyViewController.m
//  Paradise
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BeautyViewController.h"
#import "GiFHUD.h"
#import "UIScrollView+VORefresh.h"
#import "MyNetWorkQuery.h"
#import "ConnotationPictureModel.h"
#import "BeautifulCell.h"
#import "UIImageView+WebCache.h"
#import "SJAvatarBrowser.h"
#import "MBProgressHUD.h"
@interface BeautyViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BeautyViewController
{
    UITableView *_tableView;
    NSString *_timeString;
    NSMutableArray *_dataArray;
    NSMutableDictionary *_params;
    NSString *_urlString;
    NSString *_page;
    CGFloat _height;
    UIImage *_image;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"美女图片欣赏";
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [self initData];
}

- (void)initData
{
    _page = @"0";
    _urlString = @"http://223.6.252.214/weibofun/weibo_list.php";
    _params = [[NSMutableDictionary alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    _timeString = [NSString stringWithFormat:@"%f",a];
    
    [self createTableView];
    [self startDownloadData];
    
}


-(void)createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //上滑影藏导航栏下滑出现
    self.navigationController.hidesBarsOnSwipe=YES;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    //添加下拉刷新
    [_tableView addTopRefreshWithTarget:self action:@selector(topRefreshing)];
    
    //实现上拉加载更多
    [_tableView addBottomRefreshWithTarget:self action:@selector(bottomRefreshing)];
    
    
    //隐藏表格之前的线
    //_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    
    //GiFHUD透明层
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD showWithOverlay];
    
    [_params setValue:@"10500" forKey:@"apiver"];
    [_params setValue:@"weibo_girls" forKey:@"category"];
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
                    // NSLog(@"%@",result);
                     NSArray *items = result[@"items"];
                     for (NSDictionary *dic in items)
                     {
                         ConnotationPictureModel *model = [[ConnotationPictureModel alloc] initWithDataDic:dic];
                         [_dataArray addObject:model];
                         //NSLog(@"%@",model.wbody);
                     }
                     
                     [_tableView reloadData];
                     [GiFHUD dismiss];
                     [_tableView.bottomRefresh endRefreshing];
                     [_tableView.topRefresh endRefreshing];
                 }
                      errorHandle:^(NSError *error) {
                          
                      }];
    
    
}

//图片轻击事件处理
-(void)dealTap:(UITapGestureRecognizer *)tap
{
    //放大图片
    [SJAvatarBrowser showImage:(UIImageView*)tap.view];
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeautifulCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeautyCell"];
    if (cell == nil)
    {
        cell = [[BeautifulCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BeautyCell"];
    }
    
    ConnotationPictureModel *model = _dataArray[indexPath.row];
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
    
    [cell.wpic_largeImageView sd_setImageWithURL:[NSURL URLWithString:model.wpic_middle]placeholderImage:[UIImage imageNamed:@"284338.jpg"]];
    
    cell.wpic_largeImageView.frame = CGRectMake(10, imageY, [UIScreen mainScreen].bounds.size.width - 20, model.wpic_m_height.intValue);
    
    //图片轻击事件
    //打开图片交互
    cell.wpic_largeImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
    [cell.wpic_largeImageView addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(dealTap:)];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePhoto:)];
    [cell.wpic_largeImageView addGestureRecognizer:longPress];
    _height = CGRectGetMaxY(cell.wpic_largeImageView.frame) + 10;
    
    _image = cell.wpic_largeImageView.image;
    
    return cell;
}

#pragma mark - 图片保存
- (void)savePhoto:(UILongPressGestureRecognizer *)longPress{
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        
        [alert show];
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        UIImageWriteToSavedPhotosAlbum(_image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
}

//保存完毕以后执行的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"大图保存完毕处理");
    //提示保存成功
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //显示模式改为：自定义视图模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    //延迟隐藏
    [hud hide:YES afterDelay:1.5];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _height + 30;
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
