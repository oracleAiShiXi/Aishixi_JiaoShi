//
//  PingJiaXiangQing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/25.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "PingJiaXiangQing_ViewController.h"
#import "Color+Hex.h"

@interface PingJiaXiangQing_ViewController ()<UITextViewDelegate>{
    BOOL hao,zhong,cha;
}

@end

@implementation PingJiaXiangQing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评价详情";
   
    [self KeyboardJianTing];
}
-(void)viewWillAppear:(BOOL)animated{
    hao = YES ;zhong = false;cha = false ;
    [self danxuananniubuju];
    [self jiemianbuju:nil];
}

- (IBAction)FaBu:(id)sender {
    [self.view endEditing:YES];
}
#pragma  mark --- 不变的开始
-(void)jiemianbuju:(NSDictionary *)dd{
    _Name.text = @"王小明";
    _XueHao.text = @"2012021385";
    _XueJie.text = @"2012";
    _YuanXi.text = @"电气工程及其自动化";
    _ZhuanYe.text = @"人文哈哈哈哈哈哈哈哈";
    _BanJi.text = @"电气12-11";
    _ShiJian.text = @"2017-07-13 14:16:42";
    if(1 == 1){
        _Tpye.text =@"已评价";
        _Tpye.textColor = [UIColor colorWithHexString:@"8db5fb"];
    }else{
        _Tpye.text =@"未评价";
        _Tpye.textColor = [UIColor colorWithHexString:@"fe697c"];
    }
   
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
    hao = YES ;zhong = false;cha = false ;
    [self danxuananniubuju];
}

- (IBAction)zhongP:(id)sender {
    hao = false ;zhong = YES;cha = false ;
    [self danxuananniubuju];
}

- (IBAction)chaP:(id)sender {
    hao = false ;zhong = false;cha = YES ;
    [self danxuananniubuju];
}
@end
