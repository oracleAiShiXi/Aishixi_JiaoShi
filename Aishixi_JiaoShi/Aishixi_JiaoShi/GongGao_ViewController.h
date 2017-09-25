//
//  GongGao_ViewController.h
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GongGao_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegShou_Fa;
- (IBAction)FaShou:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)ShezhiButton:(id)sender;
- (IBAction)ShaixuanButton:(id)sender;

@end
