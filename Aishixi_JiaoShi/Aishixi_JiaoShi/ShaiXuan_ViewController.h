//
//  ShaiXuan_ViewController.h
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/10/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ablock)(NSDictionary *dic);
@interface ShaiXuan_ViewController : UIViewController
@property (nonatomic, copy) ablock block;
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (nonatomic,assign) int YeShai;
@end
