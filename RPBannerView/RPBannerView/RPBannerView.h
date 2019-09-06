//
//  RPBannerView.h
//  RPBannerView
//
//  Created by rp.wang on 2019/9/6.
//  Copyright © 2019 Xi'an Boxin Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RPBannerView : UIView

// MARK: - toast mode
typedef NS_ENUM(NSInteger, bannerMode) {
    warningMode,
    successMode,
    perfectionMode,
    loadingMode,
};
// TODO: 后期预留
typedef NS_ENUM(NSInteger, pathMode) {
    centerMode,
    topMode,
    bottomMode,
};

+ (instancetype)showWithMode:(bannerMode)mode body:(NSString *)context;
+ (instancetype)showWithMode:(bannerMode)mode body:(NSString *)context isTime:(CGFloat)time;
+ (instancetype)showWithMode:(bannerMode)mode body:(NSString *)context isView:(UIView *)view;
+ (instancetype)showWithMode:(bannerMode)mode body:(NSString *)context isView:(UIView *)view isTime:(CGFloat)time;
+ (RPBannerView *)bannerForView:(UIView *)view;


@end

NS_ASSUME_NONNULL_END
