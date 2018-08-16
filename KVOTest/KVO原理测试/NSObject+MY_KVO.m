//
//  NSObject+MY_KVO.m
//  KVOTest
//
//  Created by mac on 2018/3/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "NSObject+MY_KVO.h"
#import <objc/runtime.h>
#import "MY_KVONotifying_myKVO.h"
@implementation NSObject (MY_KVO)

-(void)My_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    // 修改isa指针(runtime) 系统的MY_KVONotifying_Person这个类是动态生成的,我们直接手动创建
    
    object_setClass(self, [MY_KVONotifying_myKVO class]);
    // 给对象动态添加属性,之前文章介绍过了.目的是保存observer,好在set方法里面拿到,调用My_addObserver:forKeyPath:options:context:这个方法
    
    objc_setAssociatedObject(self, (__bridge const void *)(keyPath), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
