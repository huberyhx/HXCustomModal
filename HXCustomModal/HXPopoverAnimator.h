//
//  HXPopoverAnimator.h
//  HXCustomModal
//
//  Created by XIU-Developer on 2016/10/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//UIViewControllerTransitioningDelegate 转场代理
@interface HXPopoverAnimator : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CGRect presentFrame;
@end
