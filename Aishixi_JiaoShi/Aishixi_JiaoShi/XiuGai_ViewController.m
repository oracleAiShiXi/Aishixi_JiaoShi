//
//  XiuGai_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/27.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "XiuGai_ViewController.h"
#import "XL_TouWenJian.h"

@interface XiuGai_ViewController ()<UITextFieldDelegate>

@end

@implementation XiuGai_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)delegate{
    _oldpassword.delegate=self;
    _newpassword.delegate=self;
    _renewpassword.delegate=self;
}

- (IBAction)xiugaimima:(id)sender {
    //各种判断
    [self jiekou];
}
-(void)jiekou{
    [self.view endEditing:YES];
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    NSString *oldPassword = _oldpassword.text;
    NSString *newPassword = _newpassword.text;
    
    NSDictionary * dd = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",oldPassword,@"oldPassword",@"2",@"userType",newPassword,@"newPassword", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:@"/user/setPassword" Rucan:dd type:Post success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
@end
