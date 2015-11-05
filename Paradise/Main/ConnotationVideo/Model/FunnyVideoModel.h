//
//  FunnyVideoModel.h
//  Paradise
//
//  Created by mac on 15/10/30.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//
/*
 items =     (
 {
 comments = 13;
 likes = "64.14";
 "update_time" = 1446184800;
 "vpic_middle" = "";
 "vpic_small" = "http://wscdn.miaopai.com/stream/GSWHyXBrJu1nrm8ow~xdSA___tmp_12.jpg";
 "vplay_url" = "http://dlqncdn.miaopai.com/stream/GSWHyXBrJu1nrm8ow~xdSA__.mp4";
 "vsource_url" = "http://www.miaopai.com/show/GSWHyXBrJu1nrm8ow~xdSA__.html";
 wbody = "\U6cf0\U56fd\U4eba\U771f\U4f1a\U73a9\U3002\U3002\U3002\U5973\U751f\U53ea\U8981\U7a7f\U4e0a\U8fd9\U6761\U5185\U88e4\Uff0c\U518d\U4e5f\U4e0d\U7528\U62c5\U5fc3\U81ea\U5df1\U7684\U5b89\U5168\U5566\Uff01";
 wid = 24136;
 },
 */



#import "BaseModel.h"

@interface FunnyVideoModel : BaseModel

@property (copy,nonatomic) NSString *wbody;//文本
@property (copy,nonatomic) NSString *vplay_url;//视频链接
@property (copy,nonatomic) NSString *vpic_small;//图片
@property (copy,nonatomic) NSString *likes;//喜欢的人，点赞的

@property (copy,nonatomic) NSString *update_time;
@property (copy,nonatomic) NSString *comments;
@property (copy,nonatomic) NSString *wid;
@property (copy,nonatomic) NSString *vsource_url;
@property (copy,nonatomic) NSString *vpic_middle;

@end
