//
//  KaoqInXiangqing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "KaoqInXiangqing_ViewController.h"
#import "XL_TouWenJian.h"
@interface KaoqInXiangqing_ViewController ()

@end

@implementation KaoqInXiangqing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"考勤详情";
    [self lanquanSet];
    [self jiekou];
}
-(void)lanquanSet{
    _LanQuan.layer.borderColor =[UIColor colorWithHexString:@"6ca1fa"].CGColor;
    _LanQuan2.layer.borderColor =[UIColor colorWithHexString:@"6ca1fa"].CGColor;
}
-(void)jiekou{
    NSString * Method = @"/attend/attendanceInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_ID,@"attendanceId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"23.    教师考勤详情\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            NSDictionary * data = [[responseObject objectForKey:@"data"] objectForKey:@"attendanceInfo"];
            _Name.text = [data objectForKey:@"nick"];
            _XueHao.text = [data objectForKey:@"studentNumber"];
            _XueJie.text = [data objectForKey:@"classPeriod"];
            _YuanXi.text = [data objectForKey:@"officeName"];
            _ZhuanYe.text = [data objectForKey:@"professionName"];
            _BanJi.text = [data objectForKey:@"className"];
            NSString * guo =[data objectForKey:@"attendanceDate"];
            NSArray *guoArr =[guo componentsSeparatedByString:@" "];
            _ShiJian.text = guoArr[1];
            if ([[data objectForKey:@"attendanceType"]isEqual:@"2"]) {
                _ShiJian.textColor = [UIColor redColor];
            }
            _RiQi.text = guoArr[0];
            _DiZhi.text = [data objectForKey:@"attendanceAddress"];
            
        }else{
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
