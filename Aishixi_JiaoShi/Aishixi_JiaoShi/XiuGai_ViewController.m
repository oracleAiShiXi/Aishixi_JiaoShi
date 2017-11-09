//
//  XiuGai_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/27.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "XiuGai_ViewController.h"
#import "XL_TouWenJian.h"
#import "DengLu_ViewController.h"
@interface XiuGai_ViewController ()<UITextFieldDelegate>

@end

@implementation XiuGai_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self delegate];
    [self xianzhi];
}
-(void)delegate{
    _oldpassword.delegate=self;
    _newpassword.delegate=self;
    _renewpassword.delegate=self;
//    _newpassword.keyboardType = UIKeyboardTypeASCIICapable;
//    _oldpassword.keyboardType = UIKeyboardTypeASCIICapable;
//    _renewpassword.keyboardType=UIKeyboardTypeASCIICapable;
    _oldpassword.autocorrectionType = UITextAutocorrectionTypeNo;
    _newpassword.autocorrectionType = UITextAutocorrectionTypeNo;
    _renewpassword.autocorrectionType = UITextAutocorrectionTypeNo;
}
#pragma mark - textfield方法

//光标下移
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _oldpassword)
    {
        [_newpassword becomeFirstResponder];
    }
    else if (textField == _newpassword)
    {
        [_renewpassword becomeFirstResponder];
    }
    else
    {
        //结束编辑
        [self.view endEditing:YES];
        [self xiugaimima:nil];
    }
    return YES;
}
#pragma mark - 限制textField位数
-(void)xianzhi
{
    [self.oldpassword addTarget:self action:@selector(oldPass) forControlEvents:UIControlEventEditingChanged];
    [self.newpassword addTarget:self action:@selector(newPass1) forControlEvents:UIControlEventEditingChanged];
    [self.renewpassword addTarget:self action:@selector(newPass2) forControlEvents:UIControlEventEditingChanged];
}
-(void)oldPass
{
    int MaxLen = 14;
    NSString* szText = [_oldpassword text];
    if ([_oldpassword.text length]> MaxLen)
    {
        _oldpassword.text = [szText substringToIndex:MaxLen];
    }
}
-(void)newPass1
{
    int MaxLen = 14;
    NSString* szText = [_newpassword text];
    if ([_newpassword.text length]> MaxLen)
    {
        _newpassword.text = [szText substringToIndex:MaxLen];
    }
}
-(void)newPass2
{
    int MaxLen = 14;
    NSString* szText = [_renewpassword text];
    if ([_renewpassword.text length]> MaxLen)
    {
        _renewpassword.text = [szText substringToIndex:MaxLen];
    }
}
#pragma mark - 判断长度
-(BOOL)newpass1:(NSString *)new1
{
    if (self.newpassword.text.length < 5) {
        return NO;
    }
    return YES;
}

-(BOOL)newpass_Deng:(NSString *)deng
{
    if (![self.renewpassword.text isEqualToString: self.newpassword.text]) {
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)xiugaimima:(id)sender {
    [self.view endEditing:YES];
    if (![self newpass1:self.newpassword.text])
    {
        [WarningBox warningBoxModeText:@"密码长度不够" andView:self.view];
    }
    else if (![self newpass_Deng:self.renewpassword.text])
    {
        [WarningBox warningBoxModeText:@"两次密码不一致，请重新输入" andView:self.view];
    }else{
        [self jiekou];
    }
}
-(void)jiekou{
    [WarningBox warningBoxModeText:@"数据加载中..." andView:self.view];
    [self.view endEditing:YES];
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    NSString *oldPassword = _oldpassword.text;
    NSString *newPassword = _newpassword.text;
    
    NSDictionary * dd = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",oldPassword,@"oldPassword",@"2",@"userType",newPassword,@"newPassword", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:@"/user/setPassword" Rucan:dd type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"]  isEqual: @"0000"]) {
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"passWord"];
            DengLu_ViewController * deng =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"denglu"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:deng animated:YES completion:nil];
            });
        }
        [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        
        //        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！请检查网络！" andView:self.view];
        //        NSLog(@"%@",error);
    }];
    
}
@end
