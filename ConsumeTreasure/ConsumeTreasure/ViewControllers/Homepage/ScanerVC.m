//
//  ScanerVC.m
//  SuperScanner
//
//  Created by Jeans Huang on 10/19/15.
//  Copyright © 2015 gzhu. All rights reserved.
//

#import <Masonry.h>

#import "UIAlertView+flash.h"
#import "ScanerVC.h"
#import "ScanerView.h"
#import "GoPrePayViewController.h"
//#import "AccountViewController.h"
//#import "ScanerPayViewController.h"
//#import "CollectionViewController.h"
@import AVFoundation;

@interface ScanerVC ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    NSString * _headImgUrl;//头像
    NSString * _loginName;//登录名
    NSString * _phone;//手机号
    NSString * _erweima;
}

//! 加载中视图
@property (copy, nonatomic)  UIView    *loadingView;

//! 扫码区域动画视图
@property (copy, nonatomic) ScanerView *scanerView;
@property (copy, nonatomic) UIView *coverView;

//AVFoundation
//! AV协调器
@property (strong,nonatomic) AVCaptureSession           *session;
//! 取景视图
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property (strong,nonatomic) UIButton * numKeyBoardBtn;
@end

@implementation ScanerVC



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark---viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"扫一扫";

    self.tabBarController.tabBar.hidden = YES;
   // [self backButton];
   //  self.view.backgroundColor=RGBACOLOR(204, 204, 204, 1);
    [self loadUI];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //self.navigationController.navigationBar.barTintColor = RGBACOLOR(255, 87, 59, 1);
    self.view.backgroundColor=[UIColor whiteColor];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowOnDelay) name:UIKeyboardWillShowNotification object:nil ];
    
    //
}
#pragma mark - viewVillAppear
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [_mainScrollView endEditing:YES];
    //self.navigationController.navigationBar.translucent = NO;
    
    //初始化扫码
    //    [self setupAVFoundation];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [self.previewLayer removeFromSuperlayer];
    //    [self.session re]
}
#pragma mark -PrivateMethod
- (void)addLayout{
[_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(@0);
     make.left.equalTo(@0);
     make.width.equalTo(@(WIDTH));
     make.height.equalTo(@(HEIGHT-64-H(90)));
 }];
 
 [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(@(HEIGHT-H(150)));
     make.left.equalTo(@0);
     make.width.equalTo(@(WIDTH));
     make.height.equalTo(@(HEIGHT-64-H(90)));
     
 }];
    
    [_scanerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(100));
        make.left.equalTo(@(20*KRatioW));
        make.width.equalTo(@(280*KRatioW));
        make.height.equalTo(@(280*KRatioH));
        
    }];
}

#pragma mark---加载UI
-(void)loadUI
{

    
    _mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, WIDTH, HEIGHT-64-H(90))];
    _mainScrollView.contentSize=CGSizeMake(WIDTH*2, HEIGHT-64-H(50));
//    _mainScrollView.backgroundColor=[UIColor redColor];
    _mainScrollView.showsHorizontalScrollIndicator=NO;
    _mainScrollView.showsVerticalScrollIndicator=NO;
    _mainScrollView.bounces=NO;
    _mainScrollView.pagingEnabled=YES;
    _mainScrollView.scrollEnabled=NO;
    //    _mainScrollView.delegate=self;
    //    _mainScrollView.backgroundColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:_mainScrollView];

    _scanerView=[[ScanerView alloc]initWithFrame:CGRectMake(20*KRatioW, 0*KRatioH, 280*KRatioW, 280*KRatioH)];
    self.scanerView.alpha = 0;
    //设置扫描区域边长
    self.scanerView.scanAreaEdgeLength = [[UIScreen mainScreen] bounds].size.width - 2 * 50;
    [_mainScrollView addSubview:_scanerView];
    
    _coverView=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-H(86), WIDTH, H(90))];
    _coverView.backgroundColor=RGBACOLOR(51, 51, 51, 1);
    [self.view addSubview:_coverView];
    

    
    
    
    _scanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    _scanBtn.backgroundColor=[UIColor cyanColor];
    _scanBtn.frame=CGRectMake(W(140), H(15), W(40), H(60));
    _scanBtn.enabled=NO;
    [_scanBtn setImage:[UIImage imageNamed:@"ewm_clk"] forState:0];
    [_scanBtn addTarget:self action:@selector(scanOrder) forControlEvents:UIControlEventTouchUpInside];
    [_coverView addSubview:_scanBtn];
    
    
    _keyinBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_keyinBtn setImage:[UIImage imageNamed:@"fkm_nor"] forState:0];
    _keyinBtn.frame=CGRectMake(W(220), H(15), W(40), H(60));
    [_keyinBtn addTarget:self action:@selector(putOrder) forControlEvents:UIControlEventTouchUpInside];
    //[_coverView addSubview:_keyinBtn];
   // [self addLayout];
}

#pragma mark---viewDidAppear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self.previewLayer removeFromSuperlayer];
    
//    [_session removeConnection:<#(AVCaptureConnection *)#>]
//    if (!self.session){
    
        //添加镜头盖开启动画
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
//        animation.type = @"cameraIrisHollowOpen";
        animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        animation.delegate = self;
        [self.view.layer addAnimation:animation forKey:@"animation"];
    
        //初始化扫码
        [self setupAVFoundation];
        
        //调整摄像头取景区域
       self.previewLayer.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
   // self.previewLayer.backgroundColor = [UIColor redColor].CGColor;
        //调整扫描区域
        AVCaptureMetadataOutput *output = self.session.outputs.firstObject;
        //根据实际偏差调整y轴
        CGRect rect = CGRectMake((self.scanerView.scanAreaRect.origin.y + 20) / Height(self.scanerView),
                                 self.scanerView.scanAreaRect.origin.x / Width(self.scanerView),
                                 self.scanerView.scanAreaRect.size.height / Height(self.scanerView),
                                 self.scanerView.scanAreaRect.size.width / Width(self.scanerView));
        output.rectOfInterest = rect;
//    }
}

//! 动画结束回调
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    self.loadingView.hidden = YES;
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.scanerView.alpha = 1;
                     }];
}

//! 初始化扫码
- (void)setupAVFoundation{
    //创建会话
    self.session = [[AVCaptureSession alloc] init];
    
    //获取摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;

    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];

    if(input) {
        [self.session addInput:input];
    } else {
        //出错处理
        NSLog(@"%@", error);
        
        NSString *msg = [NSString stringWithFormat:@"请在手机【设置】-【隐私】-【相机】选项中，允许【%@】访问您的相机",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];

        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提醒"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
        [av show];
        
        return;
    }
    
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [self.session addOutput:output];
    
    //设置扫码类型
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,  //条形码
                                   AVMetadataObjectTypeEAN13Code,
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeCode128Code];
    //设置代理，在主线程刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //创建摄像头取景区域
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    if ([self.previewLayer connection].isVideoOrientationSupported)
        [self.previewLayer connection].videoOrientation = AVCaptureVideoOrientationPortrait;
        
    //开始扫码
    [self.session startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjects Delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    for (AVMetadataMachineReadableCodeObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self.session stopRunning];
            
           // DMLog(@"二维码");
            NSArray *array = [metadata.stringValue componentsSeparatedByString:@"|"];
//            DMLog(@"----%@",array);
//            DMLog(@"+++++%@",metadata.stringValue);
            if ([array[0] isEqualToString:@"business"]) {
                NSDictionary * param=@{@"inviteCode":array[1]};
                
                /****************
                [RequstEngine requestHttp:@"1055" paramDic:param blockObject:^(NSDictionary *dic) {
                    DMLog(@"1055----%@",dic);
                    DMLog(@"error---%@",dic[@"errorMsg"]);
                    if ([dic[@"errorCode"] intValue]==00000) {
                        _headImgUrl=dic[@"member"][@"imgUrl"];
                        _loginName=dic[@"member"][@"loginName"];
                        _phone=dic[@"member"][@"phone"];
                        CollectionViewController * collectionVC=[[CollectionViewController alloc]init];
                        collectionVC.infoModel=_infoModel;
                        collectionVC.shopId=array[2];
                        collectionVC.shopName=array[3];
                        collectionVC.returnBate=array[4];
                        collectionVC.whichPage=@"扫描";
                        [self.navigationController pushViewController:collectionVC animated:YES];
                    }
                    else
                    {
                        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"已识别此二维码内容为："
                                                                    message:metadata.stringValue
                                                                   delegate:self
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"复制内容", nil];
                        av.delegate=self;
                        _erweima=metadata.stringValue;
                        [av show];
                        
                    }
                }];
*////////////////////
            }
            else if([array[0] isEqualToString:@"message"])
            {
                NSDictionary * param=@{@"inviteCode":array[1]};
                
                /**************
                [RequstEngine requestHttp:@"1055" paramDic:param blockObject:^(NSDictionary *dic) {
                    DMLog(@"1055----%@",dic);
                    DMLog(@"error---%@",dic[@"errorMsg"]);
                    if ([dic[@"errorCode"] intValue]==00000) {
                        _headImgUrl=dic[@"member"][@"imgUrl"];
                        _loginName=dic[@"member"][@"loginName"];
                        _phone=dic[@"member"][@"phone"];
                        AccountViewController * VC=[[AccountViewController alloc]init];
                        VC.inviteCode=array[1];
                        VC.headImgUrl=_headImgUrl;
                        VC.loginName=_loginName;
                        VC.phone=_phone;
                        [self.navigationController pushViewController:VC animated:YES];
                    }
                    else
                    {
                        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"已识别此二维码内容为："
                                                                    message:metadata.stringValue
                                                                   delegate:self
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"复制内容", nil];
                        av.delegate=self;
                        _erweima=metadata.stringValue;
                        [av show];
                        
                        
                    }
                }];

               *////////////////////////
            }
            else
            {
                NSArray *separateStringArray = [metadata.stringValue componentsSeparatedByString:@"="];
                [self performSegueWithIdentifier:@"sacanPrePaySegueId" sender:separateStringArray[1]];
//                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"已识别此二维码内容为："
//                                                            message:metadata.stringValue
//                                                           delegate:self
//                                                  cancelButtonTitle:@"取消"
//                                                  otherButtonTitles:@"复制内容", nil];
//                av.delegate=self;
//                _erweima=metadata.stringValue;
//                [av show];
            }

           
         //   DMLog(@"----%@",metadata.stringValue);


            break;
        }else if([metadata.type isEqualToString:@""]){
            [self performSegueWithIdentifier:@"justSegue" sender:nil];

        }
    }
}
//
#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    

    switch (buttonIndex) {
        case 0:
            NSLog(@"--");
        {
//            [self.session startRunning];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1:
//            NSLog(@"++");
        {
            [self.session startRunning];
            UIPasteboard *pab = [UIPasteboard generalPasteboard];
            
//            NSString *string = @"测试";
            
            [pab setString:_erweima];
            
            if (pab == nil) {
                [UIAlertView alertWithTitle:@"温馨提示" message:@"复制失败" buttonTitle:nil];
                
            }else
            {
                [UIAlertView alertWithTitle:@"温馨提示" message:@"复制成功" buttonTitle:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}


#pragma mark--UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    _cancelBtn.backgroundColor=[UIColor redColor];
    _cancelBtn.frame=CGRectMake(W(140), 0, W(40), H(44));
    //        cancelBtn.backgroundColor=[UIColor redColor];
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"btn_叉叉_普通@3x.png"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [_orderNumTF addSubview:_cancelBtn];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _cancelBtn.hidden=YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_mainScrollView endEditing:YES];
    return YES;
}
#pragma mark---UIButton's way

// 点击手工录单按钮绑定的方法
-(void)putOrder
{
    //DMLog(@"++");
    _scanBtn.enabled=YES;
    [_scanBtn setImage:[UIImage imageNamed:@"ewm_nor"] forState:0];
    [_keyinBtn setImage:[UIImage imageNamed:@"fkm_clk"] forState:0];
    [self.session stopRunning];
    [_previewLayer removeFromSuperlayer];
    [_mainScrollView setContentOffset:CGPointMake(WIDTH, 0)];
    if (!_backView) {
        _backView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, H(50))];
        _backView.backgroundColor=BGMAINCOLOR;
        [_mainScrollView addSubview:_backView];
    }
    
    if (!_orderNumTF) {
        _orderNumTF=[[UITextField alloc]initWithFrame:CGRectMake(W(12), H(5), W(250), H(40))];
        _orderNumTF.layer.cornerRadius=3;
        _orderNumTF.layer.masksToBounds=YES;
        _orderNumTF.backgroundColor=[UIColor whiteColor];
        //        _orderNumTF.backgroundColor=[UIColor redColor];
        _orderNumTF.textColor=MAINCHARACTERCOLOR;
        _orderNumTF.font=[UIFont systemFontOfSize:14];
        _orderNumTF.keyboardType=UIKeyboardTypeNumberPad;
        _orderNumTF.delegate=self;
        _orderNumTF.returnKeyType=UIReturnKeyDone;
        _orderNumTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  请输入付款码" attributes:@{NSForegroundColorAttributeName: RGBACOLOR(128, 128, 128, 1)}];
        [_backView addSubview:_orderNumTF];
    }
    if (!_sureBtn) {
        _sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame=CGRectMake(kRight(_orderNumTF)+W(0), H(5), W(60), 40);
//        [_sureBtn setBackgroundImage:[UIImage imageNamed:@"btn_普通@3x.png"] forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sendOrder) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setTitleColor:RGBACOLOR(255, 97, 0, 1) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_backView addSubview:_sureBtn];
    }
    
}

// 点击扫描绑定的方法
-(void)scanOrder
{
    _scanBtn.enabled=NO;
  //  DMLog(@"scanOrder方法");
    [_scanBtn setImage:[UIImage imageNamed:@"ewm_clk"] forState:0];
    [_keyinBtn setImage:[UIImage imageNamed:@"fkm_nor"] forState:0];
    [_numKeyBoardBtn removeFromSuperview];
    [self.view endEditing:YES];
    [_mainScrollView setContentOffset:CGPointMake(0, 0)];
    _scanerView.frame=CGRectMake(20*KRatioW, 64  *KRatioH, 280*KRatioW, 280*KRatioH);
    //初始化扫码
    [self setupAVFoundation];
//    self.previewLayer.frame = CGRectMake(0, 64+H(30), WIDTH, HEIGHT-64-H(30));
    self.previewLayer.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    //    [self.session startRunning];
    [self viewDidAppear:YES];
    //[self addLayout];
}


// 发单按钮绑定的方法
-(void)sendOrder
{
    [self.view endEditing:YES];
//    _scanBtn.enabled=YES;
    if (_orderNumTF.text.length==0) {
        [_numKeyBoardBtn removeFromSuperview];
        SHOWALERTVIEW(@"请输入付款码")
    }
    else
    {
        [_numKeyBoardBtn removeFromSuperview];
        
        NSDictionary * param=@{@"inviteCode":_orderNumTF.text};
//        [RequstEngine requestHttp:@"1055" paramDic:param blockObject:^(NSDictionary *dic) {
//            DMLog(@"1055----%@",dic);
//            DMLog(@"error---%@",dic[@"errorMsg"]);
//            if ([dic[@"errorCode"] intValue]==00000) {
//                _headImgUrl=dic[@"member"][@"imgUrl"];
//                _loginName=dic[@"member"][@"loginName"];
//                _phone=dic[@"member"][@"phone"];
//                AccountViewController * VC=[[AccountViewController alloc]init];
//                VC.inviteCode=_orderNumTF.text;
//                VC.headImgUrl=_headImgUrl;
//                VC.loginName=_loginName;
//                VC.phone=_phone;
//                [self.navigationController pushViewController:VC animated:YES];
//            }
//            else
//            {
//                [UIAlertView alertWithTitle:@"温馨提示" message:dic[@"errorMsg"] buttonTitle:nil];
//            }
//        }];


    }
    
}

// 返回按钮绑定的方法
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view endEditing:YES];
    [_numKeyBoardBtn removeFromSuperview];
}

// 输入框取消按钮绑定的方法
-(void)cancel:(UIButton*)button
{
    _orderNumTF.text=nil;
}

// 点击完成按钮绑定的方法
-(void)returnKeyBoard
{
    [self.view endEditing:YES];
    [_numKeyBoardBtn removeFromSuperview];
}


#pragma mark---通知绑定的方法
- (void) keyboardShowOnDelay
{
    [self performSelector:@selector(keyboardWillShow:) withObject:nil afterDelay:0.2];
}

- (void)keyboardWillShow:(NSNotification *)note
{
    if(UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad){
        //NSArray *ws = [[UIApplication sharedApplication] windows];
        if (self.orderNumTF.keyboardType != UIKeyboardTypeNumberPad){
            return;
        }
        // locate keyboard view
        UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
        UIView* keyboard;
        CGRect appRect=[[UIScreen mainScreen] applicationFrame];
        
        for(int i=0; i<[tempWindow.subviews count]; i++) {
            keyboard = [tempWindow.subviews objectAtIndex:i];
            // keyboard view found; add the custom button to it
            if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES)||
               [[keyboard description] hasPrefix:@"<UIKeyboard"] == YES||
               [[keyboard description] hasPrefix:@"<UIInputSetContainerView"]==YES)
            {//this line is for ios8
                CGRect frame = CGRectMake(0.0f, 162.0f, 106.0f, 53.0f);
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                    frame = CGRectMake(0, appRect.size.height-33, 106.0f, 53.0f);
                }
                self.numKeyBoardBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                [self.numKeyBoardBtn setTitle:@"完成" forState:UIControlStateNormal];
                [self.numKeyBoardBtn setFrame:frame];
                [self.numKeyBoardBtn addTarget:self action:@selector(returnKeyBoard) forControlEvents:UIControlEventTouchUpInside];
                [keyboard addSubview:self.numKeyBoardBtn];
                
                break;
            }
        }
    }
}

#pragma mark---让键盘下去的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   // DMLog(@"222");
    [_mainScrollView endEditing:YES];
//
    //初始化扫码
//    [self setupAVFoundation];
}
#pragma mark - PerformSegueDelegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"sacanPrePaySegueId"]) {
        GoPrePayViewController *goPreVC = (GoPrePayViewController *)segue.destinationViewController;
        goPreVC.toMemId = (NSString *)sender;
    }
}

@end
