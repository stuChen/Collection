//
//  IndexTableViewCell.m
//  differennt
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "IndexTableViewCell.h"

@implementation IndexTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUi:(NSDictionary *)info {
    [self.pic sd_setImageWithActivityAndURLString:[NSString stringWithFormat:@"%@",info[@"Cover"]]];
     //sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",info[@"Cover"]]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",info[@"Name"]];
}
@end
