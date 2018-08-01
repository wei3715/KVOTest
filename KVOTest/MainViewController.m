//
//  MainViewController.m
//  KVOTest
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView       *menuTab;
@property (nonatomic, strong) NSArray           *titleArr;
@property (nonatomic, strong) NSArray           *vcArr;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createData];
    [self createUI];
    
}

- (void)createUI{
    self.menuTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth,KScreenHeight-64)];
    self.menuTab.delegate = self;
    self.menuTab.dataSource = self;
    [self.view addSubview:self.menuTab];
}

- (void)createData{
    self.titleArr = @[@"KVO简单测试",@"KVO 针对控件测试",@"KVO原理测试",@"自定义手动实现KVO", @"KVO,Notification,delegate对比"];
    self.vcArr = @[@"SimpleKVOTestViewController",@"ControlKVOViewController",@"SimpleKVOTestViewController",@"ZWWCustomKVOViewController",@"DiffViewController"];
}

#pragma delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class className = NSClassFromString(self.vcArr[indexPath.row]);
    UIViewController *vc = [[className alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
