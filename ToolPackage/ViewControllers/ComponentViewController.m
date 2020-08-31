//
//  ComponentViewController.m
//  ToolPackage
//
//  Created by xing on 2020/7/6.
//  Copyright © 2020 xing. All rights reserved.
//

#import "ComponentViewController.h"
#import "VerticalButton.h"

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
