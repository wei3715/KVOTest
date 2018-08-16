//
//  KVOPrincipleViewController.m
//  KVOTest
//
//  Created by mac on 2018/3/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "KVOPrincipleViewController.h"
#import "myKVO.h"
#import "NSObject+MY_KVO.h"
@interface KVOPrincipleViewController ()

@property (nonatomic, strong) myKVO  *myKVO;

@end

@implementation KVOPrincipleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    _myKVO = [[myKVO alloc]init];
    [_myKVO My_addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionNew context:nil];
   
}

- (void)My_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    NSLog(@"num++ 自己的KVO");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _myKVO.num ++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
