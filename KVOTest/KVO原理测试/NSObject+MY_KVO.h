//
//  NSObject+MY_KVO.h
//  KVOTest
//
//  Created by mac on 2018/3/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MY_KVO)

- (void)My_addObserver:(NSObject *_Nonnull)observer forKeyPath:(NSString *_Nonnull)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end
