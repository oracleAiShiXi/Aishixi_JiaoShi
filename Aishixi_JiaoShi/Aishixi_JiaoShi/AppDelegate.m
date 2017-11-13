//
//  AppDelegate.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "AppDelegate.h"
#import "XL_TouWenJian.h"
#import <JPUSHService.h>

#define appkey @"ae09c6cdae9db765b0e8ad17"
#define channell @""
#define isProduction 1

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<JPUSHRegisterDelegate>
@property (strong, nonatomic) UIView *lunchView;
@end

@implementation AppDelegate
@synthesize lunchView;
static AppDelegate *_appDelegate;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    [JPUSHService setupWithOption:launchOptions appKey:appkey
                          channel:channell
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //前导页
    NSString *str=[NSString stringWithFormat:@"%@%@%@",Scheme,QianWaiWangIP,[[NSUserDefaults standardUserDefaults] objectForKey:@"tupianqidong"]];
    self.window.backgroundColor=[UIColor colorWithHexString:@"33c383"];
    [self.window makeKeyAndVisible];
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    lunchView = viewController.view;
    lunchView.frame = CGRectMake(0, 0, self.window.screen.bounds.size.width, self.window.screen.bounds.size.height);
    [self.window addSubview:lunchView];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
//    str = [str  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//         str= @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490322357&di=41a07a09e62f75400dade1b603142199&imgtype=jpg&er=1&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F7acb0a46f21fbe09359315d16f600c338644ad22.jpg";
    [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"引导页2"]];
    [lunchView addSubview:imageV];
    
    [self.window bringSubviewToFront:lunchView];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];
    
    [self jiekou];
    return YES;
}
+ (AppDelegate *)appDelegate {
    return _appDelegate;
}
-(void)removeLun{
    [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        lunchView.alpha = 0.0f;
        lunchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 1.0f);
    } completion:^(BOOL finished) {
        [lunchView removeFromSuperview];
    }];
}
#pragma  mark -- 注册用户 （JPush）
-(void)method{

    NSString*alias=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]];
    
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"--iResCode  %ld\niAlias  %@\nseq  %ld",(long)iResCode,iAlias,(long)seq);
        if (iResCode == 6002) {
            [self method];
        }
    } seq:1];
//    [JPUSHService setTags:tags alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
//        NSLog(@"\n%d\n%@\n%@",iResCode,iTags,iAlias);
//    }];
}
#pragma mark -- 启动页接口
-(void)jiekou{
     NSString *BizMethod=@"/set/startPage";
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:BizMethod Rucan:nil type:Post success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject objectForKey:@"data"] objectForKey:@"url"] forKey:@"tupianqidong"];
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"deviceToken    %@",deviceToken);
    
    
    [self method];
}

// NS_DEPRECATED_IOS(3_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得Extras字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,(long)badge,sound,customizeField1);
    
    // iOS 10 以下 Required
    [JPUSHService handleRemoteNotification:userInfo];
}

//iOS 7 Remote Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:  (NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"this is iOS7 Remote Notification");
    
    // iOS 10 以下 Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark- JPUSHRegisterDelegate // 2.1.9版新增JPUSHRegisterDelegate,需实现以下两个方法

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center  willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    else {
        // 本地通知
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler: (void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    else {
        // 本地通知
    }
    completionHandler();  // 系统要求执行这个方法
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

@end
