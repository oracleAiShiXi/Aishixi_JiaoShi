//
//  ZiXun_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "ZiXun_ViewController.h"
#import "ZiXunXiangQing_ViewController.h"
#import "SheZhi_ViewController.h"
#import "ShaiXuan_ViewController.h"
#import "XL_TouWenJian.h"

@interface ZiXun_ViewController (){
    int  pageNo,pageSize,count,panP;
    NSDictionary * Dic;
    NSMutableArray *consulList;
    UIImageView * imageview;
}

@end

@implementation ZiXun_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDelegate];
    Dic=[NSDictionary dictionary];
    consulList = [NSMutableArray array];
    count = 0;
    pageSize = 5;
    pageNo = 1;panP=0;
    [self jiekou:nil];
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    [self.tabBarController.tabBar.items objectAtIndex:1].badgeValue = [NSString stringWithFormat:@"20"];
}
-(void)viewWillAppear:(BOOL)animated{
    if (panP == 1) {
        [self loadNewData];
    }
}
-(void)loadNewData{
    consulList = [NSMutableArray array];
    pageNo = 1;
    Dic = [NSDictionary dictionary];
    [self jiekou:Dic];
    [_TableView.mj_header endRefreshing];
    _TableView.mj_footer.hidden =NO;
}
-(void)loadMoreData{
    if (pageNo * pageSize < count) {
        pageNo += 1;
        [self jiekou:Dic];
        [_TableView.mj_footer endRefreshing];
    }else{
        _TableView.mj_footer.hidden =YES;
    }
}
-(void)jiekou:(NSDictionary *)dic{
    NSString * Method = @"/attend/consulList";
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    //
    NSString *officeId ;
    if ( [[Dic objectForKey:@"officeName"] objectForKey:@"id"] ==nil || NULL == [[Dic objectForKey:@"officeName"] objectForKey:@"id"] ||[ [[Dic objectForKey:@"officeName"] objectForKey:@"id"]  isEqual:[NSNull null]]) {
        officeId =@"";
    }else{
        officeId = [[Dic objectForKey:@"officeName"] objectForKey:@"id"];
    }
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
    NSString *consulType ;
    if ( [Dic objectForKey:@"consulType"] ==nil || NULL == [Dic objectForKey:@"consulType"] ||[[Dic objectForKey:@"consulType"] isEqual:[NSNull null]]) {
        consulType =@"";
    }else{
        if ([[Dic objectForKey:@"consulType"]  isEqual: @"全部"]) {
            consulType = @"";
        }else if ([[Dic objectForKey:@"consulType"]  isEqual: @"岗位"]) {
            consulType = @"1";
        }else if ([[Dic objectForKey:@"consulType"]  isEqual: @"请假"]) {
            consulType = @"2";
        }else if ([[Dic objectForKey:@"consulType"]  isEqual: @"其他"]) {
            consulType = @"3";
        }
//        consulType =[Dic objectForKey:@"consulType"];
    }
    //
    NSString *reportState;
    if ( [Dic objectForKey:@"reportState"] ==nil || NULL == [Dic objectForKey:@"reportState"] ||[[Dic objectForKey:@"reportState"] isEqual:[NSNull null]]) {
        reportState =@"";
    }else{
        if ([[Dic objectForKey:@"reportState"] isEqual:@"全部"]) {
            reportState = @"";
        }else if ([[Dic objectForKey:@"reportState"] isEqual:@"已回复"]){
            reportState = @"1";
        }else if ([[Dic objectForKey:@"reportState"] isEqual:@"未回复"]){
            reportState = @"2";
        }
//        reportState =[Dic objectForKey:@"reportState"];
    }
    //
    NSString *consulStartTime;
    if ( [Dic objectForKey:@"handleStrTime"] ==nil || NULL == [Dic objectForKey:@"handleStrTime"] ||[[Dic objectForKey:@"handleStrTime"] isEqual:[NSNull null]]) {
        consulStartTime =@"";
    }else{
        consulStartTime =[Dic objectForKey:@"handleStrTime"];
    }
    //
    NSString *consulEndTime ;
    if ( [Dic objectForKey:@"handleEndTime"] ==nil || NULL == [Dic objectForKey:@"handleEndTime"] ||[[Dic objectForKey:@"handleEndTime"] isEqual:[NSNull null]]) {
        consulEndTime =@"";
    }else{
        consulEndTime =[Dic objectForKey:@"handleEndTime"];
    };
    //attendanceDate   周期
    NSString *consulDate;
    if ( [Dic objectForKey:@"attendanceDate"] ==nil || NULL == [Dic objectForKey:@"attendanceDate"] ||[[Dic objectForKey:@"attendanceDate"] isEqual:[NSNull null]]) {
        consulDate =@"";
    }else{
        if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"全部"]) {
            consulDate =@"";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前周"]) {
            consulDate =@"1";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前月"]) {
            consulDate =@"2";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前半年"]) {
            consulDate =@"3";
        }else if ([[Dic objectForKey:@"attendanceDate"]  isEqual: @"当前年"]) {
            consulDate =@"4";
        }
//        consulDate =[Dic objectForKey:@"attendanceDate"];
    }
    NSNumber *_pageNo = [NSNumber numberWithInt:pageNo];
    NSNumber *_pageSize = [NSNumber numberWithInt:pageSize];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",_pageNo,@"pageNo",_pageSize,@"pageSize",officeId,@"officeId",professionId,@"professionId",classId,@"classId",consulType,@"consulType",reportState,@"reportState",consulStartTime,@"consulStartTime",consulEndTime,@"consulEndTime",consulDate,@"consulDate",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"24.    教师咨询列表\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            [consulList addObjectsFromArray:[data objectForKey:@"consulList"]];
            count = [[data objectForKey:@"count"] intValue];
            if (consulList.count == 0) {
                _TableView.hidden =YES;
                imageview.hidden = NO;
            }else{
                _TableView.hidden =NO;
                imageview.hidden = YES;
                [_TableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark -----TableViewDelegate
-(void)TableViewDelegate{
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    self.TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    imageview.image =[UIImage imageNamed:@"试题背景"];
    [self.view addSubview:imageview];
    imageview.hidden = YES;
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
    NameString = [consulList[indexPath.section] objectForKey:@"nick"];
    NSString *guo =[consulList[indexPath.section] objectForKey:@"consulTime"];
    NSArray * guoArr =[guo componentsSeparatedByString:@" "];
    YerMonthString = guoArr[0];
//    TypeString =[consulList[indexPath.section] objectForKey:@""];
    //判断咨询类型
    if ([[consulList[indexPath.section] objectForKey:@"consulType"]  isEqual: @"1"]) {
        TypeString = @"岗位";
        Type.backgroundColor = [UIColor colorWithHexString:@"0ee6c8"];
    }
    else if ([[consulList[indexPath.section] objectForKey:@"consulType"] isEqualToString:@"2"]){
        TypeString = @"请假";
        Type.backgroundColor = [UIColor colorWithHexString:@"fa9463"];
    }
    else if ([[consulList[indexPath.section] objectForKey:@"consulType"] isEqual:@"3"]){
        TypeString = @"其他";
        Type.backgroundColor = [UIColor colorWithHexString:@"ffca27"];
    }
    //判断回复
    if ([[consulList[indexPath.section] objectForKey:@"reportState"] isEqual: @"1"]) {
        StateString = @"已回复";
    }else if ([[consulList[indexPath.section] objectForKey:@"reportState"] isEqual: @"2"]){
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
    return consulList.count;
}
#pragma mark -----跳页方法
-(void)TiaoZhuan:(NSIndexPath *)indexPath{
    /*数据处理*/
    NSString * ID = [consulList[indexPath.section] objectForKey:@"consulId"];
    int Lala =[[consulList[indexPath.section] objectForKey:@"reportState"] intValue];
    /*TabBar 隐藏*/
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    ZiXunXiangQing_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"zixunxiangqing"];
    /*数据传输*/
    Kao.Ablock = ^(int dic) {
        panP = dic;
    };
    Kao.ID=ID;
    Kao.Lala = Lala;
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
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    ShaiXuan_ViewController * Shai = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shaixuan"];
    Shai.YeShai = 2;
    Shai.block = ^(NSDictionary *dic) {
        Dic = [NSDictionary dictionaryWithDictionary:dic];
        consulList = [NSMutableArray array];
        pageNo = 1;
        _TableView.mj_footer.hidden =NO;
        [self jiekou:Dic];
    };
    [self.navigationController pushViewController:Shai animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
@end
