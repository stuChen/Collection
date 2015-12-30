//
//  IB_DESIGN_Button.m
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "IB_DESIGN_Button.h"
IB_DESIGNABLE
@implementation IB_DESIGN_Button

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius  = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor{
    _bcolor = bcolor;
    self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    self.layer.borderWidth = _bwidth;
}
-(void)awakeFromNib {
    UIFont *font = self.titleLabel.font;
    self.titleLabel.font     = [UIFont fontWithName:FONT_NAME size:font.pointSize];
    NSString *string         = [self titleForState:UIControlStateNormal];
    NSString *selectedString = [self titleForState:UIControlStateSelected];
    [self setTitle:LocatizedStirngForkey(string) forState:UIControlStateNormal];
    [self setTitle:LocatizedStirngForkey(selectedString) forState:UIControlStateSelected];
}
@end
