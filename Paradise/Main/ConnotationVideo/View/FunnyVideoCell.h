//
//  FunnyVideoCell.h
//  Paradise
//
//  Created by mac on 15/10/30.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunnyVideoModel.h"
@interface FunnyVideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@property (nonatomic, copy) FunnyVideoModel *model;

@end
