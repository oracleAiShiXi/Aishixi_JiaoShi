//
//  FaBuGongGao_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "FaBuGongGao_ViewController.h"
#import "XL_TouWenJian.h"
#import "MyCollectionViewCell.h"
@interface FaBuGongGao_ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    int pan,bian,panDui;
    UITextView * tv;
    NSString*tihuan;
    NSMutableArray * xuanzezhuangtai;
    NSArray * jiaoArr,*zhuanArr,*banArr;
    NSMutableArray *gouArr;
    NSMutableArray * erZhuan,*erBan;
    UITextField * GZT;
    NSString *biaotou;
    NSMutableDictionary * xueDic,*shiDic;
    UICollectionView * mainCollectionView;
    NSMutableArray * xuanRen;
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
    [self RenYuanXuanZe];
    NSString * s1 = @"所属教学单位";
    NSString * s2 = @"所属专业";
    NSString * s3 = @"所属班级";
    NSString * s4 = @"机构人员";
    xuanzezhuangtai =[NSMutableArray arrayWithObjects:s1,s2,s3,s4, nil];
    [self jiekou];
}
-(void)RenYuanXuanZe{
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);
    //该方法也可以设置itemSize
    // layout.itemSize =CGSizeMake(110, 150);
    // layout约束这边必须要用estimatedItemSize才能实现自适应,使用itemSzie无效
    layout.itemSize = CGSizeMake(Width-32, 30);
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(8,64,Width-16,Height-50) collectionViewLayout:layout];
    
    mainCollectionView.backgroundColor = [UIColor colorWithHexString:@"EFEFEF"];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    
    [mainCollectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    
    //4.设置代理
    
    //    mainCollectionView.allowsSelection = YES;
    mainCollectionView.allowsMultipleSelection = YES;
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    mainCollectionView.bounces = NO;
    
    [self.view addSubview:mainCollectionView];
    mainCollectionView.hidden = YES;
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
            gouArr = [NSMutableArray arrayWithArray:[data objectForKey:@"userList"]];
            [_TableView reloadData];
            [mainCollectionView reloadData];
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
            if (xuanRen.count !=0) {
                NSString * renming ;
                if ( [xuanRen[indexPath.row] objectForKey:@"userName"] ==nil || NULL == [xuanRen[indexPath.row] objectForKey:@"userName"] ||[[xuanRen[indexPath.row] objectForKey:@"userName"] isEqual:[NSNull null]]) {
                    renming =@"无名";
                }else{
                    renming =[xuanRen[indexPath.row] objectForKey:@"userName"];
                }
                xuan.text = [NSString stringWithFormat:@"%@等%lu人",renming,(unsigned long)xuanRen.count];
            }else{
                xuan.text = @"请选择";
            }
            
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
            la.backgroundColor = [ UIColor colorWithHexString:@"6ca3fd"];
            la.textColor = [ UIColor whiteColor];
            [cell addSubview:la];
            cell.accessoryType = UITableViewCellAccessoryNone;
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
        la.backgroundColor = [ UIColor colorWithHexString:@"6ca3fd"];
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
                [self fangfa:erZhuan Key:@"professionName" :@"5"];
                break;
            case 6:
                [self fangfa:erBan Key:@"className" :@"6"];
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
                mainCollectionView.hidden = NO;
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
                    erZhuan = [NSMutableArray array];
                    for (int i =0; i<zhuanArr.count; i++) {
                        if ([[zhuanArr[i] objectForKey:@"officeId"] isEqual:[Shu[index] objectForKey:@"id"]]) {
                            [erZhuan addObject:zhuanArr[i]];
                        }
                    }
                }else if ([cun  isEqual: @"5"]) {
                    erBan = [NSMutableArray array];
                    for (int i =0; i<banArr.count; i++) {
                        if ([[banArr[i] objectForKey:@"professionId"] isEqual:[Shu[index] objectForKey:@"professionId"]]) {
                            [erBan addObject:banArr[i]];
                        }
                    }
                }
                //加判断， 如果三个选完了，又换了第一个或第二个，使其后单位清空重新选择；
                //                if (<#condition#>) {
                //                    <#statements#>
                //                }
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
//判断是否全是空格
- (BOOL)isEmpty:(NSString *) str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
-(void)fabujiekou{
    //加一个全空判断；
    if ([self isEmpty:tv.text] || [self isEmpty:GZT.text] || (panDui == 1 && xuanRen.count == 0) ) {
        [WarningBox warningBoxModeText:@"请仔细完成信息！" andView:self.view];
    }else{
        
        NSString * Method = @"/teacher/outboxPublic";
        
        NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
        NSString *userId = [user objectForKey:@"userId"];
        NSString *level = @"1";
        if (pan == 0) {
            level = @"1";
        }else{
            level = @"2";
        }
        NSString *noticeContent = tv.text;
        NSString  *noticeTitle = GZT.text;
        NSArray *officeList = [NSArray array];
        NSString *officeId = @"";
        NSString *officeName = @"";
        NSString * professionId = @"";
        NSString *professionName=@"";
        NSString * classId =@"";
        NSString * className = @"";
        if (panDui == 1) {
            officeList = xuanRen;
        }else{
            officeList = nil;
            officeId =[[xueDic objectForKey:@"officeName"] objectForKey:@"id"];
            officeName=[[xueDic objectForKey:@"officeName"] objectForKey:@"officeName"];
            professionId=[[xueDic objectForKey:@"professionName"] objectForKey:@"professionId"];
            professionName=[[xueDic objectForKey:@"professionName"] objectForKey:@"professionName"];
            classId=[[xueDic objectForKey:@"className"] objectForKey:@"classId"];
            className=[[xueDic objectForKey:@"className"] objectForKey:@"className"];
            
        }
        
        NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",level,@"level",noticeTitle,@"noticeTitle",noticeContent,@"noticeContent",officeId,@"officeId",officeName,@"officeName",professionId,@"professionId",professionName,@"professionName",classId,@"classId",className,@"className",officeList,@"officeList",nil];
        [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
            NSLog(@"28.    教师公告通知发布\n%@",responseObject);
            if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.navigationController.view];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section  {
    if(section==0){
        return 1;
    }else if (section==1){
        return gouArr.count;
    }else {
        return 1;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    //MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if(indexPath.section==0){
        cell.blabel.text =@"确定";
        cell.tag=indexPath.row+100;
        cell.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
    }else if (indexPath.section==1){
        if(nil==[gouArr[indexPath.row] objectForKey:@"userName"]){
            cell.blabel.text =@"";
        }else{
            cell.blabel.text =[NSString stringWithFormat:@"%@",[gouArr[indexPath.row] objectForKey:@"userName"]];
        }
        cell.tag=indexPath.row+200;
        if ([[gouArr[indexPath.row] objectForKey:@"status"]  isEqual: @"1"]) {
            cell.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
        }else{
            cell.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
        }
    }else{
        cell.blabel.text =@"取消";
        cell.tag=indexPath.row+500;
        cell.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
    }
    
    // cell.backgroundColor = [UIColor yellowColor];
    
    
    cell.layer.cornerRadius =5;
    return cell;
}

//按照这个尺寸设置宽和高
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath  {
//
//    CGSize cc = CGSizeMake(80, 30);
//
//    return cc;
//}
//cell间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}
//行与行间最小距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//手动设置边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section  {
    // 顺序上左下右
    return UIEdgeInsetsMake(10,5,20,5);
    
}
////标题
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    // headerView.backgroundColor =[UIColor grayColor];
    
    for (UIView *vv in headerView.subviews) {
        [vv removeFromSuperview];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
    
    if(indexPath.section==0){
        //        label.text = @"年级";
    }else if (indexPath.section==1){
        label.text = @"人员选择";
    }else if (indexPath.section==2){
        //        label.text = @"授课教师";
    }
    
    
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment =NSTextAlignmentCenter;
    [headerView addSubview:label];
    return headerView;
}


//didselect方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //UICollectionViewCell *cell =  [mainCollectionView cellForItemAtIndexPath:indexPath];
    
    // cell.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
    //    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    NSString *msg = cell.blabel.text;
    //    NSLog(@"%@",msg);
    //    NSLog(@"-----%ld----%ld",(long)indexPath.section,(long)indexPath.row);
    if(indexPath.section==0){
        xuanRen = [NSMutableArray array];
        for (NSDictionary*dd in gouArr) {
            if ([[dd objectForKey:@"status"]  isEqual: @"1"]) {
                [xuanRen addObject:dd];
            }
        }
        mainCollectionView.hidden = YES;
        [_TableView reloadData];
        //取选中的人员名单;
    }
    else if(indexPath.section==1){
        for(UICollectionViewCell *celll in mainCollectionView.visibleCells){
            if(celll.tag==200+indexPath.row){
                
                celll.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
                
                NSMutableDictionary *dd = [NSMutableDictionary dictionaryWithDictionary:gouArr[indexPath.row]];
                [dd setObject:@"1" forKey:@"status"];
                [gouArr replaceObjectAtIndex:indexPath.row withObject:dd];
            }
        }
    }else{
        mainCollectionView.hidden = YES;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //UICollectionViewCell *cell =  [mainCollectionView cellForItemAtIndexPath:indexPath];
    
    // cell.backgroundColor =[UIColor colorWithHexString:@"40bcff"];
    //    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    NSString *msg = cell.blabel.text;
    //    NSLog(@"%@",msg);
    //    NSLog(@"-----%ld----%ld",(long)indexPath.section,(long)indexPath.row);
    if(indexPath.section==0){
        
    }
    else if(indexPath.section==1){
        for(UICollectionViewCell *celll in mainCollectionView.visibleCells){
            if(celll.tag==200+indexPath.row){
                
                celll.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
                //                [(NSMutableDictionary*)gouArr[indexPath.row] setObject:@"0" forKey:@"status"];
                NSMutableDictionary *dd = [NSMutableDictionary dictionaryWithDictionary:gouArr[indexPath.row]];
                [dd setObject:@"0" forKey:@"status"];
                [gouArr replaceObjectAtIndex:indexPath.row withObject:dd];
            }
        }
    }
    else if (indexPath.section==2){
        
    }
}
@end
