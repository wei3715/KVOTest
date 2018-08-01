//
//  ZWWCustomKVOViewController.m
//  KVOTest
//
//  Created by zhaoweiwei on 2018/8/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZWWCustomKVOViewController.h"
#import "NSObject+KVO.h"

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;

@end

@implementation Message

@end

@interface ZWWCustomKVOViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) Message *message;


@end

@implementation ZWWCustomKVOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.message = [[Message alloc] init];
    [self.message PG_addObserver:self forKey:NSStringFromSelector(@selector(text))
                       withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                           NSLog(@"%@.%@ is now: %@", observedObject, observedKey, newValue);
                           dispatch_async(dispatch_get_main_queue(), ^{
                               self.textfield.text = newValue;
                           });
                           
                       }];
    
    [self changeMessage:nil];
}
- (IBAction)changeMessage:(id)sender {
    NSArray *msgs = @[@"Hello World!", @"Objective C", @"Swift", @"Peng Gu", @"peng.gu@me.com", @"www.gupeng.me", @"glowing.com"];
    NSUInteger index = arc4random_uniform((u_int32_t)msgs.count);
    self.message.text = msgs[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
