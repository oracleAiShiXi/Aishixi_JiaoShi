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
#import "ShaiXuan_ViewController.h"
#import "XL_TouWenJian.h"
#import "XLDateCompare.h"
@interface JinJi_ViewController (){
    int  pageNo,pageSize,count;
    NSMutableArray *sosList;
    NSDictionary * Dic;
    int panP ;
}

@end

@implementation JinJi_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDelegate];
    count = 0;
    pageSize = 10;
    pageNo = 1;
    panP= 1 ;
    Dic=[NSDictionary dictionary];
    sosList = [[NSMutableArray alloc] init];
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self JieKou];
}
-(void)viewWillAppear:(BOOL)animated{
    if (panP == 0) {
        [self loadNewData];
    }
}
-(void)loadNewData{
    sosList = [[NSMutableArray alloc] init];
    [_TableView reloadData];
    Dic = [NSDictionary dictionary];
    pageNo = 1;
    [self JieKou];
    [_TableView.mj_header endRefreshing];
    self.TableView.mj_footer.hidden = NO;
}
-(void)loadMoreData{
    if (pageNo * pageSize >= count) {
        self.TableView.mj_footer.hidden = YES;
    }else{
        pageNo += 1;
        [self JieKou];
        [_TableView.mj_footer endRefreshing];
    }
}
#pragma mark ----接口
-(void)JieKou{
    [WarningBox warningBoxModeText:@"数据加载中..." andView:self.view];
    NSString * method = @"/teacher/sosList";
    //请求页数
    NSNumber* _pageNo =[NSNumber numberWithInt:pageNo];
    //请求条数
    NSNumber* _pageSize =[NSNumber numberWithInt:pageSize];
    //用户Id
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    //所属单位
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
    NSString *handleState ;
    if ( [Dic objectForKey:@"handleState"] ==nil || NULL == [Dic objectForKey:@"handleState"] ||[[Dic objectForKey:@"handleState"] isEqual:[NSNull null]]) {
        handleState =@"";
    }else{
        if ([[Dic objectForKey:@"handleState"]  isEqual: @"全部"]) {
            handleState = @"";
        }else if ([[Dic objectForKey:@"handleState"]  isEqual: @"已处理"]){
            handleState = @"1";
        }else if ([[Dic objectForKey:@"handleState"]  isEqual: @"处理中"]){
            handleState = @"2";
        }else if ([[Dic objectForKey:@"handleState"]  isEqual: @"未处理"]){
            handleState = @"3";
        }
        
    }
    //
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
    //
    NSString *startTime ;
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
    }
    
    NSDictionary * Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_pageNo,@"pageNo",_pageSize,@"pageSize",userId,@"userId",officeId,@"officeId",professionId,@"professionId",classId,@"classId",handleState,@"handleState",createDate,@"createDate",startTime,@"startTime",endTime,@"endTime", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:method Rucan:Rucan type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
//        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            NSDictionary * data =[responseObject objectForKey:@"data"];
            NSArray * aa=[data objectForKey:@"sosList"];
            [sosList addObjectsFromArray:aa];
            count = [[data objectForKey:@"count"] intValue];
//            NSLog(@"----%@,---%d",sosList,count);
            
            [_TableView reloadData];
        }
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！请检查网络！" andView:self.view];
        NSLog(@"%@",error);
    }];
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
    NSLog(@"%ld",(long)indexPath.section);
    NameString = [NSString stringWithFormat:@"%@",[sosList[indexPath.section] objectForKey:@"nick"] !=nil ? [sosList[indexPath.section] objectForKey:@"nick"]:@""];
    DiZhiString = [NSString stringWithFormat:@"%@",[sosList[indexPath.section] objectForKey:@"sosLocation"]!=nil ? [sosList[indexPath.section] objectForKey:@"sosLocation"]:@""];
    ShiJianString =[NSString stringWithFormat:@"%@",[sosList[indexPath.section] objectForKey:@"sosTime"]!=nil ? [sosList[indexPath.section] objectForKey:@"sosTime"]:@""];
    NSString * handleState = [sosList[indexPath.section] objectForKey:@"handleState"];
    if (handleState!=nil) {
        if ([handleState isEqual: @"1"]) {
            TpyeString = @"已处理";
            Tpye.textColor = [UIColor colorWithHexString:@"74e471"];
        }else if ([[sosList[indexPath.section] objectForKey:@"handleState"]  isEqual: @"3"]){
            TpyeString = @"未处理";
            Tpye.textColor = [UIColor colorWithHexString:@"fe8192"];
        }else{
            TpyeString = @"处理中";
            Tpye.textColor = [UIColor colorWithHexString:@"97bcfd"];
        }
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
    return sosList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void)TiaoYe:(NSIndexPath *)indexPath{
    /*数据处理*/
    
    NSString* sosId = [sosList[indexPath.section] objectForKey:@"sosId"];
    panP = 0;
    
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    JinJiXiangQing_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"jinjixiangqing"];
    /*数据传输*/
    Kao.sosId = sosId;
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (IBAction)ShezhiButton:(id)sender {
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    SheZhi_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shezhi"];
    /*数据传输*/
    panP=1;
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)ShaixuanButton:(id)sender {
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;   panP=1;
    ShaiXuan_ViewController * Shai = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shaixuan"];
    Shai.YeShai = 4;
    Shai.block = ^(NSDictionary *dic) {
        Dic = [NSDictionary dictionaryWithDictionary:dic];
        sosList = [[NSMutableArray alloc] init];
        pageNo = 1;
        self.TableView.mj_footer.hidden = NO;
        [self JieKou];
    };
    [self.navigationController pushViewController:Shai animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
@end
