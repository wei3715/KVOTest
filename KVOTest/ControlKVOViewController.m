//
//  ControlKVOViewController.m
//  KVOTest
//
//  Created by mac on 2018/3/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ControlKVOViewController.h"

@interface ControlKVOViewController ()

@property (weak, nonatomic) IBOutlet UILabel *valueLB;
- (IBAction)changeBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ControlKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //利用kvo可以实现不仅可以监听手动拖动slider时value变化，在其他地方改变slider的value也可以监听
    [self.slider addObserver:self forKeyPath:@"value" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
    
    //这个方法只能监听手动拖动slider时，value值得变化
    [self.slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventTouchUpInside];
}

//不实现此方法error log：
//Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '<ViewController: 0x7f83f5704ac0>: An -observeValueForKeyPath:ofObject:change:context: message was received but not handled.
//Key path: num

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
   
    if (([keyPath isEqualToString:@"value"]) && (object == self.slider)) {//slider
        self.valueLB.text = [NSString stringWithFormat:@"slider.value=%@",[change valueForKey:@"new"]];
        SEL method = NSSelectorFromString(@"sliderFunc:");
        IMP imp = [self methodForSelector:method];
        //含有参数的方法分发
        void (*func)(id, SEL, id) = (void *)imp;
        func(self, method, object);
        
        
        //没有参数的方法分发
        //    void (*func)(id, SEL) = (void *)imp;
        //    func(self, method);
    }
    NSLog(@"keyPath == %@,object == %@,change==%@, 变化前数据==%@,变化后数据==%@, context==%@",keyPath,object,change,change[NSKeyValueChangeOldKey] ,change[NSKeyValueChangeNewKey] ,context);
    
}

- (IBAction)changeBtn:(UIButton *)sender {
    
    self.slider.value = self.slider.value+0.2;
}

//kvo  监听回调方法
- (void)sliderFunc:(UISlider *)slider {
    NSLog(@"利用kvo监听slider.value值改变，slider.value==%f",slider.value);
}

//target 监听回调
- (void)sliderValueChange:(UISlider *)slider{
    NSLog(@"拖动滚动调皮导致slider.value变化：slider.value==%f",slider.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
