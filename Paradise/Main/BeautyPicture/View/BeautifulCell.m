//
//  BeautifulCell.m
//  Paradise
//
//  Created by mac on 15/10/30.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BeautifulCell.h"

@implementation BeautifulCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self _createView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)_createView
{
    _wbodyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 280, 30)];
    _wbodyLabel.font=[UIFont systemFontOfSize:15];
    _wbodyLabel.numberOfLines=0;
    _wbodyLabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:_wbodyLabel];
    
    _wpic_largeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    [self.contentView addSubview:_wpic_largeImageView];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
