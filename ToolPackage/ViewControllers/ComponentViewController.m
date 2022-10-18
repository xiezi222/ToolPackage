//
//  ComponentViewController.m
//  ToolPackage
//
//  Created by xing on 2020/7/6.
//  Copyright © 2020 xing. All rights reserved.
//

#import "ComponentViewController.h"
#import "VerticalButton.h"
#import "UIImage+Category.h"

@interface ComponentViewController ()
@property (weak, nonatomic) IBOutlet VerticalButton *button;

@end

@implementation ComponentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.button setTitle:@"123333333" forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    self.button.interval = 20;
    
    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"IMG_1261" withExtension:@"HEIC"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDate *start = [NSDate date];
    NSData *newData = [UIImage compressWithData:data];
    NSDate *end = [NSDate date];
    NSTimeInterval interval = [end timeIntervalSinceDate:start];
    NSLog(@"compressWithData: old:%lu, new:%lu, time:%f", data.length, newData.length, interval);

    
    
    UIImage *image = [UIImage imageWithData:data];
    UIImage *newImage = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUp];
    
    NSLog(@"compressWithData");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"2" withExtension:@"HEICs"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    NSDate *start = [NSDate date];
    NSData *newData = [UIImage fixOrientation:data];
    NSDate *end = [NSDate date];
    UIImage *newImage = [UIImage imageWithData:newData];
    NSTimeInterval interval = [end timeIntervalSinceDate:start];
    NSLog(@"fixOrientation: old:%lu, new:%lu, time:%f", data.length, newData.length, interval);
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
