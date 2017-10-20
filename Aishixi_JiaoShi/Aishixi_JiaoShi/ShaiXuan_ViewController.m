//
//  ShaiXuan_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/10/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "ShaiXuan_ViewController.h"
#import "XL_TouWenJian.h"

@interface ShaiXuan_ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    //       教学单位。      专业。         班级。       机构人员。
    NSArray *officeList,*professionList,*classList,*userList,*jiemianArr;
    int hang;
    UILabel *zuobian,*youbian;
    NSMutableDictionary * dic;
    NSArray *arrKao,*arrzhou;
}

@end

@implementation ShaiXuan_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    officeList = [[NSArray alloc] init];
    professionList = [[NSArray alloc] init];
    classList = [[NSArray alloc] init];
    userList = [[NSArray alloc] init];
    dic =[[NSMutableDictionary alloc] init];
    [self Delegate];
    [self jiemian];
    [self JieKou];
    
//    self.block(dic);
//    [self.navigationController popViewControllerAnimated:NO];
//    [self tan:officeList Key:@"officeName" Lable:_JiaoXueDanWei];
}
-(void)jiemian{
    jiemianArr = [NSArray array];
    switch (_YeShai) {
        case 1:
            jiemianArr = [NSArray arrayWithObjects:@"所属教学单位",@"所属院系",@"所属班级",@"考勤状态",@"起始时间",@"结束时间",@"时间周期", nil];
            hang=8;
            break;
        case 2:
            jiemianArr = [NSArray arrayWithObjects:@"所属教学单位",@"所属院系",@"所属班级",@"咨询类型",@"回复状态",@"起始时间",@"结束时间",@"时间周期", nil];
            hang=9;
            break;
        case 3:
            jiemianArr = [NSArray arrayWithObjects:@"公告级别",@"起始时间",@"结束时间",@"时间周期", nil];
            hang=5;
            break;
        case 4:
            jiemianArr = [NSArray arrayWithObjects:@"所属教学单位",@"所属院系",@"所属班级",@"处理状态",@"起始时间",@"结束时间",@"时间周期", nil];
            hang=8;
            break;
        default:
            break;
    }
}
-(void)Delegate{
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(void)JieKou{
    NSString * Method = @"/attend/choice";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"5",@"userId",nil];
    [WarningBox warningBoxModeIndeterminate:@"数据连接中..." andView:self.view];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        NSLog(@"21 教师筛选\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            officeList = [data objectForKey:@"officeList"];
            professionList = [data objectForKey:@"professionList"];
            classList = [data objectForKey:@"classList"];
            userList = [data objectForKey:@"userList"];
            [_TableView reloadData];
        }else{
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Shaicell = @"xuancell";
    UITableViewCell *cell = [_TableView dequeueReusableCellWithIdentifier:Shaicell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Shaicell];
    }
    zuobian = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 120, 30)];
    youbian = [[UILabel alloc] initWithFrame:CGRectMake(Width-246, 8, 200, 30)];
    youbian.textAlignment = NSTextAlignmentRight;
    youbian.textColor = [UIColor colorWithHexString:@"c2ceca"];
    if (indexPath.section < hang-1) {
        zuobian.text = jiemianArr[indexPath.section];
        youbian.text = @"请选择";
        [cell addSubview:zuobian];
        [cell addSubview:youbian];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == hang - 1){
        UILabel *bbb = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, Width-48, 44)];
        bbb.text = @"查询";
        bbb.textColor = [UIColor whiteColor];
        bbb.textAlignment = NSTextAlignmentCenter;
        bbb.font = [UIFont systemFontOfSize:18];
        bbb.backgroundColor = [ UIColor colorWithHexString:@"68a1f9"];
        bbb.layer.cornerRadius = 20 ;
        bbb.layer.masksToBounds = YES;
        [cell addSubview:bbb];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return hang;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[_TableView dequeueReusableCellWithIdentifier:@"xuancell"];
    UILabel * lable = [cell viewWithTag:501];
    if (_YeShai ==1) {
        switch (indexPath.section) {
            case 0:
                [self tan:officeList Key:@"officeName" Lable:lable];
                break;
            case 1:
                [self tan:officeList Key:@"officeName" Lable:lable];
                break;
            case 2:
                [self tan:officeList Key:@"officeName" Lable:lable];
                break;
            case 3:
                [self tan:officeList Key:@"officeName" Lable:lable];
                break;
            case 4:
                [self tan:officeList Key:@"officeName" Lable:lable];
                break;
            case 5:
                [self tan:officeList Key:@"officeName" Lable:lable];
                break;
            case 6:
                [self tan:officeList Key:@"officeName" Lable:lable];
                break;
                
            default:
                break;
        }
    }
    
}
-(void)tan:(NSArray *)Shu Key:(NSString*)Key Lable:(UILabel *)Lable{
        UIAlertController * alert = [[UIAlertController alloc] init];
        for (int i = 0; i < Shu.count; i++) {
            NSUInteger index=i;
            NSString * biaotou=[Shu[index]objectForKey:@"ruleName"];
            UIAlertAction * action = [UIAlertAction actionWithTitle:biaotou style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                Lable.text=[Shu[index] objectForKey:Key];
            }];
            [alert addAction:action];
        }
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
}
@end
