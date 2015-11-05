//
//  TitleCell.h
//  Paradise
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleModel.h"
@interface TitleCell : UICollectionViewCell

@property (nonatomic, copy)TitleModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
