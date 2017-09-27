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

@interface DengLu_ViewController ()<UITextFieldDelegate>

@end

@implementation DengLu_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self JieMian];
    _Name.text = @"zls";
    _Password.text = @"123456";
    [self delegate];
}
-(void)delegate{
    _Name.delegate = self;
    _Password.delegate = self;
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
}
-(void)jiekou{
    NSDictionary * did =[NSDictionary dictionaryWithObjectsAndKeys:_Name.text,@"userName",_Password.text,@"passWord",@"2",@"userType",nil];
    [WarningBox warningBoxModeIndeterminate:@"登陆中..." andView:self.view];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:@"/user/logined" Rucan:did type:Post success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            /*数据处理*/
            NSDictionary * data =[responseObject objectForKey:@"data"];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            //用户Id
            [user setObject:[data objectForKey:@"userId"] forKey:@"userId"];
            //用户电话
            [user setObject:[data objectForKey:@"tel"] forKey:@"tel"];
            
            TabBar_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
            /*数据传输*/
            
            [self presentViewController:Kao animated:YES completion:^{
            
            }];
        }else{
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        NSLog(@"%@",error);
    }];
}
@end
