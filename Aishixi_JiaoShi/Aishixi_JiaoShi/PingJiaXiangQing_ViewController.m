//
//  PingJiaXiangQing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/25.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "PingJiaXiangQing_ViewController.h"
#import "XL_TouWenJian.h"

@interface PingJiaXiangQing_ViewController ()<UITextViewDelegate>{
    BOOL hao,zhong,cha;
    NSDictionary *data;
}

@end

@implementation PingJiaXiangQing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评价详情";
    
    [self KeyboardJianTing];
    [self jiekou];
}
-(void)jiekou{
    NSString * Method = @"/teacher/evaluateInfo";
    //userId(Long):学生ID
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_studentId,@"userId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"33.    教师评价详情\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            data =[responseObject objectForKey:@"data"];
            [self jiemianbuju:data];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (IBAction)FaBu:(id)sender {
    [self.view endEditing:YES];
    
    NSString * Method = @"/homePageStu/evaluate";
    /*edUserId 被评人ID
     content 评价内容
     evaluateType 1 好评 2 中评 3 差评
     evaluatEdType 受评类型 1 企业 2 老师 3 学生
     */
    NSString * evaluateType =@"";
    if (hao ==YES) {
        evaluateType = @"1";
    }else if (zhong ==YES) {
        evaluateType = @"2";
    }else if (cha ==YES) {
        evaluateType = @"3";
    }
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",_studentId,@"edUserId",_TextView.text,@"content",evaluateType,@"evaluateType",@"3",@"evaluatEdType", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"4、评价\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            [self fanhui];
        }
        [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.navigationController.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark --- 不变的开始
-(void)jiemianbuju:(NSDictionary *)dd{
    _TextView.delegate = self;;
    _Name.text = [dd objectForKey:@"studentName"];
    _XueHao.text = [dd objectForKey:@"studentNumber"];;
    _XueJie.text = [dd objectForKey:@"classPeriod"];;
    _YuanXi.text = [dd objectForKey:@"officeName"];;
    _ZhuanYe.text = [dd objectForKey:@"professionName"];;
    _BanJi.text = [dd objectForKey:@"className"];;
    _ShiJian.text = [dd objectForKey:@"createDate"];;
    int typ =[[dd objectForKey:@"evaluateStatus"] intValue];
    if(typ == 1){
        _Tpye.text =@"已评价";
        _fabubutton.hidden = YES;
        _Tpye.textColor = [UIColor colorWithHexString:@"8db5fb"];
        _TextView.text = [dd objectForKey:@"evaluateContent"];
        int res =[[dd objectForKey:@"evaluateResult"] intValue];
        if (res == 1) {
            hao = YES;zhong = false;cha =false;
        }else if (res == 2){
            hao = false;zhong = YES;cha =false;
        }else if(res == 3){
            hao = false;zhong = false;cha =YES;
        }
        [self danxuananniubuju];
        
    }else{
        _Tpye.text =@"未评价";
       
        hao = YES;zhong = false;cha =false;
        [self danxuananniubuju];
        _fabubutton.hidden = NO;
        _Tpye.textColor = [UIColor colorWithHexString:@"fe697c"];
    }
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([[data objectForKey:@"evaluateStatus"] intValue]!=1) {
        return  YES;
    }
    return NO;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
-(void)tapAction{
    
    if ([_TextView isFirstResponder]&&UIKeyboardDidShowNotification)
    {
        [_TextView resignFirstResponder];
        //使视图还原
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y = 0;
        self.view.frame = viewFrame;
    }
}
-(void)danxuananniubuju{
    if (hao == YES) {
        _GoodP.tintColor = [UIColor colorWithHexString:@"0de7c8"];
        [_GoodP setImage:[UIImage imageNamed:@"对号2"] forState:UIWindowLevelNormal];
    }else{
        _GoodP.tintColor = [UIColor colorWithHexString:@"cfd2d2"];
        [_GoodP setImage:[UIImage imageNamed:@"对号3"] forState:UIWindowLevelNormal];
    }
    
    
    if (zhong == YES) {
        _CenterP.tintColor = [UIColor colorWithHexString:@"0de7c8"];
        [_CenterP setImage:[UIImage imageNamed:@"对号2"] forState:UIWindowLevelNormal];
    }else{
        _CenterP.tintColor = [UIColor colorWithHexString:@"cfd2d2"];
        [_CenterP setImage:[UIImage imageNamed:@"对号3"] forState:UIWindowLevelNormal];
    }
    
    if (cha == YES) {
        _BadP.tintColor = [UIColor colorWithHexString:@"0de7c8"];
        [_BadP setImage:[UIImage imageNamed:@"对号2"] forState:UIWindowLevelNormal];
    }else{
        _BadP.tintColor = [UIColor colorWithHexString:@"cfd2d2"];
        [_BadP setImage:[UIImage imageNamed:@"对号3"] forState:UIWindowLevelNormal];
    }
    [_GoodP setTitle:@"好评" forState:UIControlStateNormal];
    _GoodP.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
    _GoodP.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [_CenterP setTitle:@"中评" forState:UIControlStateNormal];
    _CenterP.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
    _CenterP.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [_BadP setTitle:@"差评" forState:UIControlStateNormal];
    _BadP.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
    _BadP.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
}

- (IBAction)haoP:(id)sender {
    if ([[data objectForKey:@"evaluateStatus"] intValue]!=1) {
        hao = YES ;zhong = false;cha = false ;
        [self danxuananniubuju];
    }
}

- (IBAction)zhongP:(id)sender {
    if ([[data objectForKey:@"evaluateStatus"] intValue]!=1) {
        hao = false ;zhong = YES;cha = false ;
        [self danxuananniubuju];
    }
}

- (IBAction)chaP:(id)sender {
    if ([[data objectForKey:@"evaluateStatus"] intValue]!=1) {
        hao = false ;zhong = false;cha = YES ;
        [self danxuananniubuju];
    }
}
@end
