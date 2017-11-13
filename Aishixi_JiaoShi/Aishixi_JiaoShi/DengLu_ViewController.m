//
//  DengLu_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "DengLu_ViewController.h"
#import "TabBar_ViewController.h"
#import "XL_TouWenJian.h"
#import "AppDelegate.h"

#import "CeshiJieKou_ViewController.h"

@interface DengLu_ViewController ()<UITextFieldDelegate>

@end

@implementation DengLu_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self JieMian];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString * passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    if ( userName ==nil || NULL == userName||[userName  isEqual:[NSNull null]]) {
        _Name.text =@"";
    }else{
        _Name.text =userName ;
    }
    if ( passWord ==nil || NULL == passWord||[passWord  isEqual:[NSNull null]]) {
        _Password.text =@"";
    }else{
        _Password.text =passWord ;
    }
    [self delegate];
}
-(void)delegate{
    _Name.delegate = self;
    _Password.delegate = self;
    _Name.autocorrectionType = UITextAutocorrectionTypeNo;
    _Password.autocorrectionType = UITextAutocorrectionTypeNo;
}
-(void)PuanDuanIfDengLuGuo{
    
}
-(void)JieMian{
    _miView.layer.borderColor=[UIColor colorWithHexString:@"a0c3fd"].CGColor;
    _mingView.layer.borderColor=[UIColor colorWithHexString:@"a0c3fd"].CGColor;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _Name) {
        [_Password becomeFirstResponder];
    }else{
        [_Password resignFirstResponder];
        [self Login_ShouDong:nil];
    }
    return YES;
}
- (IBAction)Login_ShouDong:(id)sender {
    [self jiekou];
#pragma mark  通用
//    [CeshiJieKou_ViewController  jiekou1];
//    [CeshiJieKou_ViewController  jiekou2];
//    [CeshiJieKou_ViewController  jiekou3];
//    [CeshiJieKou_ViewController  jiekou4];//  评论 4
#pragma mark  学生
//    [CeshiJieKou_ViewController  jiekou5];
//    [CeshiJieKou_ViewController  jiekou6];
//    [CeshiJieKou_ViewController  jiekou7];
//    [CeshiJieKou_ViewController  jiekou8];
//    [CeshiJieKou_ViewController  jiekou9];
//    [CeshiJieKou_ViewController  jiekou10];
//    [CeshiJieKou_ViewController  jiekou11];//  学生考勤 8
//    [CeshiJieKou_ViewController  jiekou12];
//    [CeshiJieKou_ViewController  jiekou13];//  学生公告详情 10
//    [CeshiJieKou_ViewController  jiekou14];//500  学生日记发布 15
//    [CeshiJieKou_ViewController  jiekou15];
//    [CeshiJieKou_ViewController  jiekou16];
//    [CeshiJieKou_ViewController  jiekou17];
//    [CeshiJieKou_ViewController  jiekou18];//  学生   信息修改保存 19
//    [CeshiJieKou_ViewController  jiekou19];
    
#pragma mark 教师
//    [CeshiJieKou_ViewController  jiekou20];
//    [CeshiJieKou_ViewController  jiekou21];
//    [CeshiJieKou_ViewController  jiekou22];
//    [CeshiJieKou_ViewController  jiekou23];
//    [CeshiJieKou_ViewController  jiekou24];//25.教师咨询详情
//    [CeshiJieKou_ViewController  jiekou25];
//    [CeshiJieKou_ViewController  jiekou26];//27.    教师公告通知收件箱，发件箱详情
//    [CeshiJieKou_ViewController  jiekou27];
//    [CeshiJieKou_ViewController  jiekou28];
//    [CeshiJieKou_ViewController  jiekou29];//30.    教师SOS详情
//    [CeshiJieKou_ViewController  jiekou30];//31.    教师SOS处理
//    [CeshiJieKou_ViewController  jiekou31];
//    [CeshiJieKou_ViewController  jiekou32];//33.    教师评价详情
//    [CeshiJieKou_ViewController  jiekou33];
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
-(void)jiekou{
    if ([self isEmpty:_Name.text] || [self isEmpty:_Password.text]) {
        [WarningBox warningBoxModeText:@"请认真填写用户名及密码!" andView:self.view];
    }else{
        NSDictionary * did =[NSDictionary dictionaryWithObjectsAndKeys:_Name.text,@"userName",_Password.text,@"passWord",@"2",@"userType",nil];
        [WarningBox warningBoxModeIndeterminate:@"登陆中..." andView:self.view];
        [XL_WangLuo QianWaiWangQingqiuwithBizMethod:@"/user/logined" Rucan:did type:Post success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            [WarningBox warningBoxHide:YES andView:self.view];
            if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
                NSUserDefaults * def =[NSUserDefaults standardUserDefaults];
                [def setObject:_Name.text forKey:@"userName"];
                [def setObject:_Password.text forKey:@"passWord"];
                /*数据处理*/
                NSDictionary * data =[responseObject objectForKey:@"data"];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                //用户Id
                [user setObject:[data objectForKey:@"userId"] forKey:@"userId"];
                //用户电话
                [user setObject:[data objectForKey:@"tel"] forKey:@"tel"];
                
                TabBar_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
                /*数据传输*/
                //登陆成功后重新注册一次极光的标签和别名
                [[AppDelegate appDelegate] method];
                [self presentViewController:Kao animated:YES completion:^{
                    
                }];
            }else{
                [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
                
            }
            
        } failure:^(NSError *error) {
            [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:@"网络连接失败！请检查网络！" andView:self.view];
            NSLog(@"%@",error);
        }];
    }

}
@end
