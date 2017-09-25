//
//  KaoQin_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "KaoQin_ViewController.h"
#import "KaoqInXiangqing_ViewController.h"
#import "SheZhi_ViewController.h"
#import "Color+Hex.h"

@interface KaoQin_ViewController ()

@end

@implementation KaoQin_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDelegate];
}
#pragma mark ----TableViewDelegate
-(void)TableViewDelegate{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
#pragma mark -----TableView---方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellString =@"kaoqincell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    UIImageView *ImageView = [cell viewWithTag:101];
    UILabel * Name = [cell viewWithTag:102];
    UILabel * YerMonth = [cell viewWithTag:103];
    UILabel * QianShi = [cell viewWithTag:104];
    UILabel * Time = [cell viewWithTag:105];
    
    UIImage * image = [[UIImage alloc] init];
    NSString * NameString =@"";
    NSString * YerMonthString =@"";
    NSString * QianShiSring =@"";
    NSString * TimeString = @"";
    
    image = [UIImage imageNamed:@"头像"];
    NameString = @"斌小狼";
    YerMonthString = @"2017-09-28";
    QianShiSring = @"签到时间:";
    TimeString = @"08:57";
    
    //异常
    if (indexPath.section == 0) {
        QianShi.textColor = [UIColor colorWithHexString:@""];
        Time.textColor = [UIColor colorWithHexString:@""];
    }
    
    ImageView.image = image;
    Name.text = NameString;
    YerMonth.text = YerMonthString;
    QianShi.text = QianShiSring;
    Time.text = TimeString;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self TiaoYeFangFa:indexPath];
}
#pragma mark ----TableView---不变
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark ----跳页方法
-(void)TiaoYeFangFa:(NSIndexPath *)indexPath{
    /*数据处理*/
    
    
    
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    KaoqInXiangqing_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"kaoqinxiangqing"];
    /*数据传输*/
    
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)ShaixuanButton:(id)sender {
    
   
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
@end
