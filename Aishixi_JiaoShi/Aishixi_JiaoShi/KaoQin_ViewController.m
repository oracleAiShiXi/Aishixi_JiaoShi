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
#import "XL_TouWenJian.h"
#import "ShaiXuan_ViewController.h"

@interface KaoQin_ViewController (){
    int  pageNo,pageSize,count;
    NSDictionary * Dic;
    NSMutableArray *attendanceList;
    UIImageView * imageview;
}

@end

@implementation KaoQin_ViewController
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@",Dic);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDelegate];
    Dic=[NSDictionary dictionary];
    attendanceList = [NSMutableArray array];
    count = 0;
    pageSize = 10;
    pageNo = 1;
    [self JieKou];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
-(void)loadNewData{
    attendanceList = [NSMutableArray array];
    [_tableView reloadData];
    Dic=[NSDictionary dictionary];
    pageNo = 1;
    [self JieKou];
    [_tableView.mj_header endRefreshing];
    _tableView.mj_footer.hidden =NO;
}
-(void)loadMoreData{
    if (pageNo * pageSize < count) {
        pageNo += 1;
        [self JieKou];
        [_tableView.mj_footer endRefreshing];
    }else{
        _tableView.mj_footer.hidden =YES;
    }
}
-(void)JieKou{
    //
    [WarningBox warningBoxModeText:@"数据加载中..." andView:self.view];
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    //
    NSString *officeId;
    if ( [[Dic objectForKey:@"officeName"] objectForKey:@"id"] ==nil || NULL == [[Dic objectForKey:@"officeName"] objectForKey:@"id"] ||[ [[Dic objectForKey:@"officeName"] objectForKey:@"id"]  isEqual:[NSNull null]]) {
        officeId =@"";
    }else{
        officeId = [[Dic objectForKey:@"officeName"] objectForKey:@"id"];
    }
    
    //
    NSString *professionId;
    if ( [[Dic objectForKey:@"professionName"] objectForKey:@"professionId"] ==nil || NULL == [[Dic objectForKey:@"professionName"] objectForKey:@"professionId"] ||[ [[Dic objectForKey:@"professionName"] objectForKey:@"professionId"]  isEqual:[NSNull null]]) {
        professionId =@"";
    }else{
        professionId =[[Dic objectForKey:@"professionName"] objectForKey:@"professionId"];
    }
    
    //
    NSString *classId ;
    if ( [[Dic objectForKey:@"className"] objectForKey:@"classId"] ==nil || NULL == [[Dic objectForKey:@"className"] objectForKey:@"classId"] ||[ [[Dic objectForKey:@"className"] objectForKey:@"classId"]  isEqual:[NSNull null]]) {
        classId =@"";
    }else{
        classId =[[Dic objectForKey:@"className"] objectForKey:@"classId"];
    }
    //
    NSString *attendanceType ;
    if ( [Dic objectForKey:@"attendanceType"] ==nil || NULL == [Dic objectForKey:@"attendanceType"] ||[[Dic objectForKey:@"attendanceType"] isEqual:[NSNull null]]) {
        attendanceType =@"";
    }else{
        if ([[Dic objectForKey:@"attendanceType"]  isEqual: @"全部"]) {
            attendanceType = @"";
        }else if ([[Dic objectForKey:@"attendanceType"]  isEqual: @"正常"]){
            attendanceType = @"1";
        }else if ([[Dic objectForKey:@"attendanceType"]  isEqual: @"异常"]){
            attendanceType = @"2";
        }
        
    }
    //
    NSString *attendanceDate;
    if ( [Dic objectForKey:@"attendanceDate"] ==nil || NULL == [Dic objectForKey:@"attendanceDate"] ||[[Dic objectForKey:@"attendanceDate"] isEqual:[NSNull null]]) {
        attendanceDate =@"";
    }else{
        if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"全部"]) {
            attendanceDate =@"";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前周"]) {
            attendanceDate =@"1";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前月"]) {
            attendanceDate =@"2";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前半年"]) {
            attendanceDate =@"3";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前年"]) {
            attendanceDate =@"4";
        }
    }
    //
    NSString *attendanceStartTime ;
    if ( [Dic objectForKey:@"handleStrTime"] ==nil || NULL == [Dic objectForKey:@"handleStrTime"] ||[[Dic objectForKey:@"handleStrTime"] isEqual:[NSNull null]]) {
        attendanceStartTime =@"";
    }else{
        attendanceStartTime =[Dic objectForKey:@"handleStrTime"];
    }
    //
    NSString *attendanceEndTime ;
    if ( [Dic objectForKey:@"handleEndTime"] ==nil || NULL == [Dic objectForKey:@"handleEndTime"] ||[[Dic objectForKey:@"handleEndTime"] isEqual:[NSNull null]]) {
        attendanceEndTime =@"";
    }else{
        attendanceEndTime =[Dic objectForKey:@"handleEndTime"];
    }
    
    NSString *_pageSize = [NSString stringWithFormat:@"%d",pageSize];
    
    NSString *_pageNo = [NSString stringWithFormat:@"%d",pageNo];
    
    NSDictionary *did =[NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",officeId,@"officeId",professionId,@"professionId",classId,@"classId",attendanceType,@"attendanceType",attendanceDate,@"attendanceDate",attendanceStartTime,@"attendanceStartTime",attendanceEndTime,@"attendanceEndTime",_pageSize,@"pageSize",_pageNo,@"pageNo", nil];
    
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:@"/attend/attendanceList" Rucan:did type:Post success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            [attendanceList addObjectsFromArray:[data objectForKey:@"attendanceList"]];
            NSLog(@"%@",attendanceList);
            count = [[data objectForKey:@"count"] intValue];
            if (attendanceList.count == 0) {
                _tableView.hidden =YES;
                imageview.hidden = NO;
            }else{
                _tableView.hidden =NO;
                imageview.hidden = YES;
                [_tableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！请检查网络！" andView:self.view];
        NSLog(@"%@",error);
    }];
}

#pragma mark ----TableViewDelegate
-(void)TableViewDelegate{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    imageview.image =[UIImage imageNamed:@"试题背景"];
    [self.view addSubview:imageview];
    imageview.hidden = YES;
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
    NameString = [attendanceList[indexPath.section] objectForKey:@"nick"];
    NSString *guo =[attendanceList[indexPath.section] objectForKey:@"attendanceTime"];
    NSArray *guoArr = [guo componentsSeparatedByString:@" "];
    YerMonthString = guoArr[0];
    QianShiSring = @"签到时间:";
    TimeString = guoArr[1];
    
    //异常
//    if ([[attendanceList[indexPath.section] objectForKey:@"status"] isEqual:@"1"]) {
//        QianShi.textColor = [UIColor colorWithHexString:@""];
//        Time.textColor = [UIColor colorWithHexString:@""];
//    }
    
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
    return attendanceList.count;
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
     NSString * ID = [attendanceList[indexPath.section] objectForKey:@"attendanceId"];
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    KaoqInXiangqing_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"kaoqinxiangqing"];
    /*数据传输*/
    Kao.ID=ID;
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)ShaixuanButton:(id)sender {
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    ShaiXuan_ViewController * Shai = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shaixuan"];
    Shai.YeShai = 1;
    Shai.block = ^(NSDictionary *dic) {
        Dic = [NSDictionary dictionaryWithDictionary:dic];
        _tableView.mj_footer.hidden =NO;
        attendanceList = [NSMutableArray array];
        //    [_tableView reloadData];
        pageNo = 1;
        [self JieKou];
    };
    [self.navigationController pushViewController:Shai animated:NO];
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
@end
