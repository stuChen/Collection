//
//  HistroyView.h
//  differennt
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistroyView : UIView<UITableViewDataSource,UITableViewDelegate> {
    NSArray *_dataArray;
    NSString *_currentKey;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
- (void)searchKey:(NSString *)key inKey:(NSString *)inKey;
@end
