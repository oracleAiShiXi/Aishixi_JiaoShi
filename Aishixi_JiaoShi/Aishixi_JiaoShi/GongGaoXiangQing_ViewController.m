//
//  GongGaoXiangQing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "GongGaoXiangQing_ViewController.h"
#import "XL_TouWenJian.h"
@interface GongGaoXiangQing_ViewController ()

@end

@implementation GongGaoXiangQing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _titleX;
    [self JieKou];
}
-(void)JieKou{
    NSString * Method = @"/teacher/inboxInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_inboxId,@"inboxId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"27.    教师公告通知收件箱，发件箱详情\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            NSDictionary * data = [responseObject objectForKey:@"dat"];
            [self BuJu:data];
        }else{
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)BuJu:(NSDictionary *)dd{
    _Title.text=[dd objectForKey:@"noticeTitle"];
    _TextView.text = [dd objectForKey:@"noticeContent"];
    _FaBuRen.text = [dd objectForKey:@"userName"];
    _FaBuShiJian.text = [dd objectForKey:@"publishTime"];
}
@end
