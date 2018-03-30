//
//  DiffViewController.m
//  KVOTest
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "DiffViewController.h"
#import "myKVO.h"
@interface DiffViewController ()<myKVODelegate>

@property (nonatomic, strong) myKVO            *myKVO1;

@end

@implementation DiffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notiMode:) name:@"NameChangeNoti" object:nil];
    
    self.myKVO1 = [[myKVO alloc]init];
    
    //一定要设置代理身份，再给num赋值，否则num的set方法里面delegate不会回调响应
    self.myKVO1.delegate = self;
    self.myKVO1.num = 10;
}

//代理方法
- (void)printNum:(int)num{
    NSLog(@"delegate通知数据的变化num==%d",num);
}

//通知方法
- (void)notiMode:(NSNotification *)noti{
    NSString *name = [noti.object valueForKey:@"name"];
    NSLog(@"全局变量name的值==%@",name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 总结 KVO，NSNotifation,delegate

/**
 KVO:只能监听通过setter或者KVC赋值的对象的属性；
 与NSNotifation不同地方：中间不需要post发送属性变化通知，这一步隐藏到系统管理
 与NSNotifation不同地方：都是主要针对一对多情况，是类之间的交互（不太懂这句话）
 
 NSNotifation：需要借助中间变量NSNotificationCenter,需要监听变化addObserver，被观察的属性还需要post通知变化。
 
 
 delegate：
 委托方：
 1.声明delegate属性
 2.声明代理方法
 3.在要执行方法的地方调用代理
 
 被委托方：
 1.遵循delegate
 2.声明最为代理委托方身份 self.myKVO.delegate = self;
 3.实现代理方法
 
 一般是：一对一
 
 1）KVO，NSNotifation 这两个都是负责发送接收通知，剩下的事情由系统处理，所以不用返回值；而 delegate 则需要通信的对象通过变量(代理)联系；
 
 2） 对比其他的回调方式，KVO 机制的运用的实现，更多的由系统支持，相比 notification、delegate 等更简洁些，并且能够提供观察属性的最新值以及原始值；但是相应的在创建子类、重写方法等等方面的内存消耗是很巨大的。所以对于两个类之间的通信，我们可以根据实际开发的环境采用不同的方法，使得开发的项目更加简洁实用。
 
 3) 另外需要注意的是，由于这种继承方式的注入是在运行时而不是编译时实现的，如果给定的实例没有观察者，那么 KVO 不会有任何开销，因为此时根本就没有 KVO 代码存在。但是即使没有观察者，委托和 NSNotification 还是得工作，这也是KVO此处零开销观察的优势。
 
 **/

@end
