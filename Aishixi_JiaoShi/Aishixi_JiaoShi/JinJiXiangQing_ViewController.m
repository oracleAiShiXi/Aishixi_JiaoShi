
//
//  JinJiXiangQing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "JinJiXiangQing_ViewController.h"
#import "XLDateCompare.h"
#import "XL_TouWenJian.h"

@interface JinJiXiangQing_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    UITextView * TV;
    
    UILabel * kaishi,*jieshu;
    NSMutableDictionary * data;
    UIView *backview;//时间选择器背景;
    int kaijie;//外出返回时间选择器判断;
    int cellshu;

}
@property (nonatomic ,strong) UIDatePicker*picker;
@end

@implementation JinJiXiangQing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"呼叫详情";
    _table.delegate =self;
    _table.dataSource =self;
    cellshu=0;
    kaijie=0;
    NSLog(@"%@",_sosId);
    [self jiazai_jiekou];
    [self BeiJing];
    [self KeyboardJianTing];
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
        
        [data setObject:message forKey:@"handleStrTime"];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [_table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        backview.hidden = YES;
    }else if (kaijie == 2){
        int iii = [XLDateCompare compareDate:message withDate:[data objectForKey:@"handleStrTime"]];
        if (iii == -1) {
            [data setObject:message forKey:@"handleEndTime"];
            
            backview.hidden = YES;
            
            
        }else{
            [WarningBox warningBoxModeText:@"结束时间要大于开始时间" andView:self.view];
        }
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
        [_table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
}
-(void)xiaoshi{
    backview.hidden = YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (cellshu == 1) {
        return 5;
    }
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 456;
    }
    else if (indexPath.section==3){
        return 150;
    }else{
        return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }else{
        return 10;
    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 4;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
         static NSString * cellString = @"cell1";
         UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
         if(cell==nil){
           cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        UILabel * Name = [cell viewWithTag:600];
        UILabel * XueHao = [cell viewWithTag:601];
        UILabel * XueJie = [cell viewWithTag:602];
        UILabel * YuanXi = [cell viewWithTag:603];
        UILabel * ZhuanYe = [cell viewWithTag:604];
        UILabel * BanJi = [cell viewWithTag:605];
        UILabel * HuShi = [cell viewWithTag:606];
        UILabel * JingW = [cell viewWithTag:607];
        UILabel * WeiZhi = [cell viewWithTag:608];
        UILabel * NeiRong = [cell viewWithTag:609];
        UILabel * ChuLi = [cell viewWithTag:610];
        Name.text = [data objectForKey:@"studentName"];
        Name.adjustsFontSizeToFitWidth = YES;
        XueHao.text = [data objectForKey:@"studentNumber"];
        XueHao.adjustsFontSizeToFitWidth = YES;
        XueJie.text = [data objectForKey:@"classPeriod"];
        XueJie.adjustsFontSizeToFitWidth = YES;
        YuanXi.text = [data objectForKey:@"officeName"];
        YuanXi.adjustsFontSizeToFitWidth = YES;
        ZhuanYe.text = [data objectForKey:@"professionName"];
        ZhuanYe.adjustsFontSizeToFitWidth = YES;
        BanJi.text = [data objectForKey:@"className"];
        BanJi.adjustsFontSizeToFitWidth = YES;
        HuShi.text = [NSString stringWithFormat:@"呼叫时间:%@",[data objectForKey:@"createDate"]];
        JingW.text = [NSString stringWithFormat:@"经度纬度:%@",[data objectForKey:@"latlongitude"]];
        WeiZhi.text = [NSString stringWithFormat:@"地理位置:%@",[data objectForKey:@"sosLocation"]];
        NeiRong.text = [data objectForKey:@"sosContent"];
        NeiRong.textColor = [UIColor colorWithHexString:@"354DF0"];
        if ([[data objectForKey:@"handleState"]  isEqual: @"1"]) {
            ChuLi.text = @"已处理";
            ChuLi.textColor = [UIColor colorWithHexString:@"74e471"];
        }else{
            ChuLi.text = @"未处理";
            ChuLi.textColor = [UIColor colorWithHexString:@"fe8192"];
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.backgroundColor =[UIColor clearColor];
        return cell;
    }else if (indexPath.section==1){
        static NSString * cellString = @"cell2";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
      
        kaishi = [cell viewWithTag:611];
        kaishi.text = [data objectForKey:@"handleStrTime"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==2){
        static NSString * cellString = @"cell3";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
         jieshu = [cell viewWithTag:612];
        jieshu.text = [data objectForKey:@"handleEndTime"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==3){
        static NSString * cellString = @"cell4";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
       
        TV =[cell viewWithTag:613];
        TV.delegate = self;
        NSString * guo =[data objectForKey:@"handleContent"];
        if (guo.length != 0) {
            TV.text = guo;
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==4){
        static NSString * cellString = @"cell5";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        UILabel * Ren = [cell viewWithTag:614];
        Ren.text = [data objectForKey:@"mobilePhone"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        static NSString * cellString = @"cell6";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        NSLog(@"0");
//    }
    if (cellshu != 1) {
        if (indexPath.section == 1) {
            NSLog(@"1");kaijie=1;
            [self shijianxuanze];
        }else if (indexPath.section == 2){
            NSLog(@"2");kaijie=2;
            [self shijianxuanze];
        }else if (indexPath.section == 5){
            NSLog(@"5");
            [self tijiao_jiekou];
        }else if (indexPath.section == 4){
           //拨打电话。[data objectForKey:@"mobilePhone"]
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[data objectForKey:@"mobilePhone"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (cellshu != 1) {
        return  YES;
    }
    return NO;
}
-(void)KeyboardJianTing{
    //监听键盘是否呼出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(upViews:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tapAction)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
#pragma mark - 键盘弹出时界面上移及还原
-(void)upViews:(NSNotification *) notification{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyBoardHeight = keyboardRect.size.height;
    //使视图上移
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = -keyBoardHeight;
    self.view.frame = viewFrame;
}
-(void)jiazai_jiekou{
    NSString * Method = @"/teacher/sosInfo";
    [WarningBox warningBoxModeText:@"数据加载中..." andView:self.view];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_sosId,@"sosId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"30.    教师SOS详情\n%@",responseObject);
        
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            data = [NSMutableDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"] ];
            if (![[data objectForKey:@"handleStrTime"] isEqual:@""] && ![[data objectForKey:@"handleEndTime"] isEqual:@""]) {
                cellshu = 1;
            }
            [_table reloadData];
        }
        
    } failure:^(NSError *error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！请检查网络！" andView:self.view];
        NSLog(@"%@",error);
    }];
}
-(void)tapAction{
    
    if ([TV isFirstResponder]&&UIKeyboardDidShowNotification)
    {
        [TV resignFirstResponder];
        //使视图还原
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y = 0;
        self.view.frame = viewFrame;
    }
}
-(void)tijiao_jiekou{
    
    NSString * Method = @"/teacher/handle";
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    NSString *handleContent = TV.text;
    NSString *handleStrTime = kaishi.text;
    NSString *handleEndTime = jieshu.text;
    [WarningBox warningBoxModeIndeterminate:@"处理中..." andView:self.view];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",_sosId,@"sosId",handleContent,@"handleContent",handleStrTime,@"handleStrTime",handleEndTime,@"handleEndTime",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"31.    教师SOS处理\n%@",responseObject);
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.navigationController.view];
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            [self fanhui];
        }
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！请检查网络！" andView:self.view];
        NSLog(@"%@",error);
    }];
}
-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
