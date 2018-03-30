//
//  SimpleKVOTestViewController.m
//  KVOTest
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SimpleKVOTestViewController.h"
#import "myKVO.h"
@interface SimpleKVOTestViewController ()

@property (nonatomic, strong) myKVO             *myKVO;
@property (weak, nonatomic) IBOutlet UILabel *numLB;
- (IBAction)changeBtn:(UIButton *)sender;

@end

@implementation SimpleKVOTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myKVO = [[myKVO alloc]init];
    
    //下面这句话前后断点显示self.myKVO的NSObject 的isa为myKVO
    [self.myKVO addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    //断点后显示self.myKVO的NSObject 的isa为NSKVONotifying_myKVO
    
}

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
@end
