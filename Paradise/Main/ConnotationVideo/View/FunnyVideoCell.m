//
//  FunnyVideoCell.m
//  Paradise
//
//  Created by mac on 15/10/30.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "FunnyVideoCell.h"
#import "UIImageView+WebCache.h"
@implementation FunnyVideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(FunnyVideoModel *)model
{
    if (_model != model)
    {
        _model = model;
    }
    
    NSURL *url = [NSURL URLWithString:_model.vpic_small];
    [_titleImageView sd_setImageWithURL:url];
    
    _titleLabel.text = _model.wbody;
    _likesLabel.text = [NSString stringWithFormat:@"👍%@",_model.likes];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
