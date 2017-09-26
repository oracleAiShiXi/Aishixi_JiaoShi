//
//  PingJiaXiangQing_ViewController.h
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/25.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingJiaXiangQing_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *XueHao;
@property (weak, nonatomic) IBOutlet UILabel *XueJie;
@property (weak, nonatomic) IBOutlet UILabel *YuanXi;
@property (weak, nonatomic) IBOutlet UILabel *ZhuanYe;
@property (weak, nonatomic) IBOutlet UILabel *BanJi;
@property (weak, nonatomic) IBOutlet UILabel *ShiJian;
@property (weak, nonatomic) IBOutlet UILabel *Tpye;
@property (weak, nonatomic) IBOutlet UIButton *GoodP;
@property (weak, nonatomic) IBOutlet UIButton *CenterP;
@property (weak, nonatomic) IBOutlet UIButton *BadP;
@property (weak, nonatomic) IBOutlet UITextView *TextView;
- (IBAction)FaBu:(id)sender;
- (IBAction)haoP:(id)sender;
- (IBAction)zhongP:(id)sender;
- (IBAction)chaP:(id)sender;


@end
