//
//  GongGaoXiangQing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "GongGaoXiangQing_ViewController.h"

@interface GongGaoXiangQing_ViewController ()

@end

@implementation GongGaoXiangQing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _titleX;
    [self JieKou];
}
-(void)JieKou{
    [self BuJu:nil];
}
-(void)BuJu:(NSDictionary *)dd{
    _Title.text=@"vdsv";
    _TextView.text = @"vdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadvvdsvsadv";
    _FaBuRen.text = @"vdsvsadv";
    _FaBuShiJian.text = @"vsvsv";
}
@end
