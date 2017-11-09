//
//  ShaiXuan_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/10/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "ShaiXuan_ViewController.h"
#import "XL_TouWenJian.h"
#import "XLDateCompare.h"

@interface ShaiXuan_ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    //       教学单位。      专业。         班级。      机构人员。 界面显示
    NSArray *officeList,*professionList,*classList,*userList,*jiemianArr,*biaotou;
    NSMutableArray * yuanErji,*banErji;
    int hang;
    UILabel *zuobian,*youbian;
    NSMutableDictionary * dic;
    NSMutableDictionary * youDic;
    NSArray *arrKao,*arrzhou;
    NSArray*kaozhuangArr,*shizhouArr;
    NSArray * zixunArr,*huifuArr;
    NSArray * gongArr;
    NSArray * chuArr;
    int kaijie;
    UIView *backview;
}
@property (nonatomic ,strong) UIDatePicker*picker;
@end

@implementation ShaiXuan_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kaijie =0;
    [self BeiJing];
    officeList = [[NSArray alloc] init];
    professionList = [[NSArray alloc] init];
    classList = [[NSArray alloc] init];
    userList = [[NSArray alloc] init];
    yuanErji = [[NSMutableArray alloc] init];
    banErji = [[NSMutableArray alloc] init];
    chuArr = [NSArray arrayWithObjects:@"全部",@"已处理",@"处理中",@"未处理", nil];
    gongArr = [NSArray arrayWithObjects:@"全部",@"重要",@"普通", nil];
    zixunArr = [NSArray arrayWithObjects:@"全部",@"岗位",@"请假",@"其他", nil];
    huifuArr = [NSArray arrayWithObjects:@"全部",@"已回复",@"未回复", nil];
    dic = [[NSMutableDictionary alloc] init];
    youDic = [[NSMutableDictionary alloc] init];
    kaozhuangArr = [NSArray arrayWithObjects:@"全部",@"正常",@"异常",nil];
    shizhouArr = [NSArray arrayWithObjects:@"全部",@"当前周",@"当前月",@"当前半年",@"当前年", nil];
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
            jiemianArr = [NSArray arrayWithObjects:@"所属院系",@"所属专业",@"所属班级",@"考勤状态",@"起始时间",@"结束时间",@"时间周期", nil];
            hang=8;
            break;
        case 2:
            jiemianArr = [NSArray arrayWithObjects:@"所属院系",@"所属专业",@"所属班级",@"咨询类型",@"回复状态",@"起始时间",@"结束时间",@"时间周期", nil];
            hang=9;
            break;
        case 3:
            jiemianArr = [NSArray arrayWithObjects:@"公告级别",@"起始时间",@"结束时间",@"时间周期", nil];
            hang=5;
            break;
        case 4:
            jiemianArr = [NSArray arrayWithObjects:@"所属院系",@"所属专业",@"所属班级",@"处理状态",@"起始时间",@"结束时间",@"时间周期", nil];
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
    [WarningBox warningBoxModeText:@"数据加载中..." andView:self.view];
    NSString * Method = @"/attend/choice";
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",nil];
    [WarningBox warningBoxModeIndeterminate:@"数据连接中..." andView:self.view];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
//        NSLog(@"21 教师筛选\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            [WarningBox warningBoxHide:YES andView:self.view];
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
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！请检查网络！" andView:self.view];
//        NSLog(@"%@",error);
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Shaicell = @"xuancell";
    UITableViewCell *cell = [_TableView dequeueReusableCellWithIdentifier:Shaicell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Shaicell];
    }
//    for (UIView *vv in cell.contentView) {
//
//    }
    for (UIView *vv in cell.subviews) {//获取当前cell的全部子视图
        [vv removeFromSuperview];
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
//    NSLog(@"%ld",(long)indexPath.section);
    if (_YeShai ==1) {
        if (indexPath.section == 0) {
            [self tan:officeList Key:@"officeName" :@"0" Lable:youbian];
        }else if (indexPath.section == 1){
            [self tan:yuanErji Key:@"professionName" :@"1" Lable:youbian];
        }else if (indexPath.section == 2){
            [self tan:banErji Key:@"className" :@"2" Lable:youbian];
        }else if (indexPath.section == 3){
            [self kaozhuang:kaozhuangArr Key:@"attendanceType" :@"3" Lable:youbian];
        }else if (indexPath.section == 4){
            kaijie = 1;
            [self shijianxuanze];
        }else if (indexPath.section == 5){
            kaijie = 2;
            [self shijianxuanze];
        }else if (indexPath.section == 6){
            [self kaozhuang:shizhouArr Key:@"attendanceDate" :@"6" Lable:youbian];
        }else if (indexPath.section == 7){
            self.block(dic);
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else if (_YeShai ==2) {
        if (indexPath.section == 0) {
            [self tan:officeList Key:@"officeName" :@"0" Lable:youbian];
        }else if (indexPath.section == 1){
            [self tan:yuanErji Key:@"professionName" :@"1" Lable:youbian];
        }else if (indexPath.section == 2){
            [self tan:banErji Key:@"className" :@"2" Lable:youbian];
        }else if (indexPath.section == 3){
            [self kaozhuang:zixunArr Key:@"consulType" :@"3" Lable:youbian];
        }else if (indexPath.section == 4){
            [self kaozhuang:huifuArr Key:@"reportState" :@"4" Lable:youbian];
        }else if (indexPath.section == 5){
            kaijie = 1;
            [self shijianxuanze];
        }else if (indexPath.section == 6){
            kaijie = 2;
            [self shijianxuanze];
        }else if (indexPath.section == 7){
            [self kaozhuang:shizhouArr Key:@"attendanceDate" :@"7" Lable:youbian];
        }else if (indexPath.section == 8){
            self.block(dic);
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else if (_YeShai ==3) {
        if (indexPath.section == 0) {
            [self kaozhuang:gongArr Key:@"level" :@"0" Lable:youbian];
        }else if (indexPath.section == 1){
            kaijie = 1;
            [self shijianxuanze];
        }else if (indexPath.section == 2){
            kaijie = 2;
            [self shijianxuanze];
        }else if (indexPath.section == 3){
            [self kaozhuang:shizhouArr Key:@"attendanceDate" :@"3" Lable:youbian];
        }else if (indexPath.section == 4){
            self.block(dic);
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else if (_YeShai ==4) {
        if (indexPath.section == 0) {
            [self tan:officeList Key:@"officeName" :@"0" Lable:youbian];
        }else if (indexPath.section == 1){
            [self tan:yuanErji Key:@"professionName" :@"1" Lable:youbian];
        }else if (indexPath.section == 2){
            [self tan:banErji Key:@"className" :@"2" Lable:youbian];
        }else if (indexPath.section == 3){
            [self kaozhuang:chuArr Key:@"handleState" :@"3" Lable:youbian];
        }else if (indexPath.section == 4){
            kaijie = 1;
            [self shijianxuanze];
        }else if (indexPath.section == 5){
            kaijie = 2;
            [self shijianxuanze];
        }else if (indexPath.section == 6){
            [self kaozhuang:shizhouArr Key:@"attendanceDate" :@"6" Lable:youbian];
        }else if (indexPath.section == 7){
            self.block(dic);
            [self.navigationController popViewControllerAnimated:NO];
        }
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
-(void)kaozhuang:(NSArray *)Shu Key:(NSString*)Key :(NSString *)cun Lable:(UILabel *)Lable{
    UIAlertController * alert = [[UIAlertController alloc] init];
    for (int i = 0; i < Shu.count; i++) {
        NSUInteger index=i;
        NSString * biaotou=Shu[index];
        UIAlertAction * action = [UIAlertAction actionWithTitle:biaotou style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            Lable.text=Shu[index];
            [dic setObject:Shu[index] forKey:[NSString stringWithFormat:@"%@",Key]];
            [youDic setObject:Lable.text forKey:cun];
            [_TableView reloadData];
        }];
        [alert addAction:action];
    }
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}
-(void)fangfa:(NSArray *)Shu Key:(NSString*)Key :(NSString *)cun Lable:(UILabel *)Lable{
    UIAlertController * alert = [[UIAlertController alloc] init];
    for (int i = 0; i < Shu.count; i++) {
        NSUInteger index=i;
        NSString * biaotou=[Shu[index] objectForKey:Key];
        UIAlertAction * action = [UIAlertAction actionWithTitle:biaotou style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (_YeShai == 1 || _YeShai == 2 || _YeShai == 4) {
                if ([cun  isEqual: @"0"]) {
                    for (int i =0; i<professionList.count; i++) {
                        if ([[professionList[i] objectForKey:@"officeId"] isEqual:[Shu[index] objectForKey:@"id"]]) {
                            [yuanErji addObject:professionList[i]];
                        }
                    }
                }else if ([cun  isEqual: @"1"]) {
                    for (int i =0; i<classList.count; i++) {
                        if ([[classList[i] objectForKey:@"professionId"] isEqual:[Shu[index] objectForKey:@"professionId"]]) {
                            [banErji addObject:classList[i]];
                        }
                    }
                }
            }
            Lable.text=[Shu[index] objectForKey:Key];
            [dic setObject:Shu[index] forKey:[NSString stringWithFormat:@"%@",Key]];
            [youDic setObject:Lable.text forKey:cun];
            [_TableView reloadData];
        }];
        [alert addAction:action];
    }
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}
-(void)BeiJing{
    backview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    backview.backgroundColor=[UIColor clearColor];
    UITapGestureRecognizer *ss =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiaoshi)];
    [backview addGestureRecognizer:ss];
    backview.hidden=YES;
    [self.view addSubview:backview];
}
-(void)shijianxuanze{
    backview.hidden =NO;
    UIView * hh = [[UIView alloc] initWithFrame:CGRectMake(0, Height-260, Width, 260)];
    hh.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [backview addSubview:hh];
    UIButton * queding =[[UIButton alloc] initWithFrame:CGRectMake(Width-100, 5, 80, 30)];
    queding.backgroundColor=[UIColor colorWithHexString:@"6ca3fd"];
    [queding setTintColor:[UIColor whiteColor]];
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchDragInside];
    queding.layer.cornerRadius = 5;
    [hh addSubview:queding];
    _picker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, Width, 230)];
    _picker.contentMode=UIViewContentModeCenter;
    _picker.datePickerMode=UIDatePickerModeDateAndTime;
    [hh addSubview:_picker];
}
-(void)queding{
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *selected = [_picker date];
    // 创建一个日期格式器
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc] init];
    
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    NSString *message =[NSString stringWithFormat:@"%@", destDateString];
    
    //    NSDate *date = [NSDate date];
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    [dateForm setDateFormat:@"yyyy-MM-dd HH:mm"];
    //    NSString *nowdate =[dateForm stringFromDate:date];
    
    if (kaijie == 1) {
        
        [dic setObject:message forKey:@"handleStrTime"];
        if (_YeShai == 1 || _YeShai == 4) {
            [youDic setObject:message forKey:@"4"];
        }else if (_YeShai == 2){
            [youDic setObject:message forKey:@"5"];
        }else if (_YeShai == 3){
            [youDic setObject:message forKey:@"1"];
        }
        [_TableView reloadData];
        backview.hidden = YES;
    }else if (kaijie == 2){
        int iii = [XLDateCompare compareDate:message withDate:[dic objectForKey:@"handleStrTime"]];
        if (iii == -1) {
            [dic setObject:message forKey:@"handleEndTime"];
            if (_YeShai == 1 || _YeShai == 4) {
                [youDic setObject:message forKey:@"5"];
            }else if (_YeShai == 2){
                [youDic setObject:message forKey:@"6"];
            }else if (_YeShai == 3){
                [youDic setObject:message forKey:@"2"];
            }
            backview.hidden = YES;
        }else{
            [WarningBox warningBoxModeText:@"结束时间要大于开始时间" andView:self.view];
        }
        [_TableView reloadData];
    }
    
}
-(void)xiaoshi{
    backview.hidden = YES;
}
@end
