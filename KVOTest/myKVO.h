//
//  myKVO.h
//  KVOTest
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol myKVODelegate<NSObject>

- (void)printNum:(int)num;

@end

@interface myKVO : NSObject

//SINGLETON_FOR_HEADER(myKVO);
@property (nonatomic, assign) int num;
@property (nonatomic, weak)id <myKVODelegate>delegate;

@end
