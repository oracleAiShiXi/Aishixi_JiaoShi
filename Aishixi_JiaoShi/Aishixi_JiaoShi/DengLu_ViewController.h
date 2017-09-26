//
//  DengLu_ViewController.h
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DengLu_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *mingView;
@property (weak, nonatomic) IBOutlet UIView *miView;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Password;
//- (IBAction)ForgetPassword:(id)sender;
- (IBAction)Login_ShouDong:(id)sender;
@end

