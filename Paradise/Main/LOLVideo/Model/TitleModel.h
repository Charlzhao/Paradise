//
//  TitleModel.h
//  Paradise
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseModel.h"
/*
 authors =     (
 {
 detail = "2015-10-28";
 icon = "http://tp3.sinaimg.cn/2570873434/180/5661996247/1";
 id = all;
 name = "\U6700\U8fd1\U66f4\U65b0";
 pop = "-1";
 url = "http://dotaly.com";
 "youku_id" = none;

 "http://tp4.sinaimg.cn/2481756727/180/40040619223/0"
 },
 */
@interface TitleModel : BaseModel

@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pop;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *youku_id;
@property (nonatomic, copy) NSString *titleId;



@end
