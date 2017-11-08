//
//  KaoqInXiangqing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "KaoqInXiangqing_ViewController.h"
#import "XL_TouWenJian.h"
#import <UIImageView+WebCache.h>
#import "EBImageBrowser.h"
@interface KaoqInXiangqing_ViewController ()
{
    NSString *str;
}
@end

@implementation KaoqInXiangqing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"考勤详情";
    [self lanquanSet];
    [self jiekou];
}
-(void)lanquanSet{
    _LanQuan.layer.borderColor =[UIColor colorWithHexString:@"6ca1fa"].CGColor;
    _LanQuan2.layer.borderColor =[UIColor colorWithHexString:@"6ca1fa"].CGColor;
}
-(void)jiekou{
    NSString * Method = @"/attend/attendanceInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_ID,@"attendanceId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"23.    教师考勤详情\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            NSDictionary * data = [[responseObject objectForKey:@"data"] objectForKey:@"attendanceInfo"];
            [self jiemianBuju:data];
        }else{
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)jiemianBuju:(NSDictionary*)data{
    if ( [data objectForKey:@"nick"] ==nil || NULL == [data objectForKey:@"nick"]||[[data objectForKey:@"nick"]  isEqual:[NSNull null]]) {
        _Name.text =@"";
    }else{
        _Name.text =[data objectForKey:@"nick"] ;
    }
    _Name.adjustsFontSizeToFitWidth = YES;
    if ( [data objectForKey:@"studentNumber"] ==nil || NULL == [data objectForKey:@"studentNumber"]||[[data objectForKey:@"studentNumber"]  isEqual:[NSNull null]]) {
        _XueHao.text =@"";
    }else{
        _XueHao.text =[data objectForKey:@"studentNumber"] ;
    }
    _XueHao.adjustsFontSizeToFitWidth = YES;
    if ( [data objectForKey:@"classPeriod"] ==nil || NULL == [data objectForKey:@"classPeriod"]||[[data objectForKey:@"classPeriod"]  isEqual:[NSNull null]]) {
        _XueJie.text =@"";
    }else{
        _XueJie.text =[data objectForKey:@"classPeriod"] ;
    }
    _XueJie.adjustsFontSizeToFitWidth = YES;
    if ( [data objectForKey:@"officeName"] ==nil || NULL == [data objectForKey:@"officeName"]||[[data objectForKey:@"officeName"]  isEqual:[NSNull null]]) {
        _YuanXi.text =@"";
    }else{
        _YuanXi.text =[data objectForKey:@"officeName"] ;
    }
    _YuanXi.adjustsFontSizeToFitWidth = YES;
    if ( [data objectForKey:@"professionName"] ==nil || NULL == [data objectForKey:@"professionName"]||[[data objectForKey:@"professionName"]  isEqual:[NSNull null]]) {
        _ZhuanYe.text =@"";
    }else{
        _ZhuanYe.text =[data objectForKey:@"professionName"] ;
    }
    _ZhuanYe.adjustsFontSizeToFitWidth = YES;
    if ( [data objectForKey:@"className"] ==nil || NULL == [data objectForKey:@"className"]||[[data objectForKey:@"className"]  isEqual:[NSNull null]]) {
        _BanJi.text =@"";
    }else{
        _BanJi.text =[data objectForKey:@"className"] ;
    }
    _BanJi.adjustsFontSizeToFitWidth = YES;
    NSString * guo;
    if ( [data objectForKey:@"attendanceTime"] ==nil || NULL == [data objectForKey:@"attendanceTime"]||[[data objectForKey:@"attendanceTime"]  isEqual:[NSNull null]]) {
        _ShiJian.text =@"";
    }else{
        guo =[data objectForKey:@"attendanceTime"] ;
        NSArray *guoArr =[guo componentsSeparatedByString:@" "];
        _ShiJian.text = guoArr[1];
        _RiQi.text = guoArr[0];
    }
    
    if ([[data objectForKey:@"attendanceType"]isEqual:@"2"]) {
        _ShiJian.textColor = [UIColor redColor];
    }
    if ( [data objectForKey:@"attendanceAddress"] ==nil || NULL == [data objectForKey:@"attendanceAddress"]||[[data objectForKey:@"attendanceAddress"]  isEqual:[NSNull null]]) {
        _DiZhi.text =@"";
    }else{
        _DiZhi.text =[data objectForKey:@"attendanceAddress"] ;
    }
    _DiZhi.adjustsFontSizeToFitWidth = YES;
    str =[NSString stringWithFormat:@"%@%@%@",Scheme,QianWaiWangIP,[data objectForKey:@"attendanceUrl"]];
    [_zhaoPian sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@""]];
    [_zhaoPian setContentScaleFactor:[[UIScreen mainScreen] scale]];
    _zhaoPian.contentMode =  UIViewContentModeScaleAspectFit;
    _zhaoPian.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _zhaoPian.clipsToBounds  = YES;
    _zhaoPian.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [_zhaoPian addGestureRecognizer:tapGestureRecognizer1];
}
-(void)scanBigImageClick1:(UITapGestureRecognizer *)tap{
    
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    //    [XWScanImage scanBigImageWithImageView:clickedImageView];
    [EBImageBrowser showImage:clickedImageView];
}
@end
