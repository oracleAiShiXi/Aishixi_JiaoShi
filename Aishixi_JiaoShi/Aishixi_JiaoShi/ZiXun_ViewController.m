//
//  ZiXun_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "ZiXun_ViewController.h"
#import "ZiXunXiangQing_ViewController.h"
#import "Color+Hex.h"

@interface ZiXun_ViewController ()

@end

@implementation ZiXun_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDelegate];
}
#pragma mark -----TableViewDelegate
-(void)TableViewDelegate{
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    self.TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
#pragma mark -----TableView---方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.TableView dequeueReusableCellWithIdentifier:@"zixuncell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"zixuncell"];
    }
    UIImageView *TouXiang = [cell viewWithTag:121];
    UILabel * Name =[cell viewWithTag:122];
    UILabel * YerMonth = [cell viewWithTag:123];
    UILabel * Type = [cell viewWithTag:124];
    UILabel * State = [cell viewWithTag:125];
    
    
    
    UIImage * image = [[UIImage alloc] init];
    NSString * NameString = @"";
    NSString * YerMonthString = @"";
    NSString * TypeString = @"";
    NSString * StateString = @"";
    
    image = [UIImage imageNamed:@"头像"];
    NameString = @"王小明";
    YerMonthString = @"2017-08-18";
    TypeString =@"呵呵";
    //判断咨询类型
    if (indexPath.section == 0) {
        TypeString = @"岗位";
        Type.backgroundColor = [UIColor colorWithHexString:@"0ee6c8"];
    }
    else if (indexPath.section == 1){
        TypeString = @"请假";
        Type.backgroundColor = [UIColor colorWithHexString:@"fa9463"];
    }
    else if (indexPath.section == 2){
        TypeString = @"其他";
        Type.backgroundColor = [UIColor colorWithHexString:@"ffca27"];
    }
    //判断回复
    if (indexPath.section == 0) {
        StateString = @"已回复";
    }else if (indexPath.section == 1){
        StateString = @"未回复";
    }
    
    Type.layer.cornerRadius = 5;
    Type.clipsToBounds = YES;
    
    TouXiang.image = image;
    Name.text = NameString;
    YerMonth.text =YerMonthString;
    Type.text = TypeString;
    State.text = StateString;
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self TiaoZhuan:indexPath];
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
#pragma mark -----跳页方法
-(void)TiaoZhuan:(NSIndexPath *)indexPath{
    /*数据处理*/
    
    
    
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    ZiXunXiangQing_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"zixunxiangqing"];
    /*数据传输*/
    
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
@end
