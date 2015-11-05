//
//  ConnotationPictureModel.h
//  Paradise
//
//  Created by mac on 15/10/30.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

/*
 items =     (
 {
 comments = 2;
 "is_gif" = 1;
 likes = "83.20";
 "update_time" = 1446170400;
 wbody = "\U4e0d\U5c0f\U5fc3\U649e\U89c1\U7236\U6bcd\U556a\U556a\U556a\U65f6\U5019\U7684\U6211\U3002\U3002\U3002";
 wid = 77191;
 "wpic_large" = "http://ww1.sinaimg.cn/large/79a00895jw1exhs3g2nvwg204k076tvw.gif";
 "wpic_m_height" = 258;
 "wpic_m_width" = 164;
 "wpic_middle" = "http://ww1.sinaimg.cn/bmiddle/79a00895jw1exhs3g2nvwg204k076tvw.gif";
 "wpic_s_height" = 120;
 "wpic_s_width" = 76;
 "wpic_small" = "http://ww1.sinaimg.cn/thumbnail/79a00895jw1exhs3g2nvwg204k076tvw.gif";
 },
 */


#import "BaseModel.h"

@interface ConnotationPictureModel : BaseModel

@property (copy,nonatomic) NSString *comments;
@property (copy,nonatomic) NSString *is_gif;
@property (copy,nonatomic) NSString *likes;
@property (copy,nonatomic) NSString *update_time;
@property (copy,nonatomic) NSString *wbody;
@property (copy,nonatomic) NSString *wid;
@property (copy,nonatomic) NSString *wpic_large;
@property (copy,nonatomic) NSNumber *wpic_m_height;
@property (copy,nonatomic) NSString *wpic_m_width;
@property (copy,nonatomic) NSString *wpic_middle;
@property (copy,nonatomic) NSNumber *wpic_s_width;
@property (copy,nonatomic) NSNumber *wpic_s_height;
@property (copy,nonatomic) NSNumber *wpic_small;

@end
