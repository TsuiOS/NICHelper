//
//  XNVoiceViewController.m
//  NICHelper
//
//  Created by mac on 16/5/2.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNVoiceViewController.h"
#import "UITableView+XNEmptyData.h"
#import <Masonry.h>


@interface XNVoiceViewController ()<IFlySpeechSynthesizerDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {

    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
   
    
    NSMutableArray *_dataArray;
    NSString *_string;
}

@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) UITableView *voiceTableView;

@end

@implementation XNVoiceViewController

#pragma mark - 懒加载

- (UIButton *)voiceButton {

    if (_voiceButton == nil) {
        _voiceButton = [[UIButton alloc]init];
        [_voiceButton setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
        [_voiceButton sizeToFit];
        [_voiceButton addTarget:self action:@selector(OnClickVoice) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_voiceButton];
    }
    return _voiceButton;
}

- (UITableView *)voiceTableView {

    if (_voiceTableView == nil) {
        _voiceTableView = [[UITableView alloc]init];
        _voiceTableView.delegate = self;
        _voiceTableView.dataSource = self;
        [self.view addSubview:_voiceTableView];
    
    }
    return _voiceTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.voiceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
    [self setupUI];
    [self initData];
    [self initIFly];
}
-(void)viewWillDisappear:(BOOL)animated{
    [_iFlySpeechSynthesizer stopSpeaking];
}
- (void)setupUI {
    
    [self.voiceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.voiceTableView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    
}
-(void)initData{

    NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"myarray"];
    _dataArray = [array mutableCopy];
}


//有界面
-(void)initRecognizer{
    //单例模式，UI的实例
    if (_iflyRecognizerView == nil) {
        //UI显示剧中
        _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
    }
    _iflyRecognizerView.delegate = self;
    
    if (_iflyRecognizerView != nil) {
        //设置最长录音时间
        [_iflyRecognizerView setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点 3000
        [_iflyRecognizerView setParameter:@"3000" forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点   3000
        [_iflyRecognizerView setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
        //设置采样率，推荐使用16K    16000
        [_iflyRecognizerView setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        //        if ([instance.language isEqualToString:[IATConfig chinese]]) {
        //            //设置语言   zh_cn
        [_iflyRecognizerView setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        //            //设置方言  mandarin
        [_iflyRecognizerView setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
   
        //设置是否返回标点符号   0
        [_iflyRecognizerView setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
}


/** 启用听写 */
- (void)OnClickVoice {
    
    if (_iflyRecognizerView == nil) {
        [self initRecognizer];
    }
    //设置音频来源为麦克风
    [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iflyRecognizerView start];
    
}
//文字转语音
-(void)initIFly{
    //1.创建合成对象
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    //2.设置合成参数
    //设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //音量,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]]; //发音人,默认为”xiaoyan”,可以设置的参数列表可参考“合成发音人列表”
    [_iFlySpeechSynthesizer setParameter:@"xiaoyan" forKey: [IFlySpeechConstant VOICE_NAME]]; //保存合成文件名,如不再需要,设置设置为nil或者为空表示取消,默认目录位于 library/cache下
    [_iFlySpeechSynthesizer setParameter:@"tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //3.启动合成会话
    [_iFlySpeechSynthesizer startSpeaking: @"你好,我是科大讯飞的小燕"];
    
}



/**
 有界面，听写结果回调
 resultArray：听写结果
 isLast：表示最后一次
 ****/
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    if ([result isEqualToString:@""]) {

        return;
    }
    [_dataArray addObject:result];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[_dataArray copy] forKey:@"myarray"];
    [userDefaults synchronize];
    if (isLast) {
        [self.voiceTableView reloadData];
    }
}

/** 识别结束回调
 
 @param error 识别结束错误码
 */
//- (void)onError: (IFlySpeechError *) error {
//    NSLog(@"%@",error);
//    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:nil message:@"没有识别到" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新输入", nil];
//    alerView.tag = 0;
//    [alerView show];
//    
//}
//
//#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 1) {
//        [self OnClickVoice];
//    }
//}

#pragma mark - IFlySpeechSynthesizerDelegate
//结束代理
-(void)onCompleted:(IFlySpeechError *)error{
    NSLog(@"onCompleted");
}
//合成开始
- (void) onSpeakBegin{
    NSLog(@"onSpeakBegin");
}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg{
    NSLog(@"onBufferProgress");
}
//合成播放进度
- (void) onSpeakProgress:(int) progress{
    NSLog(@"onSpeakProgress");
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView tableViewDisplayWithMsg:@"没有备忘录" ifNecessaryForRowCount:_dataArray.count];
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}
@end
