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
}

@end

@implementation JinJi_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDelegate];
    count = 0;
    pageSize = 5;
    pageNo = 1;
    Dic=[NSDictionary dictionary];
    sosList = [[NSMutableArray alloc] init];
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self JieKou];
}
-(void)loadNewData{
    sosList = [[NSMutableArray alloc] init];
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
    NSString * method = @"/teacher/sosList";
    //请求页数
    NSNumber* _pageNo =[NSNumber numberWithInt:pageNo];
    //请求条数
    NSNumber* _pageSize =[NSNumber numberWithInt:pageSize];
    //用户Id
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    //所属单位
    NSString * officeId =@"";
    //专业
    NSString * professionId =@"";
    //班级
    NSString * classId =@"";
    //选 年、月、周 的标识
    NSString * createDate =@"";
    //开始时间
    NSString * startTime =@"";
    //结束时间
    NSString * endTime =@"";
    
    NSDictionary * Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_pageNo,@"pageNo",_pageSize,@"pageSize",userId,@"userId",officeId,@"officeId",professionId,@"professionId",classId,@"classId",createDate,@"createDate",startTime,@"startTime",endTime,@"endTime", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            NSDictionary * data =[responseObject objectForKey:@"data"];
            NSArray * aa=[data objectForKey:@"sosList"];
            [sosList addObjectsFromArray:aa];
            count = [[data objectForKey:@"count"] intValue];
            NSLog(@"----%@,---%d",sosList,count);
            
            [_TableView reloadData];
        }
    } failure:^(NSError *error) {
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
        }else if ([[sosList[indexPath.section] objectForKey:@"handleState"]  isEqual: @"2"]){
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
    
    [self.navigationController pushViewController:Kao animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)ShaixuanButton:(id)sender {
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    ShaiXuan_ViewController * Shai = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shaixuan"];
    Shai.YeShai = 4;
    Shai.block = ^(NSDictionary *dic) {
        Dic = [NSDictionary dictionaryWithDictionary:dic];
        [self JieKou];
    };
    [self.navigationController pushViewController:Shai animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
@end
