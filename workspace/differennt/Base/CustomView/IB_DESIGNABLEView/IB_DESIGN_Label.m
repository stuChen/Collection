//
//  IB_DESIGN_Label.m
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "IB_DESIGN_Label.h"

IB_DESIGNABLE

@implementation IB_DESIGN_Label

-(void)awakeFromNib{
    [super awakeFromNib];
    self.text = LocatizedStirngForkey(self.text);
    self.font = [UIFont fontWithName:FONT_NAME size:self.font.pointSize];
}
- (void)setAttrString:(NSString *)AttrString {
    _AttrString                        = AttrString;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:AttrString];
    NSRange contentRange               = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.attributedText                = content;
}
@end
