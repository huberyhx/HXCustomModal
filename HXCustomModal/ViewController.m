//
//  ViewController.m
//  HXCustomModal
//
//  Created by XIU-Developer on 2016/10/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "HXPopoverAnimator.h"
#import "HXPresentationController.h"
#import "HXJumpViewController.h"

@interface ViewController ()
@property (nonatomic, strong) HXPopoverAnimator *popoverAnimator;
@end

@implementation ViewController

- (HXPopoverAnimator *)popoverAnimator{
    if (!_popoverAnimator) {
        _popoverAnimator = [[HXPopoverAnimator alloc]init];
    }
    return _popoverAnimator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置titleView
    [self setUpTitleView];
}

- (void)setUpTitleView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"菜单" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}

- (void)btnClick{
//    //创建弹出的控制器
    HXJumpViewController *jumpVc = [[HXJumpViewController alloc]init];
    //设置modal的样式  默认是UIModalPresentationNone:该控制器后面的控制器不会显示
    jumpVc.modalPresentationStyle = UIModalPresentationCustom;
    
    
    //设置弹出View的frame
    self.popoverAnimator.presentFrame = CGRectMake(100, 55, 180, 250);
    //设置转场代理
    jumpVc.transitioningDelegate = self.popoverAnimator;
    [self presentViewController:jumpVc animated:YES completion:nil];
    
//    UIViewController *a = [[UIViewController alloc]init];
//    a.modalPresentationStyle = UIModalPresentationCustom;
//    a.view.backgroundColor = [UIColor redColor];
//    [self presentViewController:a animated:YES completion:nil];
}

@end
