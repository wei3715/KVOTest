//
//  myKVO.m
//  KVOTest
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "myKVO.h"
@interface myKVO(){
    NSString *_name;
}
@end

@implementation myKVO

- (instancetype)init{
    self = [super init];
    if (self) {
        [self doNoti];
    }
    return self;
}

- (void)setNum:(int)num{
//    [self doNoti];
    if ([self.delegate respondsToSelector:@selector(printNum:)]) {
        [self.delegate printNum:num];
    }
}

- (void)doNoti{
    _name = @"通知模式";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NameChangeNoti" object:@{@"name":_name}];
}

@end
