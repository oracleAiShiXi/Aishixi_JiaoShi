//
//  PingJia_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/25.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "PingJia_ViewController.h"
#import "PingJiaXiangQing_ViewController.h"
#import "Color+Hex.h"

@interface PingJia_ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PingJia_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"评价";
    [self delegate];
}
-(void)delegate{
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellString = @"pingjialiebiao";
    UITableViewCell * cell =[_TableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    UIImageView *TouXiang = [cell viewWithTag:1001];
    UILabel *Name = [cell viewWithTag:1002];
    UILabel *Tpye = [cell viewWithTag:1003];
    
    UIImage *image = [[UIImage alloc] init];
    NSString *NameString =@"";
    NSString *TpyeString = @"";
    
    image = [UIImage imageNamed:@"02"];
    NameString = @"王小明";
    if (indexPath.section == 1) {
        TpyeString = @"已评价";
        Tpye.textColor = [UIColor colorWithHexString:@"8ed4ff"];
    }else{
        TpyeString = @"未评价";
        Tpye.textColor = [UIColor colorWithHexString:@"fe5a6e"];
    }
    
    TouXiang.image = image;
    Name.text =NameString;
    Tpye.text = TpyeString;
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self TiaoYe:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(void)TiaoYe:(NSIndexPath *)indexPath{
    PingJiaXiangQing_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pingjiaxiangqing"];
    /*数据传输*/
    
    [self.navigationController pushViewController:Kao animated:YES];
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
