//
//  LocalizedTextfield.m
//  differennt
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "LocalizedTextfield.h"

@implementation LocalizedTextfield

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.font = [UIFont fontWithName:FONT_NAME size:self.font.pointSize];
    
    self.placeholder = LocatizedStirngForkey(self.placeholder);
    self.text        = LocatizedStirngForkey(self.text);
}

@end
