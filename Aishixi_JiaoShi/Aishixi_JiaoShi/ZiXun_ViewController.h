//
//  ZiXun_ViewController.h
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZiXun_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *TableView;

- (IBAction)ShezhiButton:(id)sender;
- (IBAction)ShaixuanButton:(id)sender;

@end
