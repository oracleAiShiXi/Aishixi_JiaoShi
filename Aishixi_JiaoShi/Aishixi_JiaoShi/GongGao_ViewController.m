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
#import "SheZhi_ViewController.h"
#import "XL_TouWenJian.h"
@interface GongGao_ViewController ()
{
    int  pageNo,pageSize,count;
    NSDictionary * Dic;
    NSMutableArray *inboxList ;
    UIImageView * imageview;
}
@end

@implementation GongGao_ViewController
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@",Dic);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDelegate];
    _SegShou_Fa.selectedSegmentIndex = 0;
    _fa.hidden = YES;
    Dic=[NSDictionary dictionary];
    inboxList  = [NSMutableArray array];
    count = 0;
    pageSize = 5;
    pageNo = 1;
    [self jiekou:nil];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
-(void)loadNewData{
    inboxList  = [NSMutableArray array];
    pageNo = 1;
    [self jiekou:Dic];
    [_tableView.mj_header endRefreshing];
}
-(void)loadMoreData{
    if (pageNo * pageSize < count) {
        pageNo += 1;
        [self jiekou:Dic];
        [_tableView.mj_footer endRefreshing];
    }
}
-(void)jiekou:(NSDictionary*)dic{
    NSString * Method = @"/teacher/inboxList";
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    NSString * type = @"";
    switch (_SegShou_Fa.selectedSegmentIndex) {
        case 0:
            type =@"1";
            break;
        case 1:
            type =@"2";
            break;
        default:
            break;
    }
    
    //1shou  2fa
    NSString * leve = @"";
    NSString * createDate = @"";
    NSString * startTime = @"";
    NSString * endTime = @"";
    NSNumber *_pageNo = [NSNumber numberWithInt:pageNo];
    NSNumber *_pageSize = [NSNumber numberWithInt:pageSize];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",type,@"type",leve,@"leve",createDate,@"createDate",startTime,@"startTime",endTime,@"endTime",_pageSize,@"pageSize",_pageNo,@"pageNo",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"26.    教师公告通知收件箱，发件箱\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            [inboxList addObjectsFromArray:[data objectForKey:@"inboxList"]];
            count = [[data objectForKey:@"count"] intValue];
            if (inboxList.count == 0) {
                _tableView.hidden =YES;
                imageview.hidden = NO;
            }else{
                _tableView.hidden =NO;
                imageview.hidden = YES;
                [_tableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
            BiaoTiSring = [inboxList[indexPath.section] objectForKey:@"inboxTitle"];
            image = [UIImage imageNamed:@"头像"];
            ShiJianString =[inboxList[indexPath.section] objectForKey:@"inboxTime"];
            break;
        case 1:
            BiaoTiSring = [inboxList[indexPath.section] objectForKey:@"inboxTitle"];
            image = [UIImage imageNamed:@"头像"];
            ShiJianString =[inboxList[indexPath.section] objectForKey:@"inboxTime"];
            break;
        default:
            break;
    }
    
    BiaoTi.text = BiaoTiSring;
    ZhongYao.image = image;
    ShiJian.text = ShiJianString;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_SegShou_Fa.selectedSegmentIndex) {
        case 0:
            [self ShouJianXiangQiang:indexPath :0];
            
            break;
        case 1:
            [self ShouJianXiangQiang:indexPath :1];
            
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
    return inboxList.count;
}

#pragma mark ----跳页方法
-(void)ShouJianXiangQiang:(NSIndexPath *)indexPath :(int)a{
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    GongGaoXiangQing_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"gonggaoxiangqing"];
    /*数据传输*/
    if (a == 0) {
        Kao.titleX = @"收件详情";
    }else{
        Kao.titleX = @"发件详情";
    }
    Kao.inboxId = [inboxList[indexPath.section] objectForKey:@"inboxId"];
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//-(void)FaJianXiangQiang:(NSIndexPath *)indexPath{
//    /*数据处理*/
//
//
//    
//    /*TabBar 隐藏*/
//    self.tabBarController.tabBar.hidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
//    FaBuGongGao_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"fabugonggao"];
//    /*数据传输*/
//
//    [self.navigationController pushViewController:Kao animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
//}
#pragma mark ----SegmentControl点击方法;
- (IBAction)FaShou:(id)sender {
    inboxList = [NSMutableArray array];
    UISegmentedControl * control = (UISegmentedControl *)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            _fa.hidden = YES;
            [self jiekou:nil];
            //            [_tableView reloadData];
            break;
        case 1:
            _fa.hidden = NO;
            [self jiekou:nil];
            //            [_tableView reloadData];
            break;
        default:
            break;
    }
}
- (IBAction)TiaoFaBu:(id)sender {
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    FaBuGongGao_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"fabugonggao"];
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
