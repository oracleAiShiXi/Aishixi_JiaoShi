
//
//  JinJiXiangQing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "JinJiXiangQing_ViewController.h"
#import "XL_TouWenJian.h"

@interface JinJiXiangQing_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITextView * TV;
    UILabel * kaishi,*jieshu;
    NSDictionary * data;
    
}
@end

@implementation JinJiXiangQing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"呼叫详情";
    _table.delegate =self;
    _table.dataSource =self;
    NSLog(@"%@",_sosId);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 456;
    }
    else if (indexPath.section==3){
        return 150;
    }else{
        return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }else{
        return 10;
    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 4;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
         static NSString * cellString = @"cell1";
         UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
         if(cell==nil){
           cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        UILabel * Name = [cell viewWithTag:600];
        UILabel * XueHao = [cell viewWithTag:601];
        UILabel * XueJie = [cell viewWithTag:602];
        UILabel * YuanXi = [cell viewWithTag:603];
        UILabel * ZhuanYe = [cell viewWithTag:604];
        UILabel * BanJi = [cell viewWithTag:605];
        UILabel * HuShi = [cell viewWithTag:606];
        UILabel * JingW = [cell viewWithTag:607];
        UILabel * WeiZhi = [cell viewWithTag:608];
        UILabel * NeiRong = [cell viewWithTag:609];
        UILabel * ChuLi = [cell viewWithTag:610];
        cell.backgroundColor =[UIColor clearColor];
        return cell;
    }else if (indexPath.section==1){
        static NSString * cellString = @"cell2";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
      
        kaishi = [cell viewWithTag:611];
        
        
        return cell;
    }else if (indexPath.section==2){
        static NSString * cellString = @"cell3";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
         jieshu = [cell viewWithTag:612];
        
        return cell;
    }else if (indexPath.section==3){
        static NSString * cellString = @"cell4";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
       
        TV =[cell viewWithTag:613];
        return cell;
    }else if (indexPath.section==4){
        static NSString * cellString = @"cell5";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        UILabel * Ren = [cell viewWithTag:614];
        
        return cell;
    }else {
        static NSString * cellString = @"cell6";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        
        
        return cell;
    }

}
-(void)jiazai_jiekou{
    NSString * Method = @"/teacher/sosInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:_sosId,@"sosId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"30.    教师SOS详情\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            data = [responseObject objectForKey:@"data"];
            [_table reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)tijiao_jiekou{
    NSString * Method = @"/teacher/handle";
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userId"];
    NSString *handleContent = TV.text;
    NSString *handleStrTime = kaishi.text;
    NSString *handleEndTime = jieshu.text;
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",_sosId,@"sosId",handleContent,@"handleContent",handleStrTime,@"handleStrTime",handleEndTime,@"handleEndTime",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"31.    教师SOS处理\n%@",responseObject);
//        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
//        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
