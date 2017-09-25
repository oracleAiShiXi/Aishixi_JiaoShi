//
//  JinJi_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "JinJi_ViewController.h"
#import "JinJiXiangQing_ViewController.h"
#import "SheZhi_ViewController.h"
#import "Color+Hex.h"

@interface JinJi_ViewController ()

@end

@implementation JinJi_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDelegate];
    
}
#pragma mark -----TableViewDelegate----
-(void)TableViewDelegate{
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
#pragma mark ------TableView ----变
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellString =@"jinjicell";
    UITableViewCell *cell =[_TableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    UIImageView *TouXiang = [cell viewWithTag:201];
    UILabel *Name = [cell viewWithTag:202];
    UILabel *DiZhi = [cell viewWithTag:203];
    UILabel *ShiJian = [cell viewWithTag:204];
    UILabel *Tpye = [cell viewWithTag:205];
    
    UIImage *image =[[UIImage alloc] init];
    NSString *NameString = @"";
    NSString *DiZhiString = @"";
    NSString *ShiJianString = @"";
    NSString *TpyeString = @"";
    
    image = [UIImage imageNamed:@"头像"];
    NameString = @"王小明";
    DiZhiString = @"哈尔滨香坊区红旗大街";
    ShiJianString = @"2017-07-28";
    if (1 == 1) {
        TpyeString = @"未处理";
        Tpye.textColor = [UIColor colorWithHexString:@"fe8192"];
    }else if (1 == 2){
        TpyeString = @"已处理";
        Tpye.textColor = [UIColor colorWithHexString:@"74e471"];
    }else{
        TpyeString = @"处理中";
        Tpye.textColor = [UIColor colorWithHexString:@"97bcfd"];
    }
    
    TouXiang.image = image ;
    Name.text = NameString ;
    DiZhi.text = DiZhiString;
    ShiJian.text = ShiJianString;
    Tpye.text = TpyeString;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self TiaoYe:indexPath];
}
#pragma  mark ----TableView ----不变
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void)TiaoYe:(NSIndexPath *)indexPath{
    /*数据处理*/
    
    
    
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    JinJiXiangQing_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"jinjixiangqing"];
    /*数据传输*/
    
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (IBAction)ShezhiButton:(id)sender {
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    SheZhi_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shezhi"];
    /*数据传输*/
    
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)ShaixuanButton:(id)sender {
}
@end
