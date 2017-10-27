//
//  PingJia_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/25.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "PingJia_ViewController.h"
#import "PingJiaXiangQing_ViewController.h"
#import "XL_TouWenJian.h"

@interface PingJia_ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    int  pageNo,pageSize,count;
    NSMutableArray *studentList;
}

@end

@implementation PingJia_ViewController

-(void)viewWillAppear:(BOOL)animated{
    studentList = [NSMutableArray array];
    [self jiekou];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"评价";
    count = 0;
    pageSize = 5;
    pageNo = 1;
    [self delegate];
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
-(void)loadNewData{
    studentList = [NSMutableArray array];
    pageNo = 1;
    [self jiekou];
    [_TableView.mj_header endRefreshing];
    self.TableView.mj_footer.hidden = NO;
}
-(void)loadMoreData{
    if (pageNo * pageSize >= count) {
        self.TableView.mj_footer.hidden = YES;
    }else{
        pageNo += 1;
        [self jiekou];
        [_TableView.mj_footer endRefreshing];
    }
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
    NameString = [studentList[indexPath.section] objectForKey:@"nick"];
    int typ = [[studentList[indexPath.section] objectForKey:@"evaluateStatus"] intValue];
    if (typ == 1) {
        TpyeString = @"已评价";
        Tpye.textColor = [UIColor colorWithHexString:@"8ed4ff"];
    }else{
        TpyeString = @"未评价";
        Tpye.textColor = [UIColor colorWithHexString:@"fe5a6e"];
    }
    
    TouXiang.image = image;
    Name.text =NameString;
    Tpye.text = TpyeString;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    return studentList.count;
}
-(void)TiaoYe:(NSIndexPath *)indexPath{
    PingJiaXiangQing_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pingjiaxiangqing"];
    /*数据传输*/
    Kao.studentId = [studentList[indexPath.section] objectForKey:@"userId"];
    [self.navigationController pushViewController:Kao animated:YES];
}
-(void)jiekou{
    NSString * Method = @"/teacher/getStudentList";
    //用户Id
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",@"1",@"pageNo",@"10",@"pageSize",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"32.    教师评价-获取学生列表\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            NSDictionary * data =[responseObject objectForKey:@"data"];
            NSArray * aa=[data objectForKey:@"studentList"];
            [studentList addObjectsFromArray:aa];
            count = [[data objectForKey:@"count"] intValue];
            [_TableView reloadData];
        }
       
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
