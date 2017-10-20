//
//  ShaiXuan_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/10/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "ShaiXuan_ViewController.h"
#import "XL_TouWenJian.h"

@interface ShaiXuan_ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    //       教学单位。      专业。         班级。       机构人员。
    NSArray *officeList,*professionList,*classList,*userList;
    NSMutableDictionary * dic;
    NSArray *arrKao,*arrzhou;
}

@end

@implementation ShaiXuan_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    officeList = [[NSArray alloc] init];
    professionList = [[NSArray alloc] init];
    classList = [[NSArray alloc] init];
    userList = [[NSArray alloc] init];
    dic =[[NSMutableDictionary alloc] init];
    [self JieKou];
//    self.block(dic);
//    [self.navigationController popViewControllerAnimated:NO];
//    [self tan:officeList Key:@"officeName" Lable:_JiaoXueDanWei];
}
-(void)Delegate{
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(void)JieKou{
    NSString * Method = @"/attend/choice";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"5",@"userId",nil];
    [WarningBox warningBoxModeIndeterminate:@"数据连接中..." andView:self.view];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        NSLog(@"21 教师筛选\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            officeList = [data objectForKey:@"officeList"];
            professionList = [data objectForKey:@"professionList"];
            classList = [data objectForKey:@"classList"];
            userList = [data objectForKey:@"userList"];
        }else{
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)tan:(NSArray *)Shu Key:(NSString*)Key Lable:(UILabel *)Lable{
        UIAlertController * alert = [[UIAlertController alloc] init];
        for (int i = 0; i < Shu.count; i++) {
            NSUInteger index=i;
            NSString * biaotou=[Shu[index]objectForKey:@"ruleName"];
            UIAlertAction * action = [UIAlertAction actionWithTitle:biaotou style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                Lable.text=[Shu[index] objectForKey:Key];
            }];
            [alert addAction:action];
        }
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
}
@end
