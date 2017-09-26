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
}
-(void)lanquanSet{
    _LanQuan.layer.borderColor =[UIColor colorWithHexString:@"6ca1fa"].CGColor;
    _LanQuan2.layer.borderColor =[UIColor colorWithHexString:@"6ca1fa"].CGColor;
}
@end
