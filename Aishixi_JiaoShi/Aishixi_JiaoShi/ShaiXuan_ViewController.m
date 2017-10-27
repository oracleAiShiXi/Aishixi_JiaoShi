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
    //       教学单位。      专业。         班级。      机构人员。 界面显示
    NSArray *officeList,*professionList,*classList,*userList,*jiemianArr,*biaotou;
    NSMutableArray * yuanErji,*banErji;
    int hang;
    UILabel *zuobian,*youbian;
    NSMutableDictionary * dic;
    NSMutableDictionary * youDic;
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
    yuanErji = [[NSMutableArray alloc] init];
    banErji = [[NSMutableArray alloc] init];
    dic = [[NSMutableDictionary alloc] init];
    youDic = [[NSMutableDictionary alloc] init];
    biaotou = [NSArray arrayWithObjects:@"教学单位选择",@"院系选择",@"班级选择",@"人员选择", nil];
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
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",nil];
    [WarningBox warningBoxModeIndeterminate:@"数据连接中..." andView:self.view];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        NSLog(@"21 教师筛选\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            //教学
            officeList = [data objectForKey:@"officeList"];
            //院系
            professionList = [data objectForKey:@"professionList"];
            //班级
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
        if (NULL == [youDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]) {
            youbian.text = @"请选择";
        }else{
            youbian.text =[youDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        }
        
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
    NSLog(@"%ld",(long)indexPath.section);
    if (_YeShai ==1) {
        if (indexPath.section == 0) {
            [self tan:officeList Key:@"officeName" :@"0" Lable:youbian];
        }else if (indexPath.section == 1){
            [self tan:yuanErji Key:@"professionName" :@"1" Lable:youbian];
        }else if (indexPath.section == 2){
            [self tan:banErji Key:@"className" :@"2" Lable:youbian];
        }else if (indexPath.section == 3){
            
        }else if (indexPath.section == 4){
            
        }else if (indexPath.section == 5){
            
        }else if (indexPath.section == 6){
            
        }else if (indexPath.section == 7){
            self.block(dic);
            [self.navigationController popViewControllerAnimated:NO];
        }
        //        switch (indexPath.section) {
        //            case 0:
        //                [self tan:officeList Key:@"officeName" Lable:youbian];
        //                break;
        //            case 1:
        //                [self tan:officeList Key:@"officeName" Lable:youbian];
        //                break;
        //            case 2:
        //                [self tan:officeList Key:@"officeName" Lable:youbian];
        //                break;
        //            case 3:
        //                [self tan:officeList Key:@"officeName" Lable:youbian];
        //                break;
        //            case 4:
        //                [self tan:officeList Key:@"officeName" Lable:youbian];
        //                break;
        //            case 5:
        //                [self tan:officeList Key:@"officeName" Lable:youbian];
        //                break;
        //            case 6:
        //                [self tan:officeList Key:@"officeName" Lable:youbian];
        //                break;
        //            case 7:
        //                self.block(dic);
        //                [self.navigationController popViewControllerAnimated:NO];
        //                break;
        //            default:
        //                break;
        //        }
    }
    
}
-(void)tan:(NSArray *)Shu Key:(NSString*)Key :(NSString *)cun Lable:(UILabel *)Lable{
    if (_YeShai == 1 || _YeShai == 2 || _YeShai == 4) {
        if (([cun  isEqual:@"1"]&&([youDic objectForKey:@"0"]==nil ||[ [youDic objectForKey:@"0"]  isEqual:[NSNull null]] ||NULL == [youDic objectForKey:@"0"])) || ([cun  isEqual:@"2"]&&([youDic objectForKey:@"1"]==nil ||[ [youDic objectForKey:@"1"]  isEqual:[NSNull null]] ||NULL == [youDic objectForKey:@"1"]))) {
            [WarningBox warningBoxModeText:@"请先选择上级机构" andView:self.view];
        }else{
            [self fangfa:Shu Key:Key :cun Lable:Lable];
        }
    }else{
        [self fangfa:Shu Key:Key :cun Lable:Lable];
    }
   
   
}
-(void)fangfa:(NSArray *)Shu Key:(NSString*)Key :(NSString *)cun Lable:(UILabel *)Lable{
    UIAlertController * alert = [[UIAlertController alloc] init];
    for (int i = 0; i < Shu.count; i++) {
        NSUInteger index=i;
        NSString * biaotou=[Shu[index] objectForKey:Key];
        UIAlertAction * action = [UIAlertAction actionWithTitle:biaotou style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (_YeShai == 1 || _YeShai == 2 || _YeShai == 4) {
                if ([cun  isEqual: @"1"]) {
                    for (int i =0; i<professionList.count; i++) {
                        if ([[professionList[i] objectForKey:@"officeId"] isEqual:[Shu[index] objectForKey:@"id"]]) {
                            [yuanErji addObject:professionList[i]];
                        }
                    }
                }else if ([cun  isEqual: @"2"]) {
                    for (int i =0; i<classList.count; i++) {
                        if ([[classList[i] objectForKey:@"professionId"] isEqual:[Shu[index] objectForKey:@"professionId"]]) {
                            [banErji addObject:classList[i]];
                        }
                    }
                }
            }
            Lable.text=[Shu[index] objectForKey:Key];
            NSLog(@"%@",Lable.text);
            [dic setObject:Shu[index] forKey:[NSString stringWithFormat:@"%@",Key]];
            [youDic setObject:Lable.text forKey:cun];
            NSLog(@"%@",dic);
        }];
        [alert addAction:action];
    }
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}
@end
