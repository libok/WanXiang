//
//  CustomViewController.m
//  ZXingDemo
//
//  Created by Wei on 13-3-27.
//  Copyright (c) 2013年 Wei. All rights reserved.
//

#import "CustomViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QRCodeReader.h>
#import <TwoDDecoderResult.h>
#import "ZYAddPerson.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

@synthesize currentSelectImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)buttonClick:(UIButton*)sender
{
    int x = sender.tag;
    if (x == 2) {
        [self.captureSession stopRunning];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        __block CustomViewController *temp = self;
        [self presentViewController:picker animated:YES completion:^{
            //[self.captureSession stopRunning];
            temp.isScanning = NO;
        }];
        [picker release];

    }else
    {
        InPutString * tem = [[InPutString alloc]init];
        [self.navigationController pushViewController:tem animated:YES];
        [tem release];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    self.isScanning = NO;
    if (self.captureSession.running) {
        [self.captureSession stopRunning];
    }
    if (_sem)
     {
            dispatch_release(_sem);
         _xxx = 0;
     }
    _sem = dispatch_semaphore_create(0);
}
-(void)viewWillDisappear:(BOOL)animated
{
    if (self.captureSession.isRunning) {
        [self.captureSession stopRunning];
    }
    
    self.isScanning = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.isScanning = YES;
    if (self.soundToPlay != nil) {
        OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)[self soundToPlay], &beepSound);
        if (error != kAudioServicesNoError) {
            NSLog(@"Problem loading nearSound.caf");
        }
    }

}


-(void)viewDidAppear:(BOOL)animated
{
    self.isScanning  = YES;
    if (!self.captureSession.isRunning) {
        [self.captureSession startRunning];
    }
    _xxx = 1;
    dispatch_semaphore_signal(_sem);
}



-(void)setOverlayPickerView
{
    for (UIView *temp in [self.view subviews]) {
        
        for (UIButton *button in [temp subviews]) {
            
            if ([button isKindOfClass:[UIButton class]]) {
                
                [button removeFromSuperview];
                
            }
            
        }
        
        for (UIToolbar *toolbar in [temp subviews]) {
            
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                
                [toolbar setHidden:YES];
                
                [toolbar removeFromSuperview];
                
            }
            
        }
        
        
    }
    //    for (UIView *temp in [self.view subviews]) {
    //        [temp removeFromSuperview];
    //    }
    //    self.view.backgroundColor = [UIColor clearColor];
    
    //画中间的基准线
    
	_line = [[UIView alloc] init];
	_line.frame = CGRectMake(0, 85, 320, 3);
    
    _line.backgroundColor = [UIColor greenColor];
	[self.view addSubview:_line];
	[_line release];
	
    
    
    //[line release];
    
    //最上部view
    
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    upView.alpha = 0.5;
    
    upView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:upView];
    
    //用于说明的label
    
    UILabel * labIntroudction= [[UILabel alloc] init];
    
    labIntroudction.backgroundColor = [UIColor clearColor];
    
    labIntroudction.frame=CGRectMake(80, 45, 290, 50);
    
    labIntroudction.numberOfLines=2;
    
    labIntroudction.textColor=[UIColor whiteColor];
    
    labIntroudction.text=@"正在扫描二维码/条码";
    
    [self.view addSubview:labIntroudction];
    
    [labIntroudction release];
    
    [upView release];
    
    
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, 380, 320, 85)];
    
    downView.alpha = 0.5;
    
    downView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:downView];
    
    [downView release];
    
    
    
    //拐角
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 120, 300, 240)];
    imgView.image = [UIImage imageNamed:@"二维码中的一个按钮.png"];
    [self.view addSubview:imgView];
    [imgView release];
    
    
    
    //上面的两个button
    UIButton *openPhotoLib = [[UIButton alloc]init];
    
    [openPhotoLib setFrame:CGRectMake(15, 10, 50, 40)];
    [openPhotoLib setImage:[UIImage imageNamed:@"二维码上边的两个按钮1.png"] forState:UIControlStateNormal];
    //[openPhotoLib setTitle:@"取消" forState:UIControlStateNormal];
    openPhotoLib.tag = 1;
    [openPhotoLib.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    
    [openPhotoLib addTarget:self action:@selector(buttonClick:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openPhotoLib];
    [openPhotoLib release];
    
    
    
    UIButton *openPhotoLib2 = [[UIButton alloc]init];
    
    //openPhotoLib2.alpha = 0.5;
    
    [openPhotoLib2 setFrame:CGRectMake(255, 10, 50, 40)];
    [openPhotoLib2 setImage:[UIImage imageNamed:@"二维码上边的两个按钮2.png"] forState:UIControlStateNormal];
    //[openPhotoLib setTitle:@"取消" forState:UIControlStateNormal];
    
    [openPhotoLib2.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    openPhotoLib.tag = 2;
    [openPhotoLib2 addTarget:self action:@selector(buttonClick:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openPhotoLib2];
    [openPhotoLib2 release];   
    
}

- (void)viewDidLoad
{

    [self initCapture];
    //mythread = [[NSThread alloc]initWithTarget:self selector:nil object:nil];
    self.soundToPlay = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    [super viewDidLoad];
    //dispatch_queue_t tt2 = dispatch_get_global_queue(2, 0);
    _myqueue = dispatch_queue_create("movexxxx",DISPATCH_QUEUE_SERIAL);
    _sem = dispatch_semaphore_create(0);
    _xxx = 1;
        
    [self setOverlayPickerView];
    dispatch_async(_myqueue, ^{
        while(1)
        {
            if(_xxx)
            {
                static CGRect rect;
                rect = _line.frame;
                rect.origin.y += 3;
                if (rect.origin.y >= 400)
                {
                    rect.origin.y = 85;
                }
                
                dispatch_queue_t tt = dispatch_get_main_queue();
                dispatch_async(tt, ^{
                    _line.frame = rect;
                });
                [NSThread sleepForTimeInterval:0.05];
            }else{
                dispatch_semaphore_wait(_sem, DISPATCH_TIME_FOREVER);
            }
        }
    });
}

- (void)initCapture
{
    self.captureSession = [[AVCaptureSession alloc] init];
    [_captureSession release];
    AVCaptureDevice* inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!inputDevice) {
        return;
    }
    
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
    [self.captureSession addInput:captureInput];
    
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    

    dispatch_queue_t tt2 = dispatch_queue_create("myqueue",DISPATCH_QUEUE_SERIAL);
    [captureOutput setSampleBufferDelegate:self queue:tt2];
    
    NSString* key = (NSString *)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    //NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange];
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    [captureOutput setVideoSettings:videoSettings];
    [self.captureSession addOutput:captureOutput];
    [captureOutput release];
    
    NSString* preset = 0;
    if (NSClassFromString(@"NSOrderedSet") && // Proxy for "is this iOS 5" ...
        [UIScreen mainScreen].scale > 1 &&
        [inputDevice
         supportsAVCaptureSessionPreset:AVCaptureSessionPresetiFrame960x540]) {
            // NSLog(@"960");
            preset = AVCaptureSessionPresetiFrame960x540;
        }
    if (!preset) {
        // NSLog(@"MED");
        preset = AVCaptureSessionPresetMedium;
    }
    self.captureSession.sessionPreset = preset;
    
    if (!self.captureVideoPreviewLayer) {
        self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    }
    // NSLog(@"prev %p %@", self.prevLayer, self.prevLayer);
    self.captureVideoPreviewLayer.frame = self.view.bounds;
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer: self.captureVideoPreviewLayer];
    
    self.isScanning = YES;
    [self.captureSession startRunning];
}

- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (!colorSpace)
    {
        NSLog(@"CGColorSpaceCreateDeviceRGB failure");
        return nil;
    }
    
    // Get the base address of the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    // Get the data size for contiguous planes of the pixel buffer.
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
    
    // Create a Quartz direct-access data provider that uses data we supply
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize,
                                                              NULL);
    // Create a bitmap image from data supplied by our data provider
    CGImageRef cgImage =
    CGImageCreate(width,
                  height,
                  8,
                  32,
                  bytesPerRow,
                  colorSpace,
                  kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little,
                  provider,
                  NULL,
                  true,
                  kCGRenderingIntentDefault);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    // Create and return an image object representing the specified Quartz image
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    return image;
}

- (void)decodeImage:(UIImage *)image
{
    NSLog(@"--decodeImage-----");
    NSMutableSet *qrReader = [[NSMutableSet alloc] initWithCapacity:1];
    QRCodeReader *qrcoderReader = [[QRCodeReader alloc] init];
    [qrReader addObject:qrcoderReader];
    //[qrcoderReader release];
    Decoder *decoder = [[Decoder alloc] init];
    decoder.delegate = self;
    decoder.readers = qrReader;
    //[qrcoderReader release];
    [decoder decodeImage:image];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    [self decodeImage:image];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    __block CustomViewController *xxx = self;
    if (image) {
        self.currentSelectImage=image;
    }
    [xxx decodeImage:self.currentSelectImage];
}



-(NSString *)createUrlString:(NSString *)symbol
{
    NSRange range = [symbol rangeOfString:@"qr"];
    NSString * string = [symbol stringByReplacingCharactersInRange:range withString:@"getqr"];
    return string;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)dealloc {
    if (beepSound != (SystemSoundID)-1) {
        AudioServicesDisposeSystemSoundID(beepSound);
    }
    
    //[self stopCapture];
    
    //[result release];
    [soundToPlay release];
    //[overlayView release];
    //[readers release];
    [super dealloc];
}


/*
 作者；西瓜
 解析vcf文件
*/
-(ZYAddPerson *)parseVCardString:(NSString*)vcardString {
    NSArray *lines = [vcardString componentsSeparatedByString:@"\n"];
    ZYAddPerson *thePerson=NULL;
    for(NSString* line in lines) {
        if ([line hasPrefix:@"BEGIN"]) {
            if (thePerson) {
                [thePerson release];
                thePerson=NULL;
            }
            thePerson=[[ZYAddPerson alloc] init];
        } else if ([line hasPrefix:@"END"]) {
            if (thePerson) {
                return thePerson;
            }
        } else if ([line hasPrefix:@"N:"]) {
            NSArray *upperComponents = [line componentsSeparatedByString:@":"];
            NSArray *components = [[upperComponents objectAtIndex:1] componentsSeparatedByString:@";"];
            NSString * lastName = [components objectAtIndex:0];
            NSString * firstName = [components objectAtIndex:1];
            if (thePerson) {
                thePerson.fisrtName=firstName;
                thePerson.lastName=lastName;
            }
            NSLog(@"name %@ %@",firstName,lastName);
        } else if ([line hasPrefix:@"EMAIL:"]) {
            NSArray *components = [line componentsSeparatedByString:@":"];
            NSString * emailAddress = [components objectAtIndex:1];
            NSLog(@"emailAddress %@",emailAddress);
            if (thePerson) {
                thePerson.emailArr=emailAddress;
//                [thePerson.emailArr addObject:emailAddress];
            }
        } else if ([line hasPrefix:@"TEL:"]) {
            NSArray *components = [line componentsSeparatedByString:@":"];
            NSString *  phoneNumber = [components objectAtIndex:1];
            phoneNumber=[phoneNumber stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            phoneNumber=[phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSLog(@"phoneNumber %@",phoneNumber);
            if (thePerson) {
                thePerson.phoneNumArr=phoneNumber;
//                [thePerson.phoneNumArr addObject:phoneNumber];
            }
        } else if ([line hasPrefix:@"ORG:"]) {
            NSArray *upperComponents = [line componentsSeparatedByString:@":"];
            NSArray *components = [[upperComponents objectAtIndex:1] componentsSeparatedByString:@";"];
            NSString *  userName = [components objectAtIndex:0];
            if (thePerson) {
                thePerson.username=userName;
            }
        } else if ([line hasPrefix:@"ADR:"]) {
            NSArray *upperComponents = [line componentsSeparatedByString:@":"];
            NSString *addRess = [upperComponents objectAtIndex:1];
            if (thePerson) {
                thePerson.addRess=addRess;
            }
        } else if ([line hasPrefix:@"TITLE:"]) {
            NSArray *upperComponents = [line componentsSeparatedByString:@":"];
            NSString *jobTitle = [upperComponents objectAtIndex:1];
            if (thePerson) {
                thePerson.jobTitle=jobTitle;
            }
        } else if ([line hasPrefix:@"URL:"]) {
            NSArray *upperComponents = [line componentsSeparatedByString:@":"];
            NSString *url = [upperComponents objectAtIndex:1];
            if (thePerson) {
                thePerson.url =url;
            }
        }
    }
}


#pragma mark - DecoderDelegate

bool isHaveDecoder=NO;

- (void)decoder:(Decoder *)decoder didDecodeImage:(UIImage *)image usingSubset:(UIImage *)subset withResult:(TwoDDecoderResult *)result2
{
    if (isHaveDecoder) {
        return;
    }
    isHaveDecoder=YES;
    
    if (beepSound != (SystemSoundID)-1) {
        AudioServicesPlaySystemSound(beepSound);
    }
    
    if (self.captureSession.running) {
        [self.captureSession stopRunning];
    }
    
    NSLog(@"--decoder----->%@",result2.text);
    __block LYGTwoDimensionCodeModel * amodel = [[LYGTwoDimensionCodeModel alloc]init];
    amodel.isCreated = NO;
    NSString *symbolString = nil;
    if ([result2.text hasPrefix:SERVER_URL]) {
        symbolString = [result2.text lowercaseString];
    }else{
        symbolString = result2.text;
    }
    
    NSRange range               = [symbolString rangeOfString:[NSString stringWithFormat:@"%@/page/qr.aspx?type",SERVER_URL]];
    NSRange range2              = [symbolString rangeOfString:[NSString stringWithFormat:@"%@/page/page.aspx?id=",SERVER_URL]];//富媒体
    NSRange range3              = [symbolString rangeOfString:[NSString stringWithFormat:@"%@/page/lottery.aspx?id=",SERVER_URL]];
    NSRange range4              = [symbolString rangeOfString:[NSString stringWithFormat:@"河南宝丰石桥水泉"]];
    NSRange range5              = [symbolString rangeOfString:@"/vote.aspx"];
    
    //问卷调查
    if (range5.length>0) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        int uid = [LYGAppDelegate getuid];
        if (uid == 0 ) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"必须处于登录状态才能进行问卷调查" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }else
        {
            ChoujiangViewController * temp = [[ChoujiangViewController alloc]init];
            temp.urlString = [NSString stringWithFormat:@"%@/page/getvote.aspx?id=%d&uid=%d",SERVER_URL,[[[symbolString componentsSeparatedByString:@"id="] objectAtIndex:1] intValue],uid];
            temp.titleString=@"问卷调查";
            [self.navigationController pushViewController:temp animated:YES];
        }
        isHaveDecoder=NO;
    }
    else if (range.length > 0)//解密---返回
    {
        NSArray * arry          = [symbolString componentsSeparatedByString:@"="];
        NSArray * arry2         = [[arry objectAtIndex:1] componentsSeparatedByString:@"&"];
        amodel.type             = [[arry2 objectAtIndex:0] intValue];//类型
        amodel.isSecret         = YES;
        amodel.encryptedString  = symbolString;
        NSString * urlString    = [[self createUrlString:symbolString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
        __block UIView * tempView = nil;
        __block CustomViewController * tempCOntroller = self;
        if (self.presentedViewController) {
            tempView = self.presentedViewController.view;
        }else
        {
            tempView = self.view;
        }
        request.timeOutSeconds    = 20;
        [request setCompletionBlock:^{//解密返回数据
             isHaveDecoder=NO;
             [MBProgressHUD hideHUDForView:tempView animated:YES];
             NSString * responseString     = request.responseString;
             SBJSON * sb                   = [[SBJSON alloc]init];
             NSDictionary * dict           = [sb objectWithString:responseString error:nil];
             int result          = [[dict objectForKey:@"NO"] intValue];
             if (result == 0)
             {
                 UIAlertView * alert       = [[UIAlertView alloc]initWithTitle:nil message:@"在线解析失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                 [alert show];
                 [alert release];
                 [sb release];
                 return;
             }
             [tempCOntroller dismissModalViewControllerAnimated:NO];
             tempCOntroller.isScanning = NO;
             NSString*     resultString       = [dict objectForKey:@"content"];
             NSDictionary*   contetDict       = [sb objectWithString:resultString error:nil];
             switch (amodel.type)
             {
                 case 0:
                 {
                     amodel.content = [contetDict objectForKey:@"content"];
                 }
                     break;
                 case 1:
                 {
                     NSLog(@"%@",request.responseString);
                     amodel.content = [contetDict objectForKey:@"url"];
                     if (![amodel.content hasPrefix:@"http://"]) {
                         amodel.content = [NSString stringWithFormat:@"http://%@",amodel.content];
                     }
                     NSLog(@"%@",amodel.content);
                 }
                     break;
                 case 2://名片
                 {
                     amodel.type=0;
                     NSString * str = [dict objectForKey:@"content"];
                     NSDictionary * contetDict = [sb objectWithString:str];
//                     amodel.content = [NSString stringWithFormat:@"%@;%@;%@;%@;%@;%@;",[contetDict objectForKey:@"xing"],[contetDict objectForKey:@"ming"],[contetDict objectForKey:@"tel"],[contetDict objectForKey:@"org"],[contetDict objectForKey:@"title"],[contetDict objectForKey:@"email"]];
                     amodel.content=        [NSString stringWithFormat:@"姓名:%@%@\n电话:%@\n邮箱:%@\n公司:%@\n网址:%@\n地址:%@\n职位:%@\n",
                                             [contetDict objectForKey:@"xing"],
                                             [contetDict objectForKey:@"ming"],
                                             [contetDict objectForKey:@"tel"],
                                             ([contetDict objectForKey:@"email"]?[contetDict objectForKey:@"email"]:@""),
                                             ([contetDict objectForKey:@"org"]?[contetDict objectForKey:@"org"]:@""),
                                             ([contetDict objectForKey:@"url"]?[contetDict objectForKey:@"url"]:@""),
                                             ([contetDict objectForKey:@"ads"]?[contetDict objectForKey:@"ads"]:@""),
                                             ([contetDict objectForKey:@"title"]?[contetDict objectForKey:@"title"]:@"")];
                 }
                     break;
                 case 3://电话
                 {
                     amodel.content = [contetDict objectForKey:@"tel"];
                 }
                     break;
                 case 4://邮件
                 {
                     amodel.content = [contetDict objectForKey:@"email"];
                 }
                     break;
                 case 5:
                 {
                     NSLog(@"%@",request.responseString);
                     SBJSON * json = [[SBJSON alloc]init];
                     NSDictionary * dict = [json objectWithString:request.responseString];
                     NSString    * ddddddd = [dict objectForKey:@"Result"];
                     NSDictionary* tempString  = [json objectWithString:ddddddd];
                     NSString        * xxx        = [tempString objectForKey:@"url"];
                     NSArray * arry = [xxx componentsSeparatedByString:@"|"];
                     MediaViewController * temp = [[MediaViewController alloc]init];
                     temp.urlString = [arry objectAtIndex:0];
                     temp.goodID                = [[arry objectAtIndex:1] intValue];
                     [self.navigationController pushViewController:temp animated:YES];
                     [temp release];
                     [json release];
                     return;
                 }
                     break;
                 case 6:
                 {
                     amodel.content = [NSString stringWithFormat:@"%@;%@",[contetDict objectForKey:@"tel"],[contetDict objectForKey:@"content"]];
                 }
                     break;
                 case 7:
                 {
                     amodel.content = [NSString stringWithFormat:@"%@;%@;%@",[contetDict objectForKey:@"content"],[contetDict objectForKey:@"pwd"],[contetDict objectForKey:@"pwdtype"]];
                 }
                     break;
                 case 8:
                 {
                     amodel.content = [contetDict objectForKey:@"content"];
                 }
                     break;
                 default:
                     break;
             }
             [sb release];
             isHaveDecoder=NO;
             [MBProgressHUD hideHUDForView:tempView animated:YES]; 
             [LYGTwoDimensionCodeDao insert:amodel];
             LYGTwoDimensionCodeDetailViewController * scan = [[LYGTwoDimensionCodeDetailViewController alloc]init];
             scan.amodel = amodel;
             [self.navigationController pushViewController:scan animated:YES];
             [scan release];
         }];
        [request setFailedBlock:^{
             isHaveDecoder=NO;
             [MBProgressHUD hideHUDForView:tempView animated:YES];             
             UIAlertView * alert       = [[UIAlertView alloc]initWithTitle:nil message:@"在线解析失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
             [alert show];
             [alert release];
             if (!tempCOntroller.presentedViewController) {
                 [tempCOntroller.captureSession startRunning];
             }
             return;
         }];
        [request startAsynchronous];
        [MBProgressHUD showHUDAddedTo:tempView message:@"网络解密中" animated:YES];
    }
    else if (range2.length > 0)//富媒体
    {
        isHaveDecoder=NO;
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        NSArray * arry = [result2.text componentsSeparatedByString:@"&"];
        if(arry.count <2)
        {
            return;
        }
        MediaViewController * temp = [[MediaViewController alloc]init];
        temp.urlString = [arry objectAtIndex:0];
        temp.goodID                = [[arry objectAtIndex:1] intValue];
        temp.shopID                = [[arry objectAtIndex:2] intValue];
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];  
    }
    else if (range3.length > 0)//抽奖
    {
        isHaveDecoder=NO;
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        NSArray * arry = [result2.text componentsSeparatedByString:@"id="];
        int uid = [LYGAppDelegate getuid];
        if (uid == 0 ) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"必须处于登录状态才能抽奖" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }else
        {
            ChoujiangViewController * temp = [[ChoujiangViewController alloc]init];
            temp.urlString = [NSString stringWithFormat:@"%@/page/getlottery.aspx?id=%@&uid=%d",SERVER_URL,[arry lastObject],uid];
            temp.titleString=@"抽奖";
            [self.navigationController pushViewController:temp animated:YES];
        }
        
    }
    else if (range4.length > 0)//测试
    {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"版权所有" message:@"制作人：刘永刚  电话 18638572661" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    else if([symbolString hasPrefix:@"y"] || [symbolString hasPrefix:@"p"] || [symbolString hasPrefix:@"q"] || [symbolString hasPrefix:@"L"] || [symbolString hasPrefix:@"d"])//其它判断
    {
        isHaveDecoder=NO;
        YanZhengViewController * temp = [[YanZhengViewController alloc]init];
         NSString * tempstr = nil;
        if ([result2.text hasPrefix:@"y"]) {
            tempstr = @"/api/pz/yh.aspx?key=";
        }else if ([result2.text hasPrefix:@"p"]){
            tempstr = @"/api/pz/pz.aspx?key=";
        }else if ([result2.text hasPrefix:@"q"]){
            tempstr = @"/api/pz/qd.aspx?key=";
        }else if ([result2.text hasPrefix:@"L"]){
            tempstr = @"/api/pz/lp.aspx?key=";
        }else if ([result2.text hasPrefix:@"d"]){
            tempstr = @"/api/pz/yd.aspx?key=";
        }
        temp.urlString = [NSString stringWithFormat:@"%@%@%@",SERVER_URL,tempstr,symbolString];
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
    }
    else//来自其它软件的二维码或者本软件产生的未被加过密的二维码；
    {
        isHaveDecoder=NO;
        [self dismissModalViewControllerAnimated:NO];
        if ([symbolString canBeConvertedToEncoding:NSShiftJISStringEncoding])
        {
            NSString * str = [NSString stringWithCString:[result2.text cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            amodel.content = str;  
        }
        if(!amodel.content)
        {
            amodel.content = [symbolString stringByReplacingPercentEscapesUsingEncoding:kCFStringEncodingGB_18030_2000];
        }
        if(!amodel.content)
        {
            amodel.content    = symbolString;
        }
        if ([amodel.content hasPrefix:@"http"]) {
            amodel.type       = 1;
        }else{
            amodel.type       = 0;
        }
        amodel.isCreated  = NO;
        amodel.isSecret   = NO;
        if (self.currentSelectImage) {
            amodel.erweimaImage=self.currentSelectImage;
        }
        // 6 短信 7 wifi
        if ([result2.text hasPrefix:@"BEGIN:VCARD"]) {
            ZYAddPerson  *thePerson=[self parseVCardString:symbolString];
            amodel.content=[NSString stringWithFormat:@"姓名:%@%@\n电话:%@\n邮箱:%@\n公司:%@\n网址:%@\n地址:%@\n职位:%@\n",
                            thePerson.lastName,
                            thePerson.fisrtName,
                            thePerson.phoneNumArr,
                            thePerson.emailArr,
                            thePerson.username,
                            thePerson.url,
                            thePerson.addRess,
                            thePerson.jobTitle];
        }
        
        [LYGTwoDimensionCodeDao insert:amodel];
        LYGTwoDimensionCodeDetailViewController * scan = [[LYGTwoDimensionCodeDetailViewController alloc]init];
        scan.amodel = amodel;
        [self.navigationController pushViewController:scan animated:YES];
        [scan release];
    }
}

- (void)decoder:(Decoder *)decoder failedToDecodeImage:(UIImage *)image usingSubset:(UIImage *)subset reason:(NSString *)reason
{
    if (!self.isScanning && !self.captureSession.isRunning) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有发现二维码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.isScanning = YES;
    [self.captureSession startRunning];
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
