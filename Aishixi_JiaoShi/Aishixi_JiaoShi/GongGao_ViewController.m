//
//  GongGao_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "GongGao_ViewController.h"
#import "GongGaoXiangQing_ViewController.h"
#import "FaBuGongGao_ViewController.h"

@interface GongGao_ViewController ()

@end

@implementation GongGao_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDelegate];
    _SegShou_Fa.selectedSegmentIndex = 0;
}
#pragma mark ---TableViewDelegate
-(void)TableViewDelegate{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
#pragma mark -----TableView---方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellString = @"shoujiancell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    UILabel * BiaoTi = [cell viewWithTag:112];
    UIImageView * ZhongYao = [cell viewWithTag:113];
    UILabel * ShiJian = [cell viewWithTag:114];
    
    NSString * BiaoTiSring = @"";
    UIImage * image =[[UIImage alloc] init];
    NSString * ShiJianString = @"";
    
    switch (_SegShou_Fa.selectedSegmentIndex) {
        case 0:
            BiaoTiSring = @"新学期暑期实习公告";
            image = [UIImage imageNamed:@"头像"];
            ShiJianString =@"2017-06-18";
            break;
        case 1:
            BiaoTiSring = @"我是发件箱～～～";
            image = [UIImage imageNamed:@"头像"];
            ShiJianString =@"2017-12-22";
            break;
        default:
            break;
    }
    
    BiaoTi.text = BiaoTiSring;
    ZhongYao.image = image;
    ShiJian.text = ShiJianString;
    
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_SegShou_Fa.selectedSegmentIndex) {
        case 0:
            [self ShouJianXiangQiang:indexPath];
            break;
        case 1:
            [self FaJianXiangQiang:indexPath];
            break;
        default:
            break;
    }
}
#pragma mark ----TableView---不变
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

#pragma mark ----跳页方法
-(void)ShouJianXiangQiang:(NSIndexPath *)indexPath{
    /*数据处理*/
    
    
    
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    GongGaoXiangQing_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"gonggaoxiangqing"];
    /*数据传输*/
    
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)FaJianXiangQiang:(NSIndexPath *)indexPath{
    /*数据处理*/
    
    
    
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    FaBuGongGao_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"fabugonggao"];
    /*数据传输*/
    
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark ----SegmentControl点击方法;
- (IBAction)FaShou:(id)sender {
    UISegmentedControl * control = (UISegmentedControl *)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            
            [_tableView reloadData];
            break;
        case 1:
            
            [_tableView reloadData];
            break;
        default:
            break;
    }
}
@end
