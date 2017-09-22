//
//  KaoqInXiangqing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "KaoqInXiangqing_ViewController.h"
#import "Color+Hex.h"

@interface KaoqInXiangqing_ViewController ()

@end

@implementation KaoqInXiangqing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self lanquanSet];
}
-(void)lanquanSet{
    _LanQuan.layer.borderColor =[UIColor colorWithHexString:@"6ca1fa"].CGColor;
    _LanQuan2.layer.borderColor =[UIColor colorWithHexString:@"6ca1fa"].CGColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
