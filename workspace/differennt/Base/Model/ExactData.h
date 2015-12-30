//
//  ExactData.h
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Children :NSObject
@property (nonatomic , strong) NSNumber * Id;
@property (nonatomic , copy  ) NSString * Name;

@end

@interface ReturnData :NSObject
@property (nonatomic , strong) NSArray  <Children *> * Children;
@property (nonatomic , strong) NSNumber * Id;
@property (nonatomic , copy  ) NSString * Name;
@property (nonatomic , assign) BOOL isShow;

@end
    
@interface ExactData :NSObject
@property (nonatomic , strong) NSArray  <ReturnData *> * ReturnData;
@property (nonatomic , strong) NSNumber   * ReturnCode;
@property (nonatomic , copy  ) NSString   * ReturnMsg;

@end
