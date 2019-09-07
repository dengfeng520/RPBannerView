//
//  ViewController.m
//  RPBannerView
//
//  Created by rp.wang on 2019/9/6.
//  Copyright © 2019 Xi'an Boxin Information Technology Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "RPBannerView.h"

@interface ViewController ()

@property (assign, nonatomic) NSInteger randomNum;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.randomNum = 1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.randomNum ++;
    if (self.randomNum % 2 == 0) {
        [RPBannerView showWithMode:warningMode body:@"Something went wrong,please try again." isView:self.view];
    } else if (self.randomNum % 3 == 0) {
        [RPBannerView showWithMode:perfectionMode body:@"Read data completion." isView:self.view];
    } else {
        [RPBannerView showWithMode:successMode body:@"Load all data successfully." isView:self.view];
    }
}

@end
