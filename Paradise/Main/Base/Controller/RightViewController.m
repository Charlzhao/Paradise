//
//  RightViewController.m
//  Paradise
//
//  Created by mac on 15/10/29.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "RightViewController.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "MainTabBarController.h"
#import "UIViewController+MMDrawerController.h"

#define w 260
#define h 50
@interface RightViewController ()

@end

@implementation RightViewController
{
    UILabel *_nameLable;
    UIImageView *_headImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createView];
    [self createButton];
}


- (void)_createView
{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH+6, HEIGHT/3)];
    image.image = [UIImage imageNamed:@"UseCenterWeatherBGRain@2x"];
    image.userInteractionEnabled = YES;
    [self.view addSubview:image];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(h/4, h-20, w/4, h/2);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    button.showsTouchWhenHighlighted =YES;
    [button addTarget:self action:@selector(imagebtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:button];
    
    //头像按钮
    UIButton *headbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    headbutton.frame =  CGRectMake(WIDTH/2-h/2, h + 20, h + 10, h + 10);
    headbutton.layer.cornerRadius = 14;
    headbutton.clipsToBounds = YES;
    [headbutton addTarget:self action:@selector(hexdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _headImageView = [[UIImageView alloc]initWithFrame:headbutton.bounds];
    _headImageView.layer.cornerRadius = 14;
    _headImageView.clipsToBounds = YES;
    [headbutton addSubview:_headImageView];
    [image addSubview:headbutton];
    
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-h/2-95, 2*h+5 + 30, 250, 20)];
    _nameLable.textAlignment = NSTextAlignmentCenter;
    _nameLable.font = [UIFont systemFontOfSize:15];
    [image addSubview:_nameLable];
    
    NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *iconURL = [NSUserDefaults standardUserDefaults];
    if (![username objectForKey:@"username"])
    {
        _nameLable.text = @"登录";
        _headImageView.image = [UIImage imageNamed:@"head@2x.png"];
    }
    else
    {
        _nameLable.text = [username objectForKey:@"username"];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[iconURL objectForKey:@"iconURL"]]];
    }
}

-(void)hexdBtnClick:(UIButton *)headbutton
{
    //登陆
    NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
    if (![username objectForKey:@"username"])
        [self createLanded];
    
}



-(void)imagebtnClick:(UIButton *)imagebutton
{
//    返回
    MainTabBarController * tabBar = [[MainTabBarController alloc]init];
    [self.mm_drawerController setCenterViewController:tabBar withCloseAnimation:YES completion:nil];
    
}
-(void)createLanded
{
    //第三方登陆
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
            [username setObject:snsAccount.userName forKey:@"username"];
            
            NSUserDefaults *iconURL = [NSUserDefaults standardUserDefaults];
            [iconURL setObject:snsAccount.iconURL forKey:@"iconURL"];
            
            // _nameLable.text = snsAccount.userName;
            //  NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
            if (![username objectForKey:@"username"]){
                _nameLable.text = @"登录";
                _headImageView.image = [UIImage imageNamed:@"head@2x.png"];
                
            }
            else{
                _nameLable.text = [username objectForKey:@"username"];
                [_headImageView sd_setImageWithURL:[NSURL URLWithString:[iconURL objectForKey:@"iconURL"]]];
                
                
            }
            
        }});
    
}


-(void)createButton
{
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(0,HEIGHT/3, WIDTH+6, HEIGHT*2/3)];
    image2.image = [UIImage imageNamed:@"kpxgbg@2x"];
    NSArray *buttonArr = @[@"收藏",@"地图",@"反馈",@"关于",@"清理内存",@"退出登陆"];
    for (int i =0; i<buttonArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(w/9, 20+h*i, w/2, h/2);
        [button setTitle:buttonArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.showsTouchWhenHighlighted =YES;
        button.tag=100+i;
        [button addTarget:self action:@selector(RbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.view.userInteractionEnabled = YES;
        image2.userInteractionEnabled = YES;
        [image2 addSubview:button];
        [self.view addSubview:image2];
    }
}

-(void)RbtnClick:(UIButton *)button
{
    NSInteger index = button.tag - 100;
    switch (index) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
