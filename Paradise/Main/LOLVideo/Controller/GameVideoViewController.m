//
//  GameVideoViewController.m
//  Paradise
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "GameVideoViewController.h"
#import "MyNetWorkQuery.h"
#import "TitleModel.h"
#import "TitleCell.h"
#import "GiFHUD.h"
#import "DetailGameViewController.h"
@interface GameVideoViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_titleDataArray;
    __weak IBOutlet UICollectionView *_collectionView;

}
@end

@implementation GameVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //改变导航栏文字颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _titleDataArray = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kpxgbg"]];
    
    [self request];
     [_collectionView reloadData];
    
}


- (void)request
{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    //GiFHUD透明层
    [GiFHUD showWithOverlay];
    
    NSString *urlString = @"http://api.dotaly.com/lol/api/v1/authors";
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"0" forKey:@"iap"];
    [params setValue:@"0" forKey:@"ident"];
    [params setValue:@"0" forKey:@"jb"];
    [params setValue:@"0" forKey:@"nc"];
    [params setValue:@"0" forKey:@"tk"];
    
    [MyNetWorkQuery AFRequestData:urlString
                       HTTPMethod:@"GET"
                           params:params
                 completionHandle:^(id result) {
                     NSArray *authors = result[@"authors"];
                     
                     for (NSDictionary *dic in authors)
                     {
                         TitleModel *model = [[TitleModel alloc] initWithDataDic:dic];
                         model.name = dic[@"name"];
                         model.icon = dic[@"icon"];
                         model.titleId = dic[@"id"];
                         [_titleDataArray addObject:model];
                        
                     }
                     [_collectionView reloadData];
                     [GiFHUD dismiss];
                 }
                      errorHandle:^(NSError *error) {
                          
                      }];
    
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.7 alpha:1];
    
    cell.model = _titleDataArray[indexPath.item];
    
    return cell;
}

// 通过屏幕宽度 计算单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = ([UIScreen mainScreen].bounds.size.width - 10 * 4) / 3;
    CGFloat cellHeight = cellWidth * 1.3;
    return CGSizeMake(cellWidth, cellHeight);
}
// 单元格的选中事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailGameViewController *gameDetail = [[DetailGameViewController alloc] init];
    TitleModel *model = _titleDataArray[indexPath.item];
    gameDetail.author = model.titleId;
    [self.navigationController pushViewController:gameDetail animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
