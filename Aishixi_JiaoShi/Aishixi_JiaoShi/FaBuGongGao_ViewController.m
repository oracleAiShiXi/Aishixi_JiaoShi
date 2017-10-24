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
    int pan,bian;
    UITextView * tv;
    NSString*tihuan;
    NSString *jiao,*zhuan,*ban,*gou;
    NSMutableArray * xuanzezhuangtai;
    NSArray * jiaoArr,*zhuanArr,*banArr,*gouArr;
    UITextField * GZT;
}

@end

@implementation FaBuGongGao_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布公告";
    pan = 0;bian = 0;tihuan = [NSString string];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    _TableView.backgroundColor = [UIColor colorWithHexString:@""];
    NSString * s1 = @"所属教学单位";
    NSString * s2 = @"所属专业";
    NSString * s3 = @"所属班级";
    NSString * s4 = @"机构人员";
    xuanzezhuangtai =[NSMutableArray arrayWithObjects:s1,s2,s3,s4, nil];
    jiao = s1;zhuan = s2;ban = s3;gou = s4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
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
    if (indexPath.section == 0) {
        UILabel * Zhong = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 80, 30)];
        Zhong.text=@"重要程度";
        Zhong.font=[UIFont systemFontOfSize:16];
        [cell addSubview:Zhong];
        UIButton * Yao =[[UIButton alloc] initWithFrame:CGRectMake(8 + Zhong.frame.origin.x + Zhong.frame.size.width + 8, 8, 80, 30)];
        if (pan == 0) {
            [Yao setImage:[UIImage imageNamed:@"对号2"] forState: UIControlStateNormal];
        }else{
            [Yao setImage:[UIImage imageNamed:@"对号3"] forState: UIControlStateNormal];
        }
        Yao.titleLabel.font = [UIFont systemFontOfSize:14];;
        [Yao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Yao setTitle:@"重要" forState:UIControlStateNormal];
        Yao.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
        Yao.imageEdgeInsets = UIEdgeInsetsMake(0,-2,0,2);
        [Yao addTarget:self action:@selector(DianZhong) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:Yao];
        
        UIButton * Pu =[[UIButton alloc] initWithFrame:CGRectMake(8 + Yao.frame.origin.x + Yao.frame.size.width + 8, 8, 80, 30)];
        if (pan == 0) {
            [Pu setImage:[UIImage imageNamed:@"对号3"] forState: UIControlStateNormal];
        }else{
            [Pu setImage:[UIImage imageNamed:@"对号2"] forState: UIControlStateNormal];
        }
        Pu.titleLabel.font = [UIFont systemFontOfSize:14];;
        [Pu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Pu addTarget:self action:@selector(DianZhong) forControlEvents:UIControlEventTouchUpInside];
        [Pu setTitle:@"普通" forState:UIControlStateNormal];
        Pu.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
        Pu.imageEdgeInsets = UIEdgeInsetsMake(0,-2,0,2);
        [cell addSubview:Pu];
//        cell.backgroundColor =[UIColor clearColor];
    }else if (indexPath.section == 1){
        GZT = [[UITextField alloc] initWithFrame:CGRectMake(8, 6, Width-32,32 )];
        GZT.delegate =self;
        GZT.placeholder = @"请输写公告主题";
        [cell addSubview:GZT];
    }else if (indexPath.section == 2){
        tv = [[UITextView alloc] initWithFrame:CGRectMake(8, 6, Width - 32, 130)];
        tv.delegate=self;
        tv.text = tihuan;
        if (bian == 1) {
            [tv becomeFirstResponder];
        }
        [cell addSubview:tv];
        UIButton * bb = [[UIButton alloc] initWithFrame:CGRectMake(Width - 58, 88, 50, 50)];
        [bb setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [bb addTarget:self action:@selector(BianJi) forControlEvents:UIControlEventTouchUpInside];
        if (bian == 0) {
            [cell addSubview:bb];
        }
    }else if (indexPath.section == 3){
        UILabel * suo = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, Width - 120, 30)];
        suo.text = jiao;
        UILabel * xuan = [self xuanzetishi:jiao :indexPath];
        [cell addSubview:xuan];
        [cell addSubview:suo];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右箭头
    }else if (indexPath.section == 4){
        UILabel * suo = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, Width - 120, 30)];
        suo.text = zhuan;
        UILabel * xuan = [self xuanzetishi:zhuan :indexPath];
        [cell addSubview:xuan];
        [cell addSubview:suo];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右箭头
    }else if (indexPath.section == 5){
        UILabel * suo = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, Width - 120, 30)];
        suo.text = ban;
        UILabel * xuan = [self xuanzetishi:ban :indexPath];
        [cell addSubview:xuan];
        [cell addSubview:suo];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右箭头
    }else if (indexPath.section == 6){
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            [self fabujiekou];
            break;
        default:
            break;
    }
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (bian == 0) {
        return NO;
    }
    return YES;
}
-(void)BianJi{
    tihuan = tv.text;
    if (bian == 0) {
        bian = 1;
    }else{
        bian = 0;
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [_TableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(UILabel *)xuanzetishi:(NSString *)ss :(NSIndexPath * )indexPath{
    UILabel * xuan = [[UILabel alloc] initWithFrame:CGRectMake(Width-100, 8, 72, 30)];
    xuan.textColor = [UIColor colorWithHexString:@"c8c8c8"];
    if ([ss  isEqual: xuanzezhuangtai[indexPath.section-3]]) {
        xuan.text = @"请选择";
    }else{
        xuan.text = @"已选择";
    }
    return xuan;
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
