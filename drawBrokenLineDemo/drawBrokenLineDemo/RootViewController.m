//
//  RootViewController.m
//  drawBrokenLineDemo
//
//  Created by MoGo on 16/2/18.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import "RootViewController.h"
#import "DrawViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface RootViewController ()
- (IBAction)drawBrokeLine:(UIButton *)sender;
@property (nonatomic , assign) BOOL torchIsOn;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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


- (IBAction)drawBrokeLine:(UIButton *)sender {
    DrawViewController *VC = [[DrawViewController alloc]init];
    [self presentViewController:VC animated:YES completion:^{
        
    }];

}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self turnTorchOn:self.torchIsOn];
//    
//    
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    
//    if (device.torchMode == AVCaptureTorchModeOff)
//    {
//        // Create an AV session
//        AVCaptureSession *session = [[AVCaptureSession alloc] init];
//        
//        // Create device input and add to current session
//        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error: nil];
//        [session addInput:input];
//        
//        // Create video output and add to current session
//        AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
//        [session addOutput:output];
//        
//        // Start session configuration
//        [session beginConfiguration];
//        [device lockForConfiguration:nil];
//        
//        // Set torch to on
//        [device setTorchMode:AVCaptureTorchModeOn];
//        
//        [device unlockForConfiguration];
//        [session commitConfiguration];
//        
//        // Start the session
//        [session startRunning];
//        
//        // Keep the session around
////        [self setAVSession:session];
//        
//    }
//    else
//    {
////        [AVSession stopRunning];
////        [AVSession release], AVSession = nil;
//    }
//    
//
//}
//
//
//- (void) turnTorchOn: (bool) on {
//    
//    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
//    if (captureDeviceClass != nil) {
//        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//        if ([device hasTorch] && [device hasFlash]){
//            
//            [device lockForConfiguration:nil];
//            if (on) {
//                [device setTorchMode:AVCaptureTorchModeOn];
//                [device setFlashMode:AVCaptureFlashModeOn];
//                _torchIsOn = YES;
//            } else {
//                [device setTorchMode:AVCaptureTorchModeOff];
//                [device setFlashMode:AVCaptureFlashModeOff];
//                _torchIsOn = NO;
//            }
//            [device unlockForConfiguration];
//        }
//    }
//}
@end
