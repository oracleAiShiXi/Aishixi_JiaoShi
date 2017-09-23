//
//  ZiXunXiangQing_ViewController.m
//  Aishixi_JiaoShi
//
//  Created by 斌小狼 on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "ZiXunXiangQing_ViewController.h"
#import "Color+Hex.h"
#import <Speech/Speech.h>

@interface ZiXunXiangQing_ViewController ()<SFSpeechRecognizerDelegate,UITextViewDelegate>
@property(nonatomic,strong)SFSpeechRecognizer * recognizer ;

//语音识别功能
@property(nonatomic,strong)SFSpeechAudioBufferRecognitionRequest * recognitionRequest ;
@property(nonatomic,strong)SFSpeechRecognitionTask * recognitionTask ;
@property(nonatomic,strong)AVAudioEngine * audioEngine ;

@end

@implementation ZiXunXiangQing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
    _YuanXi.adjustsFontSizeToFitWidth = YES;
    _ZhuanYe.adjustsFontSizeToFitWidth = YES;
    _TextF.delegate = self;
    
    [self delegate];
    [self KeyboardJianTing];
    [self jiemianbuju:nil :0];
}
- (IBAction)anxia:(id)sender {
    NSLog(@"anxiale");
    if ([self.audioEngine isRunning]) {
        
    }else{
        [self startRecording];
    }
}

- (IBAction)songshou:(id)sender {
    NSLog(@"songkaile");
    if ([self.audioEngine isRunning]) {
        [self.audioEngine stop];
        [self.recognitionRequest endAudio];
    }
    //    [self.audioEngine stop];
    
}
-(void)jiemianbuju:(NSDictionary *)dd :(int) i{
    _shouView.layer.cornerRadius = 20;
    _faView.layer.cornerRadius = 20;
    _yuYinShu.backgroundColor =[UIColor colorWithHexString:@"6ca3fd"];
    
    
    NSString *nameString=@"王小明";
    NSString *XuehaoString = @"2012021385";
    NSString *XuejieString = @"2018";
    NSString *yuanxiString = @"电气工程及其自动化";
    NSString *zhuanyeString = @"电气专业";
    NSString *banjiString = @"电气15-16班";
    NSString *shijianString = @"2017-06-28 12:24:36";
    NSString *typeString =@"";
    if (i == 0) {
        typeString = @"岗位";
        _Type.textColor = [UIColor colorWithHexString:@"0ee6ca"];
    }else if (i == 1){
        typeString = @"请假";
        _Type.textColor = [UIColor colorWithHexString:@"fa9463"];
    }else{
        typeString = @"其他";
        _Type.textColor = [UIColor colorWithHexString:@"fcca26"];
    }
    NSString *shouString = @"老师啊";
    NSString *faSring =_TextF.text;
    UIImage *shouImage = [UIImage imageNamed:@"头像"];
    UIImage *faImage = [UIImage imageNamed:@"头像"];
    
    _Name.text = nameString;
    _XueHao.text = XuehaoString;
    _XueJie.text = XuejieString;
    _YuanXi.text = yuanxiString;
    _ZhuanYe.text = zhuanyeString;
    _BanJi.text = banjiString;
    _ShiJian.text =shijianString;
    _Type.text = typeString;
    _shouLable.text = shouString;
    _faLable.text = faSring;
    _shouTouXiang.image = shouImage;
    _FaTouXiang.image = faImage;
    
    if (i == 0) {
        _faView.hidden = YES;
        _FaTouXiang.hidden = YES;
        _ZiView.hidden = NO;
    }else{
        _faView.hidden = NO;
        _FaTouXiang.hidden = NO;
        _ZiView.hidden = YES;
    }
}
-(void)KeyboardJianTing{
    //监听键盘是否呼出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(upViews:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tapAction)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
#pragma mark - 键盘弹出时界面上移及还原
-(void)upViews:(NSNotification *) notification{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyBoardHeight = keyboardRect.size.height;
    //使视图上移
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = -keyBoardHeight;
    self.view.frame = viewFrame;
}
-(void)textViewDidChange:(UITextView *)textView {
    //获得textView的初始尺寸
    CGFloat width = CGRectGetWidth(textView.frame);
    CGFloat height = CGRectGetHeight(textView.frame);
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmax(newSize.width, width), fmax(newSize.height,height ));
    textView.frame= newFrame;
}
-(void)tapAction{
    
    if ([_TextF isFirstResponder]&&UIKeyboardDidShowNotification)
    {
        [_TextF resignFirstResponder];
        //使视图还原
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y = 0;
        self.view.frame = viewFrame;
    }
}
#pragma  mark ---- 语音转文字
-(void)delegate{
    NSLocale *cale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-CN"];
    self.recognizer = [[SFSpeechRecognizer alloc]initWithLocale:cale];
    //    self.yuYinShu.enabled = false;
    //设置代理
    self.recognizer.delegate = self;
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        bool isButtonEnabled = false;
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                isButtonEnabled = true;
                NSLog(@"可以语音识别");
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                isButtonEnabled = false;
                NSLog(@"用户被拒绝访问语音识别");
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                isButtonEnabled = false;
                NSLog(@"不能在该设备上进行语音识别");
                break;
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                isButtonEnabled = false;
                NSLog(@"没有授权语音识别");
                break;
            default:
                break;
        }
        //        self.yuYinShu.enabled = isButtonEnabled;
    }];
    
    self.audioEngine = [[AVAudioEngine alloc]init];
}

- (void)startRecording{
    if (self.recognitionTask) {
        [self.recognitionTask cancel];
        self.recognitionTask = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    bool  audioBool = [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    bool  audioBool1= [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
    bool  audioBool2= [audioSession setActive:true withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    if (audioBool || audioBool1||  audioBool2) {
        NSLog(@"可以使用");
    }else{
        NSLog(@"这里说明有的功能不支持");
    }
    self.recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc]init];
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    
    self.recognitionRequest.shouldReportPartialResults = true;
    
    //开始识别任务
    self.recognitionTask = [self.recognizer recognitionTaskWithRequest:self.recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        bool isFinal = false;
        if (result) {
            self.TextF.text = [[result bestTranscription] formattedString]; //语音转文本
            isFinal = [result isFinal];
        }
        if (error || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            self.recognitionRequest = nil;
            self.recognitionTask = nil;
            //            self.yuYinShu.enabled = true;
        }
    }];
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [self.recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    [self.audioEngine prepare];
    bool audioEngineBool = [self.audioEngine startAndReturnError:nil];
    NSLog(@"%d",audioEngineBool);
    //    self.inPutTextField.text = @"大妹砸。聊十块钱的";
}
//语音代理
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (available) {
        //        self.yuYinShu.enabled = YES;
    }else{
        
        //        self.yuYinShu.enabled = NO;
    }
}

- (IBAction)FaSong:(id)sender {
    [self.view endEditing:YES];
    [self jiemianbuju:nil :1];
}
@end
