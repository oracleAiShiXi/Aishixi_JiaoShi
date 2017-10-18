//
//  CeshiJieKou_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/10/16.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "CeshiJieKou_ViewController.h"
#import "XL_TouWenJian.h"

@interface CeshiJieKou_ViewController ()

@end

@implementation CeshiJieKou_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self jiekou1];
}
+(void)jiekou1{
    NSString * Method = @"/set/startPage";
//    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:nil type:Post success:^(id responseObject) {
        NSLog(@"1、启动页\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou2{
    NSString * Method = @"/user/logined";
    //userID = 3965;
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"zls",@"userName",@"123456789",@"passWord",@"2",@"userType", nil];
    //userID = 14;
//    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"15776994457",@"userName",@"123456",@"passWord",@"1",@"userType", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"2、登陆\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou3{
    NSString * Method = @"/user/setPassword";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"3965",@"userId",@"123456",@"oldPassword",@"2",@"userType",@"admin",@"newPassword", nil];
//    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"14",@"userId",@"123456",@"oldPassword",@"1",@"userType",@"admin",@"newPassword", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"3、修改密码\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou4{
    NSString * Method = @"/homePageStu/evaluate";
    /*edUserId 被评人ID
     content 评价内容
     evaluateType 1 好评 2 中评 3 差评
     evaluatEdType 受评类型 1 企业 2 老师 3 学生
     */
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"3965",@"userId",@"1",@"edUserId",@"啦啦啦德玛西亚",@"content",@"1",@"evaluateType",@"3",@"evaluatEdType", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"4、评价\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma  mark 以下为学生端
+(void)jiekou5{
    NSString * Method = @"/homePageStu/homePage";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"14",@"userId", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"6、学生首页\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou6{
    NSString * Method = @"/homePageStu/carouselInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"carouselId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"7、轮播详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou7{
    NSString * Method = @"/consult/consul";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1",@"consultType",@"实习时间",@"consultContent", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"11 学生咨询\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou8{
    NSString * Method = @"/consult/consulList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1",@"pageNo",@"10",@"pageSize", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"12 学生咨询列表\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou9{
    NSString * Method = @"/consult/consulInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"consulId", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"13 学生咨询详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou10{
    NSString * Method = @"/classManagement/sos/seekHelp";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"123°43′45",@"longitude",@"45°03′38",@"latitude",@"哈尔滨工业大学",@"address",@"哈哈哈哈",@"context", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"14 学生sos\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou11{
    NSString * Method = @"/homePageStu/attendance";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"123°43′45",@"longitude",@"45°03′38",@"latitude",@"哈尔滨工业大学",@"address",nil];
    UIImage *image = [UIImage imageNamed:@"对号2"];
    NSArray * arr = [NSArray arrayWithObjects:image, nil];
    [XL_WangLuo ShangChuanTuPianwithBizMethod:Method Rucan:Rucan type:Post image:arr key:@"url" success:^(id responseObject) {
        NSLog(@"8 学生考勤\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
   
}
+(void)jiekou12{
    NSString * Method = @"/homePageStu/noticeList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1",@"pageNo",@"5",@"pageSize", nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"9 学生公告列表\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou13{
    NSString * Method = @"/homePageStu/noticeInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"11",@"userId",@"37",@"noticeId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"10 学生公告详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou14{
    NSString * Method = @"/diary/internshipPublic";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1",@"quesionChapter",@"1",@"mood",@"今天天气晴朗",@"content", nil];
    UIImage *image = [UIImage imageNamed:@"对号2"];
    NSArray *arr = [NSArray arrayWithObjects:image,image, nil];
    [XL_WangLuo ShangChuanTuPianwithBizMethod:Method Rucan:Rucan type:Post image:arr key:@"imageUrl" success:^(id responseObject) {
        NSLog(@"15 学生日记发布\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou15{
    NSString * Method = @"/diary/internshipList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1",@"pageNo",@"10",@"pageSize",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"16 学生日记列表\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou16{
    NSString * Method = @"/diary/internshipInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"19",@"internshipId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"17 学生日记详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou17{
    NSString * Method = @"/attend/getUserInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"18 学生个人信息查询\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou18{
    NSString * Method = @"/attend/userInfoSet";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"13888888888",@"mobilePhone",@"1",@"qqCode",@"1",@"wxCode",@"1",@"isInPost",@"1",@"money",@"1",@"companyIndustry",@"1",@"companyName",@"1",@"companyName",@"1",@"companyTelephone",@"1",@"postId",@"1",@"postName",@"1",@"location",@"1",@"address",@"1",@"urgentName",@"1",@"urgentTel",@"1",@"locationAll",@"1",@"addressAll",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"19 学生个人信息保存\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou19{
    NSString * Method = @"/attend/mailList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"20 学生通讯录\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma  mark  以下为教师端;
+(void)jiekou20{
    NSString * Method = @"/attend/choice";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"5",@"userId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"21 教师筛选\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou21{
    NSString * Method = @"/attend/attendanceList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"5",@"userId",@"0",@"pageNo",@"10",@"pageSize",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"22 教师考勤列表\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou22{
    NSString * Method = @"/attend/attendanceInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"attendanceId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"23.    教师考勤详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou23{
    NSString * Method = @"/attend/consulList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"5",@"userId",@"0",@"pageNo",@"10",@"pageSize",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"24.    教师咨询列表\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou24{
    NSString * Method = @"/attend/consulInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1024",@"consulId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"25.    教师咨询详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou25{
    NSString * Method = @"/teacher/inboxList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1",@"type",@"1",@"leve",@"1",@"createDate",@"1",@"startTime",@"1",@"endTime",@"1",@"pageSize",@"1",@"pageNo",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"26.    教师公告通知收件箱，发件箱\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou26{
    NSString * Method = @"/teacher/inboxInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"inboxId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"27.    教师公告通知收件箱，发件箱详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou27{
    NSString * Method = @"/teacher/outboxPublic";
    NSDictionary * dd = [NSDictionary dictionaryWithObjectsAndKeys:@"1002",@"userId",@"张三",@"userName", nil];
    NSArray *officeList = [NSArray arrayWithObjects:dd, nil];
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"4",@"userId",@"2",@"level",@"1",@"noticeTitle",@"1",@"noticeContent",@"1500",@"officeId",@"123456",@"officeName",@"1003",@"professionId",@"12355",@"professionName",@"1",@"companyName",@"1",@"companyTelephone",@"4",@"classId",@"5241",@"className",officeList,@"officeList",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"28.    教师公告通知发布\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou28{
    NSString * Method = @"/teacher/sosList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1505",@"officeId",@"1002",@"professionId",@"1",@"classId",@"1",@"createDate",@"2017-09-27",@"startTime",@"2017-09-29",@"endTime",@"1",@"pageNo",@"10",@"pageSize",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"29.    教师SOS列表\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou29{
    NSString * Method = @"/teacher/sosInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"15",@"sosId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"30.    教师SOS详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou30{
    NSString * Method = @"/teacher/handle";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"userId",@"13",@"sosId",@"处理结束二",@"handleContent",@"",@"handleStrTime",@"",@"handleEndTime",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"31.    教师SOS处理\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou31{
    NSString * Method = @"/teacher/getStudentList";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1",@"pageNo",@"10",@"pageSize",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"32.    教师评价-获取学生列表\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
+(void)jiekou32{
    NSString * Method = @"/teacher/evaluateInfo";
    //userId(Long):学生ID
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"33.    教师评价详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
