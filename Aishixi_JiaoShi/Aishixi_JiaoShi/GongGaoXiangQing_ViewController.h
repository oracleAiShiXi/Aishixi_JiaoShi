//
//  GongGaoXiangQing_ViewController.h
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GongGaoXiangQing_ViewController : UIViewController
@property (nonatomic , strong) NSString * titleX;
@property (nonatomic , strong) NSString * inboxId;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *TextView;

@property (weak, nonatomic) IBOutlet UILabel *FaBuRen;
@property (weak, nonatomic) IBOutlet UILabel *FaBuShiJian;


@end
