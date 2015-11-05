//
//  DetailModel.h
//  Paradise
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

/*
 {
 author = chaoshen;
 date = "2015-10-28";
 id = "XMTM3MTI1Njc0NA==";
 thumb = "http://r1.ykimg.com/05410101562FEDB96A0A42471DF4ED9C";
 time = "31:42";
 title = "\U8d85\U795e\U89e3\U8bf4\Uff1a\U6cd5\U5916\U72c2\U5f92\Uff0c\U8d85\U5927\U9006\U98ce\U66b4\U529b20\U6740\Uff0c\U5b9e\U529b\U5e26\U961f\U53cb\U7ffb\U76d8";
 },
 */


#import "BaseModel.h"

@interface DetailModel : BaseModel
@property (copy,nonatomic) NSString *author;
@property (copy,nonatomic) NSString *thumb;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *time;
@property (copy,nonatomic) NSString *date;
@property (copy,nonatomic) NSString *detailID;
@end
