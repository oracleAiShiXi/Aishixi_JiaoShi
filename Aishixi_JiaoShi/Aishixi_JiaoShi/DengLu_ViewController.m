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

@interface DengLu_ViewController ()

@end

@implementation DengLu_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self JieMian];
}
-(void)PuanDuanIfDengLuGuo{
    
}
-(void)JieMian{
    _miView.layer.borderColor=[UIColor colorWithHexString:@"a0c3fd"].CGColor;
    _mingView.layer.borderColor=[UIColor colorWithHexString:@"a0c3fd"].CGColor;
}

- (IBAction)Login_ShouDong:(id)sender {
    [self jiekou];
    
    
    
}
-(void)jiekou{
    NSDictionary * did =[NSDictionary dictionaryWithObjectsAndKeys:@"thinkgem",@"userName",@"admin",@"passWord",@"2" ,@"userTpye",nil];
    [WarningBox warningBoxModeIndeterminate:@"登陆中..." andView:self.view];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:@"/user/logined" Rucan:did type:Post success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            /*数据处理*/
            
            
            TabBar_ViewController *Kao =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
            /*数据传输*/
            
//            [self presentViewController:Kao animated:YES completion:^{
            
//            }];
        }else{
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
