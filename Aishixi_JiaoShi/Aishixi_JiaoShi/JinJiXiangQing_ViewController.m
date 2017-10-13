
//
//  JinJiXiangQing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "JinJiXiangQing_ViewController.h"

@interface JinJiXiangQing_ViewController ()<UITableViewDelegate,UITableViewDataSource>
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
        
        cell.backgroundColor =[UIColor clearColor];
        return cell;
    }else if (indexPath.section==1){
        static NSString * cellString = @"cell2";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        
        
        return cell;
    }else if (indexPath.section==2){
        static NSString * cellString = @"cell3";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        
        
        return cell;
    }else if (indexPath.section==3){
        static NSString * cellString = @"cell4";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        
        
        return cell;
    }else if (indexPath.section==4){
        static NSString * cellString = @"cell5";
        UITableViewCell *cell =[_table dequeueReusableCellWithIdentifier:cellString];
        if(cell==nil){
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        
        
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
@end
