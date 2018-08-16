//
//  MY_KVONotifying_myKVO.m
//  KVOTest
//
//  Created by mac on 2018/3/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MY_KVONotifying_myKVO.h"
#import "NSObject+MY_KVO.h"
#import <objc/runtime.h>

@implementation MY_KVONotifying_myKVO

- (void)setNum:(int)num{
    id observer = objc_getAssociatedObject(self, @"num");
    if (observer && [observer respondsToSelector:@selector(My_addObserver:forKeyPath:options:context:)]) {
        [observer My_addObserver:observer forKeyPath:@"num" options:NSKeyValueObservingOptionNew context:nil];
    }
    [super setNum:num];
//    [super setnu];
}

@end
