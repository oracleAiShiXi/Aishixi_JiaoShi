//
//  ZiXunXiangQing_ViewController.h
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ABLOK)(int dic);
@interface ZiXunXiangQing_ViewController : UIViewController
@property (nonatomic, copy) ABLOK Ablock;

@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *XueHao;
@property (weak, nonatomic) IBOutlet UILabel *XueJie;
@property (weak, nonatomic) IBOutlet UILabel *YuanXi;
@property (weak, nonatomic) IBOutlet UILabel *ZhuanYe;
@property (weak, nonatomic) IBOutlet UILabel *BanJi;
@property (weak, nonatomic) IBOutlet UILabel *ShiJian;
@property (weak, nonatomic) IBOutlet UILabel *Type;
@property (weak, nonatomic) IBOutlet UIImageView *shouTouXiang;
@property (weak, nonatomic) IBOutlet UIView *shouView;
@property (weak, nonatomic) IBOutlet UILabel *shouLable;

@property (weak, nonatomic) IBOutlet UIImageView *FaTouXiang;
@property (weak, nonatomic) IBOutlet UIView *faView;
@property (weak, nonatomic) IBOutlet UILabel *faLable;
@property (weak, nonatomic) IBOutlet UIView *ZiView;
@property (weak, nonatomic) IBOutlet UIButton *yuYinShu;
- (IBAction)FaSong:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *TextF;


@property (strong , nonatomic) NSString * ID;
@property (assign , nonatomic) int  Lala;


@end
