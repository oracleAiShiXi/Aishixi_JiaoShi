//
//  FaBuGongGao_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "FaBuGongGao_ViewController.h"
#import "XL_TouWenJian.h"

@interface FaBuGongGao_ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextViewDelegate,UITextFieldDelegate>{
    int pan,bian,panDui;
    UITextView * tv;
    NSString*tihuan;
    NSMutableArray * xuanzezhuangtai;
    NSArray * jiaoArr,*zhuanArr,*banArr,*gouArr;
    NSMutableArray * erZhuan,*erBan;
    UITextField * GZT;
    NSString *biaotou;
    NSMutableDictionary * xueDic,*shiDic;
    
}

@end

@implementation FaBuGongGao_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布公告";
    panDui=0;pan = 0;bian = 0;tihuan = [NSString string];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    erZhuan=[NSMutableArray array];
    erBan = [NSMutableArray array];
    xueDic = [NSMutableDictionary dictionary];
    shiDic = [NSMutableDictionary dictionary];
    //    _TableView.backgroundColor = [UIColor colorWithHexString:@""];
    //    _TableView.tableHeaderView.backgroundColor = [[UIColor clearColor];
    NSString * s1 = @"所属教学单位";
    NSString * s2 = @"所属专业";
    NSString * s3 = @"所属班级";
    NSString * s4 = @"机构人员";
    xuanzezhuangtai =[NSMutableArray arrayWithObjects:s1,s2,s3,s4, nil];
    [self jiekou];
}
-(void)jiekou{
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
            jiaoArr = [data objectForKey:@"officeList"];
            //院系
            zhuanArr = [data objectForKey:@"professionList"];
            //班级
            banArr = [data objectForKey:@"classList"];
            gouArr = [data objectForKey:@"userList"];
            [_TableView reloadData];
        }else{
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(panDui == 0){
        return 8;
    }else{
        return 6;
    }
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 138;
    }
    return 46;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellString = @"hehe";
    UITableViewCell * cell =[_TableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    for (UIView * vv in cell.subviews) {
        [vv removeFromSuperview];
    }
    if (indexPath.section == 0) {
        UILabel * Zhong = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 80, 30)];
        Zhong.text=@"重要程度";
        Zhong.font=[UIFont systemFontOfSize:16];
        [cell addSubview:Zhong];
        UIButton * Yao =[[UIButton alloc] initWithFrame:CGRectMake(8 + Zhong.frame.origin.x + Zhong.frame.size.width + 8, 4, 80, 40)];
        if (pan == 0) {
            [Yao setImage:[UIImage imageNamed:@"对号2"] forState: UIControlStateNormal];
        }else{
            [Yao setImage:[UIImage imageNamed:@"对号3"] forState: UIControlStateNormal];
        }
        Yao.titleLabel.font = [UIFont systemFontOfSize:15];;
        [Yao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Yao setTitle:@"重要" forState:UIControlStateNormal];
        Yao.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
        Yao.imageEdgeInsets = UIEdgeInsetsMake(0,-2,0,2);
        [Yao addTarget:self action:@selector(DianZhong) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:Yao];
        
        UIButton * Pu =[[UIButton alloc] initWithFrame:CGRectMake(8 + Yao.frame.origin.x + Yao.frame.size.width + 8, 4, 80, 40)];
        if (pan == 0) {
            [Pu setImage:[UIImage imageNamed:@"对号3"] forState: UIControlStateNormal];
        }else{
            [Pu setImage:[UIImage imageNamed:@"对号2"] forState: UIControlStateNormal];
        }
        Pu.titleLabel.font = [UIFont systemFontOfSize:15];;
        [Pu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Pu addTarget:self action:@selector(DianZhong) forControlEvents:UIControlEventTouchUpInside];
        [Pu setTitle:@"普通" forState:UIControlStateNormal];
        Pu.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
        Pu.imageEdgeInsets = UIEdgeInsetsMake(0,-2,0,2);
        [cell addSubview:Pu];
        //        cell.backgroundColor =[UIColor clearColor];
    }else if (indexPath.section == 1){
        UILabel * Zhong = [[UILabel alloc] initWithFrame:CGRectMake(16, 4, 80, 40)];
        Zhong.text=@"发送对象";
        Zhong.font=[UIFont systemFontOfSize:16];
        [cell addSubview:Zhong];
        UIButton * Yao =[[UIButton alloc] initWithFrame:CGRectMake(8 + Zhong.frame.origin.x + Zhong.frame.size.width + 8, 4, 80, 40)];
        if (panDui == 0) {
            [Yao setImage:[UIImage imageNamed:@"对号2"] forState: UIControlStateNormal];
        }else{
            [Yao setImage:[UIImage imageNamed:@"对号3"] forState: UIControlStateNormal];
        }
        Yao.titleLabel.font = [UIFont systemFontOfSize:15];;
        [Yao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Yao setTitle:@"学生" forState:UIControlStateNormal];
        Yao.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
        Yao.imageEdgeInsets = UIEdgeInsetsMake(0,-2,0,2);
        [Yao addTarget:self action:@selector(XueSheng) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:Yao];
        
        UIButton * Pu =[[UIButton alloc] initWithFrame:CGRectMake(8 + Yao.frame.origin.x + Yao.frame.size.width + 8, 8, 80, 30)];
        if (panDui == 0) {
            [Pu setImage:[UIImage imageNamed:@"对号3"] forState: UIControlStateNormal];
        }else{
            [Pu setImage:[UIImage imageNamed:@"对号2"] forState: UIControlStateNormal];
        }
        Pu.titleLabel.font = [UIFont systemFontOfSize:15];;
        [Pu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Pu addTarget:self action:@selector(XueSheng) forControlEvents:UIControlEventTouchUpInside];
        [Pu setTitle:@"教师" forState:UIControlStateNormal];
        Pu.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
        Pu.imageEdgeInsets = UIEdgeInsetsMake(0,-2,0,2);
        [cell addSubview:Pu];
    }
    else if (indexPath.section == 2){
        GZT = [[UITextField alloc] initWithFrame:CGRectMake(8, 6, Width-32,32 )];
        GZT.delegate =self;
        GZT.placeholder = @"请输写公告主题";
        GZT.text = biaotou;
        [cell addSubview:GZT];
    }else if (indexPath.section == 3){
        tv = [[UITextView alloc] initWithFrame:CGRectMake(8, 6, Width - 32, 130)];
        tv.delegate=self;
        tv.text = tihuan;
        if (bian == 1) {
            [tv becomeFirstResponder];
        }
        [cell addSubview:tv];
        UIButton * bb = [[UIButton alloc] initWithFrame:CGRectMake(Width - 58, 88, 50, 50)];
        [bb setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
//        [bb addTarget:self action:@selector(BianJi) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:bb];
    }else if (indexPath.section == 4){
        if (panDui == 1) {
              UILabel * suo = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, Width - 120, 30)];
            suo.text = xuanzezhuangtai[3];
            UILabel * xuan = [[UILabel alloc] initWithFrame:CGRectMake(Width-250, 8, 200, 30)];
            xuan.textAlignment = NSTextAlignmentRight;
            xuan.textColor = [UIColor colorWithHexString:@"c8c8c8"];
            //加判断
            xuan.text = @"";
            [cell addSubview:xuan];
            [cell addSubview:suo];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右箭头
        }else{
              UILabel * suo = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, Width - 120, 30)];
            suo.text = xuanzezhuangtai[0];
            UILabel * xuan = [[UILabel alloc] initWithFrame:CGRectMake(Width-250, 8, 200, 30)];
            xuan.textAlignment = NSTextAlignmentRight;
            xuan.textColor = [UIColor colorWithHexString:@"c8c8c8"];
            xuan.text = [[xueDic objectForKey:@"officeName"] objectForKey:@"officeName"];
            [cell addSubview:xuan];
            [cell addSubview:suo];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右箭头
        }
    }else if (indexPath.section == 5){
        if (panDui == 0) {
            UILabel * suo = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, Width - 120, 30)];
            suo.text = xuanzezhuangtai[1];
            UILabel * xuan = [[UILabel alloc] initWithFrame:CGRectMake(Width-250, 8, 200, 30)];
            xuan.textAlignment = NSTextAlignmentRight;
            xuan.textColor = [UIColor colorWithHexString:@"c8c8c8"];
            xuan.text = [[xueDic objectForKey:@"professionName"] objectForKey:@"professionName"];
            [cell addSubview:xuan];
            [cell addSubview:suo];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右箭头
        }else{
            UILabel * la=[[UILabel alloc] initWithFrame: CGRectMake(0, 0, Width-16, 46)];
            la.text = @"发布";
            la.textAlignment = NSTextAlignmentCenter;
            la.layer.cornerRadius = 20;
            la.layer.masksToBounds = YES;
            la.backgroundColor = [ UIColor colorWithHexString:@"354DF0"];
            la.textColor = [ UIColor whiteColor];
            [cell addSubview:la];
        }
    }else if (indexPath.section == 6){
        UILabel * suo = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, Width - 120, 30)];
        suo.text = xuanzezhuangtai[2];
        UILabel * xuan = [[UILabel alloc] initWithFrame:CGRectMake(Width-250, 8, 200, 30)];
        xuan.textAlignment = NSTextAlignmentRight;
        xuan.textColor = [UIColor colorWithHexString:@"c8c8c8"];
        xuan.text = [[xueDic objectForKey:@"className"] objectForKey:@"className"];
        [cell addSubview:xuan];
        [cell addSubview:suo];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右箭头
    }else if (indexPath.section == 7){
        UILabel * la=[[UILabel alloc] initWithFrame: CGRectMake(0, 0, Width-16, 46)];
        la.text = @"发布";
        la.textAlignment = NSTextAlignmentCenter;
        la.layer.cornerRadius = 20;
        la.layer.masksToBounds = YES;
        la.backgroundColor = [ UIColor colorWithHexString:@"354DF0"];
        la.textColor = [ UIColor whiteColor];
        [cell addSubview:la];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (panDui == 0) {
        switch (indexPath.section) {
            case 4:
                [self fangfa:jiaoArr Key:@"officeName" :@"4"];
                break;
            case 5:
                [self fangfa:zhuanArr Key:@"professionName" :@"5"];
                break;
            case 6:
                [self fangfa:banArr Key:@"className" :@"6"];
                break;
            case 7:
                [self fabujiekou];
                break;
            default:
                break;
        }
    }else{
        switch (indexPath.section) {
            case 4:
                
                break;
            case 5:
                [self fabujiekou];
                break;
            default:
                break;
        }
    }
    
}
-(void)fangfa:(NSArray *)Shu Key:(NSString*)Key :(NSString *)cun{
    if (([cun  isEqual:@"5"]&&([xueDic objectForKey:@"officeName"]==nil ||[ [xueDic objectForKey:@"officeName"]  isEqual:[NSNull null]] ||NULL == [xueDic objectForKey:@"officeName"])) || ([cun  isEqual:@"6"]&&([xueDic objectForKey:@"professionName"]==nil ||[ [xueDic objectForKey:@"professionName"]  isEqual:[NSNull null]] ||NULL == [xueDic objectForKey:@"professionName"]))) {
        [WarningBox warningBoxModeText:@"请先选择上级机构" andView:self.view];
    }else{
        UIAlertController * alert = [[UIAlertController alloc] init];
        for (int i = 0; i < Shu.count; i++) {
            NSUInteger index=i;
            NSString * biaotou=[Shu[index] objectForKey:Key];
            UIAlertAction * action = [UIAlertAction actionWithTitle:biaotou style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if ([cun  isEqual: @"4"]) {
                    for (int i =0; i<zhuanArr.count; i++) {
                        if ([[zhuanArr[i] objectForKey:@"officeId"] isEqual:[Shu[index] objectForKey:@"id"]]) {
                            [erZhuan addObject:zhuanArr[i]];
                        }
                    }
                }else if ([cun  isEqual: @"5"]) {
                    for (int i =0; i<banArr.count; i++) {
                        if ([[banArr[i] objectForKey:@"professionId"] isEqual:[Shu[index] objectForKey:@"professionId"]]) {
                            [erBan addObject:banArr[i]];
                        }
                    }
                }
                [xueDic setObject:Shu[index] forKey:[NSString stringWithFormat:@"%@",Key]];
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
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    tihuan = textView.text;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    biaotou = textField.text;
}
-(void)DianZhong{
    if (pan == 0) {
        pan = 1;
    }else{
        pan = 0;
        [_TableView.superview endEditing:YES];
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [_TableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)XueSheng{
    if (panDui == 0) {
        panDui = 1;
    }else{
        panDui = 0;
        [_TableView.superview endEditing:YES];
    }
    [_TableView reloadData];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(void)fabujiekou{
    NSString * Method = @"/teacher/outboxPublic";
    
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    NSString *level = @"1";
    if (pan == 0) {
        level = @"1";
    }else{
        level = @"2";
    }
    NSString  *noticeTitle = GZT.text;
    //发送对象;
    NSDictionary * dd = [NSDictionary dictionaryWithObjectsAndKeys:@"1002",@"userId",@"张三",@"userName", nil];
    NSArray *officeList = [NSArray arrayWithObjects:dd, nil];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",level,@"level",@"1",@"noticeTitle",noticeTitle,@"noticeContent",@"1500",@"officeId",@"123456",@"officeName",@"1003",@"professionId",@"12355",@"professionName",@"1",@"companyName",@"1",@"companyTelephone",@"4",@"classId",@"5241",@"className",officeList,@"officeList",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"28.    教师公告通知发布\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
