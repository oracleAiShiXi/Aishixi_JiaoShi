//
//  XL_Header.h
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define CLog(format, ...)  NSLog(format, ## __VA_ARGS__)

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#define Scheme  @"http://"
#define AppName @"/aishixi"

#define apath    @"/api/rest/1.0"
//李世东
//#define QianWaiWangIP @"192.168.1.115:8080"
//宋浩然
#define QianWaiWangIP @"192.168.1.193:8080"
#define QianWaiWang [NSString stringWithFormat:@"%@%@%@%@",Scheme,QianWaiWangIP,AppName,apath]

#define Appkey   @"d800528f235e4142b78a8c26c4d537d9"


