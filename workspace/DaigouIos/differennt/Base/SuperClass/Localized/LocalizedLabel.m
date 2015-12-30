//
//  LocalizedLabel.m
//  differennt
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "LocalizedLabel.h"

@implementation LocalizedLabel

-(void)awakeFromNib{
    [super awakeFromNib];
    self.text = LocatizedStirngForkey(self.text);
    self.font = [UIFont fontWithName:FONT_NAME size:self.font.pointSize];
}
    
//    [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"Language" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
//}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    self.text = LocatizedStirngForkey(self.text);
//}
//- (void)dealloc
//{
//    [[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:@"Language"];
//}
@end
