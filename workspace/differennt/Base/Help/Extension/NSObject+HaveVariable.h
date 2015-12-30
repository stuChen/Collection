//
//  NSObject+HaveVariable.h
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HaveVariable)
/**
 *  判断是否包含某个属性
 *
 *  @param name 属性名字
 *
 *  @return 是否有
 */
- (BOOL)getVariablevarName:(NSString *)name;
@end
