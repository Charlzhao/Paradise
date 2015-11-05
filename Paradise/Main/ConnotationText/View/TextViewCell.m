//
//  TextViewCell.m
//  Paradise
//
//  Created by mac on 15/11/1.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self _createView];
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setModel:(TextModel *)model
{
    if (_model != model)
    {
        _model = model;
    }
    
    _wbodyLabel.text = _model.wbody;
//    NSLog(@"%@",_model.wbody);
    
}

- (void)_createView
{
    _wbodyLabel = [[UILabel alloc] init];
    _wbodyLabel.frame = CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 40, 0);
    _wbodyLabel.numberOfLines = 0;
    _wbodyLabel.textColor=[UIColor whiteColor];
    _wbodyLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:_wbodyLabel];
  
}

- (void)layoutFram
{
    CGSize size = CGSizeMake(345, MAXFLOAT);
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:15.0]
                                 };
    CGRect frame = [_model.wbody boundingRectWithSize:size
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    CGSize contentSize = frame.size;
    CGFloat titleW = contentSize.width;
    CGFloat titleH = contentSize.height;
    _wbodyLabel.frame = CGRectMake(20, 10, titleW, titleH);
    
    _height = CGRectGetMaxY(_wbodyLabel.frame) + 10;
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
