//
//  BaseViewController.m
//  Paradise
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatguide];
    [self _createTabBarItem];
}

-(void)_createTabBarItem
{
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0 green:0.6 blue:0.4 alpha:1];
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    
    UIButton *liftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [liftbutton setImage:[UIImage imageNamed:@"navigationbar_menu_icon@2x.png"] forState:UIControlStateNormal];
    [liftbutton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    liftbutton.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *liftitem = [[UIBarButtonItem alloc]initWithCustomView:liftbutton];
    self.navigationItem.leftBarButtonItem = liftitem;
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage:[UIImage imageNamed:@"navigationbar_more_normal@2x.png"] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightbutton.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *rightitm = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem =rightitm;
}

-(void)creatguide
{
    //引导图
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFist"])
    {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIWindow *window = app.window;
        
        UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, [UIScreen mainScreen].bounds.size.height);
        
        scrollView.pagingEnabled = YES;
        
        scrollView.showsHorizontalScrollIndicator = NO;
        
        //scrollView.backgroundColor = [UIColor orangeColor];
        
        NSArray *pageImageArr = [[NSArray alloc]initWithObjects:@"1.png",@"2.png",@"3.png", nil];
        
        for (int i = 0; i < 3; i ++) {
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            
            imageView.image = [UIImage imageNamed:[pageImageArr objectAtIndex:i]];
            
            imageView.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            [scrollView addSubview:imageView];
            
            if (i == 2)
            {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
                
                imageView.userInteractionEnabled = YES;
                
                [imageView addGestureRecognizer:tap];
                
            }
        }
        [window addSubview:scrollView];
    }
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"isFist"];
}
- (void)imageTap:(UITapGestureRecognizer *)tap
{
    [tap.view.superview removeFromSuperview];
}


-(void)leftBtnClick:(UIButton *)button
{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightBtnClick:(UIButton *)button
{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
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
