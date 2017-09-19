//
//  DengLu_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "DengLu_ViewController.h"
#import "Color+Hex.h"

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

- (IBAction)ForgetPassword:(id)sender {
    
}

- (IBAction)Login_ShouDong:(id)sender {
    
}
@end
