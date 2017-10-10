
//
//  JinJiXiangQing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "JinJiXiangQing_ViewController.h"

@interface JinJiXiangQing_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation JinJiXiangQing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"呼叫详情";
    NSLog(@"%@",_sosId);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4;
}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * cellString = @"hehe";
//    UITableViewCell *cell =[]
//
//}
@end
