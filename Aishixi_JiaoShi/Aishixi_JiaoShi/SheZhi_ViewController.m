//
//  SheZhi_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/25.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "SheZhi_ViewController.h"
#import "PingJia_ViewController.h"
#import "XiuGai_ViewController.h"


@interface SheZhi_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SheZhi_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self delegate];
}
-(void)delegate{
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellString = @"pingjiacell";
    UITableViewCell *cell = [_TableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    UILabel * ming = [cell viewWithTag:10010];
    if (indexPath.row == 0) {
        ming.text = @"学生评价";
    }else if (indexPath.row == 1){
        ming.text = @"修改密码";
    }else if (indexPath.row == 2){
        
    }else{
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    /*传值*/
    if (indexPath.row == 0) {
         PingJia_ViewController *a = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pingjia"];
        
        [self.navigationController pushViewController:a animated:YES];
    }else if (indexPath.row == 1){
        XiuGai_ViewController *a = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"xiugai"];
        
        [self.navigationController pushViewController:a animated:YES];
    }else if (indexPath.row == 2){
        //用户建议
    }else if (indexPath.row == 3){
        //使用帮助
    }else if (indexPath.row == 4){
        
    }
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end