//
//  TextModel.h
//  Paradise
//
//  Created by mac on 15/11/1.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

/*
 items =     (
 {
 comments = 0;
 likes = "85.52";
 "update_time" = 1446365340;
 wbody = "\U4f5c\U4e3a\U7537\U4eba\Uff0c\U6700\U597d\U4e0d\U8981\U59d0\U5f1f\U604b\U3002 \U6210\U4e86\U8fd8\U597d\Uff0c\U8981\U662f\U6ca1\U6210\U7684\U8bdd\Uff0c\U4eba\U5bb6\U95ee\U4f60\U4ec0\U4e48\U539f\U56e0\Uff0c\U4f60\U600e\U4e48\U56de\U7b54\Uff1f \U201c\U5bf9\U65b9\U5acc\U6211\U592a\U5c0f\U2026\U2026\U201d";
 wid = 55940;
 },
 */

#import "BaseModel.h"

@interface TextModel : BaseModel

@property (nonatomic, strong) NSString *likes;
@property (nonatomic, strong) NSString *wbody;
@property (nonatomic, strong) NSNumber *wid;


@end
