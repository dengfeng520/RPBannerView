//
//  RPBannerView.m
//  RPBannerView
//
//  Created by rp.wang on 2019/9/6.
//  Copyright © 2019 Xi'an Boxin Information Technology Co., Ltd. All rights reserved.
//

#import "RPBannerView.h"

@interface RPBannerView ()

@property (strong, nonatomic) UILabel *contextLab;
///判断视图是否已经加载
@property (nonatomic, assign, getter=hasFinished) BOOL finished;

@end

@implementation RPBannerView

+ (instancetype)showWithMode:(bannerMode)mode body:(NSString *)context {
    return [RPBannerView showWithMode:mode body:context isView:[RPBannerView convertWindow] isTime:2];
}
+ (instancetype)showWithMode:(bannerMode)mode body:(NSString *)context isView:(UIView *)view {
    return [RPBannerView showWithMode:mode body:context isView:view isTime:2];
}
+ (instancetype)showWithMode:(bannerMode)mode body:(NSString *)context isTime:(CGFloat)time {
    return [RPBannerView showWithMode:mode body:context isView:[RPBannerView convertWindow] isTime:time];
}
+ (instancetype)showWithMode:(bannerMode)mode body:(NSString *)context isView:(UIView *)view isTime:(CGFloat)time {
    if (view == nil) {
        view = [RPBannerView convertWindow];
    }
    
    if ([RPBannerView bannerForView:view] != nil) {
        return nil;
    }
    __block RPBannerView *toastView = [[RPBannerView alloc] initWithMode:mode];
    
    [view addSubview:toastView];
    toastView.translatesAutoresizingMaskIntoConstraints = false;
    [[toastView.heightAnchor constraintGreaterThanOrEqualToConstant:26] setActive:true];
    NSLayoutConstraint *top;
    if (@available(iOS 11.0, *)) {
        top = [toastView.topAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.topAnchor constant:-26];
    } else {
        // Fallback on earlier versions
        top = [toastView.topAnchor constraintEqualToAnchor:view.topAnchor constant:-26];
    }
    [top setActive:true];
    [[toastView.centerXAnchor constraintEqualToAnchor:view.centerXAnchor constant:0] setActive:true];
    [[toastView.widthAnchor constraintGreaterThanOrEqualToConstant:100] setActive:true];
    [[toastView.widthAnchor constraintLessThanOrEqualToAnchor:view.widthAnchor multiplier:1] setActive:true];
    
    
    toastView.contextLab.text = [NSString stringWithFormat:@"%@",context];
    toastView.finished = true;
    
    
    [toastView.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        top.constant = 10;
        [toastView.superview layoutIfNeeded];
    } completion:nil];
    
    
    if (!time || time == 0) {
        time = 2;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            top.constant = -50;
            [toastView.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            toastView.finished = false;
            [toastView removeFromSuperview];
        }];
    });
    
    return toastView;
}

- (void)dealloc {
    printf("\n========================dealloc");
}

- (instancetype)initWithMode:(bannerMode)mode {
    self = [super init];
    if (self) {
        UIView *rootView = [[UIView alloc] init];
        [self addSubview:rootView];
        rootView.translatesAutoresizingMaskIntoConstraints = false;
        [[rootView.heightAnchor constraintEqualToConstant:26] setActive:true];
        [[rootView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:0] setActive:true];
        [[rootView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0] setActive:true];
        [[rootView.widthAnchor constraintGreaterThanOrEqualToConstant:100] setActive:true];
        [[rootView.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor multiplier:0.8] setActive:true];
        
        
        self.contextLab = [[UILabel alloc] init];
        [rootView addSubview:self.contextLab];
        self.contextLab.translatesAutoresizingMaskIntoConstraints = false;
        [[self.contextLab.leftAnchor constraintEqualToAnchor:rootView.leftAnchor constant:15] setActive:true];
        [[self.contextLab.rightAnchor constraintEqualToAnchor:rootView.rightAnchor constant:-15] setActive:true];
        [[self.contextLab.heightAnchor constraintEqualToConstant:26] setActive:true];
        [[self.contextLab.widthAnchor constraintGreaterThanOrEqualToConstant:100] setActive:true];
        [[self.contextLab.widthAnchor constraintLessThanOrEqualToAnchor:rootView.widthAnchor constant:1] setActive:true];
        self.contextLab.numberOfLines = 1;
        self.contextLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
        self.contextLab.textColor = UIColor.whiteColor;
        self.contextLab.textAlignment = NSTextAlignmentCenter;
        
        
        rootView.layer.masksToBounds = true;
        rootView.layer.cornerRadius = 13;
        if (mode == warningMode) {
            rootView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:73.0/248.0 blue:73.0/255.0 alpha:1];
        } else if (mode == successMode) {
            rootView.backgroundColor = [UIColor colorWithRed:((float)((0x3ecda1 & 0xFF0000) >> 16))/255.0f green:((float)((0x3ecda1 & 0xFF00) >> 8))/255.0f blue:((float)(0x3ecda1 & 0xFF))/255.0f alpha:1.0f];
        } else {
            rootView.backgroundColor = [UIColor colorWithRed:48.0/255.0 green:48.0/248.0 blue:48.0/255.0 alpha:1];
        }
    }
    return self;
}

+ (UIWindow *)convertWindow {
    UIApplication *application = [UIApplication sharedApplication];
    if ([application.delegate respondsToSelector:@selector(window)]) {
        return [application.delegate window];
    } else {
        return [application keyWindow];
    }
}

+ (RPBannerView *)bannerForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            RPBannerView *hud = (RPBannerView *)subview;
            if (hud.hasFinished == true) {
                return hud;
            }
        }
    }
    return nil;
}


@end
