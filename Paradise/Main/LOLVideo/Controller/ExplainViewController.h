//
//  ExplainViewController.h
//  Paradise
//
//  Created by mac on 15/10/29.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ExplainViewController : UIViewController

@property (nonatomic, copy) DetailModel *model;


@end