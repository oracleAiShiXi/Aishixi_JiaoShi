//
//  FaBuGongGao_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "FaBuGongGao_ViewController.h"
#import "XL_TouWenJian.h"

@interface FaBuGongGao_ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextViewDelegate,UITextFieldDelegate>{
    int pan;
}

@end

@implementation FaBuGongGao_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布公告";
    pan = 0;
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    _TableView.backgroundColor = [UIColor colorWithHexString:@""];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellString = @"hehe";
    UITableViewCell * cell =[_TableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    if (indexPath.section == 0) {
        UILabel * Zhong = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 80, 30)];
        Zhong.text=@"重要程度";
        Zhong.font=[UIFont systemFontOfSize:16];
        [cell addSubview:Zhong];
        UIButton * Yao =[[UIButton alloc] initWithFrame:CGRectMake(8 + Zhong.frame.origin.x + Zhong.frame.size.width + 8, 8, 80, 30)];
        if (pan == 0) {
            [Yao setImage:[UIImage imageNamed:@"对号2"] forState: UIControlStateNormal];
        }else{
            [Yao setImage:[UIImage imageNamed:@"对号3"] forState: UIControlStateNormal];
        }
        Yao.titleLabel.font = [UIFont systemFontOfSize:14];;
        [Yao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Yao setTitle:@"重要" forState:UIControlStateNormal];
        Yao.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
        Yao.imageEdgeInsets = UIEdgeInsetsMake(0,-2,0,2);
        [Yao addTarget:self action:@selector(DianZhong) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:Yao];
        
        UIButton * Pu =[[UIButton alloc] initWithFrame:CGRectMake(8 + Yao.frame.origin.x + Yao.frame.size.width + 8, 8, 80, 30)];
        if (pan == 0) {
            [Pu setImage:[UIImage imageNamed:@"对号3"] forState: UIControlStateNormal];
        }else{
            [Pu setImage:[UIImage imageNamed:@"对号2"] forState: UIControlStateNormal];
        }
        Pu.titleLabel.font = [UIFont systemFontOfSize:14];;
        [Pu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Pu addTarget:self action:@selector(DianZhong) forControlEvents:UIControlEventTouchUpInside];
        [Pu setTitle:@"普通" forState:UIControlStateNormal];
        Pu.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,-2);
        Pu.imageEdgeInsets = UIEdgeInsetsMake(0,-5,0,5);
        [cell addSubview:Pu];
        cell.backgroundColor =[UIColor clearColor];
    }else if (indexPath.section == 1){
        UITextField * tt = [[UITextField alloc] initWithFrame:CGRectMake(8, 6, Width-32,32 )];
        tt.delegate =self;
        tt.placeholder = @"请输写公告主题";
    }else if (indexPath.section == 2){
        UITextView * tt = [[UITextView alloc] initWithFrame:CGRectMake(8, 6, Width-32, 100)];
        tt.delegate=self;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
////    if (indexPath.section == 0) {
//
//        cell.backgroundColor = [UIColor clearColor];
//        cell.backgroundView.backgroundColor = [UIColor clearColor];
////    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
            break;
        default:
            break;
    }
}
-(void)DianZhong{
    if (pan == 0) {
        pan = 1;
    }else{
        pan = 0;
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [_TableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
