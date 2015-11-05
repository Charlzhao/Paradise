//
//  TitleCell.m
//  Paradise
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "TitleCell.h"
#import "UIImageView+WebCache.h"
@implementation TitleCell

- (void)setModel:(TitleModel *)model
{
    if (_model != model)
    {
        _model = model;
    }
    NSURL *url = [NSURL URLWithString:_model.icon];
//    _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    if (url == nil)
    {
        _titleImageView.image = [UIImage imageNamed:@"Headbeijing"];
    }
    
    
    _titleImageView.layer.cornerRadius = 15;
    _titleImageView.clipsToBounds = YES;
    _titleImageView.layer.masksToBounds = YES;
    
    [_titleImageView sd_setImageWithURL:url];
    _titleLabel.text = _model.name;
}


@end
