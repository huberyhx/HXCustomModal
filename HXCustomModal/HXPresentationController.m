//
//  HXPresentationController.m
//  HXCustomModal
//
//  Created by XIU-Developer on 2016/10/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "HXPresentationController.h"

@interface HXPresentationController()
@property (nonatomic, assign) BOOL  isPresent;
@property (nonatomic, strong) UIView *maskView;//蒙版用于监听点击屏幕 dismiss自己
@end

@implementation HXPresentationController
- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    //设置弹出View的Frame
    self.presentedView.frame = self.presentFrame;
    //添加手势View
    [self.containerView insertSubview:self.maskView atIndex:0];
}

- (void)tapGes{
//    self.presentingViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//懒加载
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        _maskView.frame = self.containerView.bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

@end
