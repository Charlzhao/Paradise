//
//  MainTabBarController.m
//  Paradise
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createTabBarButton];
//    self.tabBarController.tabBar.selectedItem.selectedImage = [UIImage imageNamed:@"shouye_sel.png"];
//    self.tabBarController.tabBar.tintColor = [UIColor redColor];
}

- (void)_createTabBarButton
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    NSArray *titleArray = @[@"LOL视频", @"内涵图片", @"内涵视频", @"美女图片欣赏"];
    NSArray *imageNames = @[@"tabbar_1@2x", @"tabbar_2@2x", @"tabbar_3@2x", @"tabbar_4@2x"];
    NSArray *names = @[@"LOLVideo", @"ConnotationPicture", @"ConnotationVideo", @"BeautyPicture"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    NSMutableArray *navArray = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 0; i < names.count; i++)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:names[i] bundle:nil];
        BaseNavigationController *nav = [storyBoard instantiateInitialViewController];
        [navArray addObject:nav];
        
        nav.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0.6 blue:0.4 alpha:1];
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titleArray[i] image:[UIImage imageNamed:imageNames[i]] selectedImage:nil];
        nav.tabBarItem = item;
    }
    
    self.viewControllers = navArray;
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
