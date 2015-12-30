//
//  IndexTableViewCell.h
//  differennt
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet LocalizedLabel *nameLabel;

- (void)configUi:(NSDictionary *)info;
@end
