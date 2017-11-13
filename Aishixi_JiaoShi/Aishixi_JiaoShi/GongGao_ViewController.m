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
#import "ShaiXuan_ViewController.h"
#import "XL_TouWenJian.h"
@interface GongGao_ViewController ()
{
    int  pageNo,pageSize,count,panP;
    NSDictionary * Dic;
    NSMutableArray *inboxList ;
}
@end

@implementation GongGao_ViewController
-(void)viewWillAppear:(BOOL)animated{
    if (panP == 0) {
        [self loadNewData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDelegate];
    panP=1;
    _SegShou_Fa.selectedSegmentIndex = 0;
    _fa.hidden = YES;
    Dic=[NSDictionary dictionary];
    inboxList  = [NSMutableArray array];
    count = 0;
    pageSize = 10;
    pageNo = 1;
    [self jiekou:nil];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
-(void)loadNewData{
    inboxList  = [NSMutableArray array];
    [_tableView reloadData];
    Dic = [NSDictionary dictionary];
    pageNo = 1;
    [self jiekou:Dic];
    [_tableView.mj_header endRefreshing];
}
-(void)loadMoreData{
    if (pageNo * pageSize < count) {
        pageNo += 1;
        [self jiekou:Dic];
        [_tableView.mj_footer endRefreshing];
    }else{
        _tableView.mj_footer.hidden =YES;
    }
}
-(void)jiekou:(NSDictionary*)dic{
    [WarningBox warningBoxModeText:@"数据加载中..." andView:self.view];
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
    NSString * level;
    if ( [Dic objectForKey:@"level"] ==nil || NULL == [Dic objectForKey:@"level"] ||[[Dic objectForKey:@"level"] isEqual:[NSNull null]]) {
        level =@"";
    }else{
        if ([[Dic objectForKey:@"level"]  isEqual: @"全部"]) {
            level = @"";
        }else if ([[Dic objectForKey:@"level"]  isEqual: @"重要"]) {
            level = @"1";
        }else if ([[Dic objectForKey:@"level"]  isEqual: @"普通"]) {
            level = @"2";
        }
    }
    NSString *startTime;
    if ( [Dic objectForKey:@"handleStrTime"] ==nil || NULL == [Dic objectForKey:@"handleStrTime"] ||[[Dic objectForKey:@"handleStrTime"] isEqual:[NSNull null]]) {
        startTime =@"";
    }else{
        startTime =[Dic objectForKey:@"handleStrTime"];
    }
    //
    NSString *endTime ;
    if ( [Dic objectForKey:@"handleEndTime"] ==nil || NULL == [Dic objectForKey:@"handleEndTime"] ||[[Dic objectForKey:@"handleEndTime"] isEqual:[NSNull null]]) {
        endTime =@"";
    }else{
        endTime =[Dic objectForKey:@"handleEndTime"];
    };
    //attendanceDate   周期
    NSString *createDate;
    if ( [Dic objectForKey:@"attendanceDate"] ==nil || NULL == [Dic objectForKey:@"attendanceDate"] ||[[Dic objectForKey:@"attendanceDate"] isEqual:[NSNull null]]) {
        createDate =@"";
    }else{
        if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"全部"]) {
            createDate =@"";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前周"]) {
            createDate =@"1";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前月"]) {
            createDate =@"2";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前半年"]) {
            createDate =@"3";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前年"]) {
            createDate =@"4";
        }

    }
    NSNumber *_pageNo = [NSNumber numberWithInt:pageNo];
    NSNumber *_pageSize = [NSNumber numberWithInt:pageSize];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",type,@"type",level,@"level",createDate,@"createDate",startTime,@"startTime",endTime,@"endTime",_pageSize,@"pageSize",_pageNo,@"pageNo",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        NSLog(@"26.    教师公告通知收件箱，发件箱\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            [inboxList addObjectsFromArray:[data objectForKey:@"inboxList"]];
            count = [[data objectForKey:@"count"] intValue];
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！请检查网络！" andView:self.view];
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
            if ([[inboxList[indexPath.section] objectForKey:@"level"]  isEqual: @"1"]) {
                image = [UIImage imageNamed:@"zhongyao"];
            }
            ShiJianString =[inboxList[indexPath.section] objectForKey:@"inboxTime"];
            break;
        case 1:
            BiaoTiSring = [inboxList[indexPath.section] objectForKey:@"inboxTitle"];
            if ([[inboxList[indexPath.section] objectForKey:@"level"] isEqual: @"1"]) {
                image = [UIImage imageNamed:@"zhongyao"];
            }
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
    panP = 0;
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)ShezhiButton:(id)sender {
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    SheZhi_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shezhi"];
    /*数据传输*/
    panP = 1;
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)ShaixuanButton:(id)sender {
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;panP = 1;
    ShaiXuan_ViewController * Shai = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shaixuan"];
    Shai.YeShai = 3;
    Shai.block = ^(NSDictionary *dic) {
        Dic = [NSDictionary dictionaryWithDictionary:dic];
        inboxList  = [NSMutableArray array];
        pageNo = 1;
        _tableView.mj_footer.hidden =NO;
        [self jiekou:Dic];
    };
    [self.navigationController pushViewController:Shai animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
@end
