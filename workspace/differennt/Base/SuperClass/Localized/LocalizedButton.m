//
//  LocalizedButton.m
//  differennt
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "LocalizedButton.h"

@implementation LocalizedButton

-(void)awakeFromNib{
    [super awakeFromNib];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self status];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self status];
    }
    return self;
}
- (void)status {
    
    UIFont *font = self.titleLabel.font;
    self.titleLabel.font     = [UIFont fontWithName:FONT_NAME size:font.pointSize];
    NSString *string         = [self titleForState:UIControlStateNormal];
    NSString *selectedString = [self titleForState:UIControlStateSelected];
    [self setTitle:LocatizedStirngForkey(string) forState:UIControlStateNormal];
    [self setTitle:LocatizedStirngForkey(selectedString) forState:UIControlStateSelected];
}


@end
