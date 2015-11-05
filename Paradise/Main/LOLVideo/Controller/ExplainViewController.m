//
//  ExplainViewController.m
//  Paradise
//
//  Created by mac on 15/10/29.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ExplainViewController.h"
#import "MyNetWorkQuery.h"
#import "GiFHUD.h"
#import "UMSocial.h"
//#import "DatabaseCenter.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ExplainViewController ()<UMSocialUIDelegate>

@end

@implementation ExplainViewController
{
    NSDictionary *_resultData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatButton];
}

- (void)setModel:(DetailModel *)model
{
    if (_model != model)
    {
        _model = model;
        [self startDownLoad];
    }
}

-(void)creatButton
{
    UIButton *liftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [liftbutton setTitle:@"返回" forState:UIControlStateNormal];
    [liftbutton addTarget:self action:@selector(lBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    liftbutton.frame = CGRectMake(0, 0, 40, 30);
    UIBarButtonItem *liftitem = [[UIBarButtonItem alloc]initWithCustomView:liftbutton];
    self.navigationItem.leftBarButtonItem = liftitem;
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setTitle:@"分享"forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(rBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightbutton.frame = CGRectMake(0, 0, 40, 30);
    UIBarButtonItem *rightitm = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem =rightitm;
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 74, WIDTH-40, (HEIGHT-64)/2 - 40)];
    [image sd_setImageWithURL:[NSURL URLWithString:self.model.thumb]];
    UIImageView *btnImage = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-20)/2-50, (HEIGHT-64)/4 - 60, 80, 80)];
    [btnImage setImage:[UIImage imageNamed:@"PlayMovie@2x.png"]];
    [image addSubview:btnImage];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 74+(HEIGHT-64)/2, WIDTH-20, 40)];
    label.text = self.title;
    label.numberOfLines = 0;
    label.font =[UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    //轻击事件   先打开交互
    self.view.userInteractionEnabled = YES;
    image.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
    [image addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(dealTap:)];
    [self.view addSubview:image];
    
    UIButton *CollectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CollectButton.frame = CGRectMake(WIDTH/2-180, (HEIGHT-64)/2+40, 80, 40);
    [CollectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [CollectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [CollectButton addTarget:self action:@selector(CollectBtnCilck:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([[DatabaseCenter sharedInstance] isExistRecordWithVideoModel:self.model] ) {
//        [CollectButton setTitle:@"取消收藏" forState:UIControlStateNormal];
//    }
    
    [self.view addSubview:CollectButton];
}

-(void)CollectBtnCilck:(UIButton *)button
{
//    //当前model信息保存在收藏中(保存到数据库中)
//    DatabaseCenter *dc = [DatabaseCenter sharedInstance];
//    //[dc addRecordWithAppModel:self.model recordType:RecordTypeFavirote];
//    
//    if (![dc isExistRecordWithVideoModel:self.model ]) {
//        [dc addRecordWithVideoModel:self.model];
//        NSLog(@"收藏");
//        [button setTitle:@"取消收藏" forState:UIControlStateNormal];
//    }
//    else{
//        [dc removeRecordWithVideoModel:self.model];
//        [button setTitle:@"收藏" forState:UIControlStateNormal];
//    }
    
}
-(void)dealTap:(UITapGestureRecognizer *)tap
{
    MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:_resultData[@"url"]]];
    
    
    [self presentViewController:mpvc animated:YES completion:nil];
}
//返回
-(void)lBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//分享
-(void)rBtnClick:(UIButton *)button
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"551a5860fd98c513b60002f7"  shareText:self.title shareImage:[UIImage imageNamed:self.model.thumb] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,UMShareToEmail,nil] delegate:self];
    
    
    
}

- (void)startDownLoad
{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD showWithOverlay];
    NSString *urlString = @"http://api.dotaly.com/lol/api/v1/getvideourl";
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setValue:@"0" forKey:@"iap"];
    [parames setValue:@"1EFB14A9-BC26-497D-A761-D2DE836C3933" forKey:@"ident"];
    [parames setValue:@"0" forKey:@"jb"];
    [parames setValue:@"3435719118" forKey:@"nc"];
    [parames setValue:@"55b9a53452e4994c8e2d83a9207c671d" forKey:@"tk"];
    [parames setValue:@"flv" forKey:@"type"];
    [parames setValue:_model.detailID forKey:@"vid"];
    [MyNetWorkQuery AFRequestData:urlString
                       HTTPMethod:@"GET"
                           params:parames
                 completionHandle:^(id result) {
                     NSLog(@"%@",result);
                     
                     _resultData = result;
                     
//                     code = 1;
//                     message = "\U7cfb\U7edf\U7ef4\U62a4\U4e2d, \U8bf7\U7a0d\U540e\U518d\U8bd5";
//                     url = "http://pl.youku.com/playlist/m3u8?vid=343035533&ts=1446085732&ctype=12&token=1835&keyframe=1&sid=744608573191912842330&ev=1&type=flv&ep=dSaQHEmFU8kD5CregT8bbyjgd3QPXP0O9R%2BGhNdhA9QlQOu6&oip=2043217862";
//                     
                     [GiFHUD dismiss];
                     
                 } errorHandle:^(NSError *error) {
                     NSLog(@"%@",error);
                 }];
}



//已经显示界面的时候执行
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
