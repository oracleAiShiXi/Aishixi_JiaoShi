//
//  TabBar_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "TabBar_ViewController.h"

@interface TabBar_ViewController ()

@end

@implementation TabBar_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabBar = self.tabBar;
    for (int i = 0; i < 4; i++) {
        NSString*pic1name=@"";
        NSString*pic2name=@"";
        switch (i) {
            case 0:
                pic1name = @"导航1";
                pic2name = @"导航1-1";
                break;
            case 1:
                pic1name = @"导航2-1";
                pic2name = @"导航2-2";
                break;
            case 2:
                pic1name = @"导航3-1";
                pic2name = @"导航3-3";
                break;
            case 3:
                pic1name = @"导航4-1";
                pic2name = @"导航4-4";
                break;
            default:
                break;
        }
        UITabBarItem *tabBarItem = [tabBar.items objectAtIndex:i];
        [self setTabBarWithTabBarItem:tabBarItem AndPicture:pic1name AndPic:pic2name];
    }
}

-(void)setTabBarWithTabBarItem:(UITabBarItem*)tabBarItem AndPicture:(NSString *)pic1name AndPic:(NSString *)pic2name{
    UIImage *tabBarItemImage = [UIImage imageNamed:pic1name];
    UIImage *imgImage =[UIImage imageNamed:pic2name];
    tabBarItem.selectedImage = [tabBarItemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.image = [imgImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
//                                                        NSForegroundColorAttributeName : [UIColor blackColor]
//                                                        } forState:UIControlStateNormal];//未选中
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
//                                                        NSForegroundColorAttributeName : [UIColor blackColor]
//                                                        } forState:UIControlStateSelected];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
