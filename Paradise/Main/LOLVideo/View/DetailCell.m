//
//  DetailCell.m
//  Paradise
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "DetailCell.h"
#import "UIImageView+WebCache.h"
@implementation DetailCell

- (void)awakeFromNib{
    
}



- (void)setModel:(DetailModel *)model
{
    if (_model != model)
    {
        _model  = model;
    }
    
    _titleImage.layer.cornerRadius = 4;
    _titleImage.clipsToBounds = YES;
    _titleImage.layer.masksToBounds = YES;
    
    NSURL *url = [NSURL URLWithString:_model.thumb];
    [_titleImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Headbeijing@2x"]];
    
    
    
    
    _timeLabel.text = _model.time;
    _titleLabel.text = _model.title;
    _dateLabel.text = _model.date;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
