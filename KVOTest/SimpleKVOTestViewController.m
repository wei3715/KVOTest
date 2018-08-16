//
//  SimpleKVOTestViewController.m
//  KVOTest
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SimpleKVOTestViewController.h"
#import "myKVO.h"
#import <objc/runtime.h>

@interface SimpleKVOTestViewController ()

@property (nonatomic, strong) myKVO             *myKVO;
@property (weak, nonatomic) IBOutlet UILabel *numLB;
- (IBAction)changeBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;
- (IBAction)changeName:(id)sender;

@end

@implementation SimpleKVOTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myKVO = [[myKVO alloc]init];
    
    
    //下面这句话前后断点显示self.myKVO的NSObject 的isa为myKVO
    /**
     1. self.myKVO：要监听的对象
     2. 参数说明：
     * @param addObserver  观察者，负责处理监听事件的对象
     * @param forKeyPath 要监听的属性
     * @param  options 观察的选项（观察新、旧值，也可以都观察）
     * @param context 上下文，用于传递数据，可以利用上下文区分不同的监听
     */
    [self.myKVO addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    NSLog(@"添加观察者后的类：%s",class_getName(object_getClass(self.myKVO)));
    
//    [self.myKVO removeObserver:self forKeyPath:@"num"];
//     NSLog(@"移除观察者后的类：%s",class_getName(object_getClass(self.myKVO)));
    
    //打印log：说明self.myKVO对象的isa指向的类对象的确在改变。
//    2018-03-30 13:59:43.079644+0800 KVOTest[28074:290398] 添加观察者后的类：NSKVONotifying_myKVO
//    2018-03-30 13:59:53.143634+0800 KVOTest[28074:290398] 移除观察者后的类：myKVO
    //断点后显示self.myKVO的NSObject 的isa为NSKVONotifying_myKVO
    
     [self.myKVO addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
}

/**
 *  当监控的某个属性的值改变了就会调用
 *
 *  @param keyPath 监听的属性名
 *  @param object  属性所属的对象
 *  @param change  属性的修改情况（属性原来的值`oldValue`、属性最新的值`newValue`）
 *  @param context 传递的上下文数据，与监听的时候传递的一致，可以利用上下文区分不同的监听
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (([keyPath isEqualToString:@"num"]) && (object == self.myKVO)) {//myKVO
        self.numLB.text = [NSString stringWithFormat:@"num=%@",[change valueForKey:@"new"]];
    }
    
    NSLog(@"keyPath == %@,object == %@,change==%@, 变化前数据==%@,变化后数据==%@, context==%@",keyPath,object,change,change[NSKeyValueChangeOldKey] ,change[NSKeyValueChangeNewKey] ,context);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeBtn:(UIButton *)sender {
    self.myKVO.num = self.myKVO.num + 1;
    
}
- (IBAction)changeName:(id)sender {
    
}
@end
