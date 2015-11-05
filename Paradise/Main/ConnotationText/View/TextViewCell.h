//
//  TextViewCell.h
//  Paradise
//
//  Created by mac on 15/11/1.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"


@interface TextViewCell : UITableViewCell

@property (nonatomic, copy) TextModel *model;

@property (nonatomic,retain) UILabel *wbodyLabel;

@property (nonatomic, assign) CGFloat height;

- (void)layoutFram;

@end
