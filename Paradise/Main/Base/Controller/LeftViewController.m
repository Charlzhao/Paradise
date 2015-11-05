//
//  LeftViewController.m
//  Paradise
//
//  Created by mac on 15/10/29.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "LeftViewController.h"
#import "TextViewController.h"
#import "MainTabBarController.h"
#import "UIViewController+MMDrawerController.h"

#define w (WIDTH-60)
#define h 80

@interface LeftViewController ()
@property (nonatomic,strong)UIImageView *image;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButton];
}

-(void)createButton
{
    _image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _image.image = [UIImage imageNamed:@"kpxgbg@2x"];
    [self.view addSubview:_image];
    
    self.view.userInteractionEnabled = YES;
    _image.userInteractionEnabled = YES;
    NSArray *buttonArr = @[@"返回主界面",@"段子",@"壁纸",@"二维码",@"评分"];
    for (int i =0; i<buttonArr.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5, h-20+h*i, w/2, h/2);
        [button setTitle:buttonArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.showsTouchWhenHighlighted =YES;
        button.tag=100+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_image addSubview:button];
    }
}
-(void)btnClick:(UIButton *)button
{
    
    NSInteger index = button.tag - 100;
    switch (index) {
        case 0:
        {
            MainTabBarController *mainTabVc = [[MainTabBarController alloc] init];
            [self.mm_drawerController setCenterViewController:mainTabVc withCloseAnimation:YES completion:nil];
        }
            
            break;
        case 1:
        {
            TextViewController *text = [[TextViewController alloc] init];
            [self.mm_drawerController setCenterViewController:text withCloseAnimation:YES completion:nil];
        }
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
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
