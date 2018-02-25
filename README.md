iOS常用的转场方式包括push,Modal等
本文介绍自定义Modal转场动画来实现展示小菜单功能
效果图如下:

![modal.gif](http://upload-images.jianshu.io/upload_images/2954364-fd1a3b8579dd8abd.gif?imageMogr2/auto-orient/strip)

功能由四个类组成,分别是:
ViewController: 根控制器
HXPopoverAnimator: 自定义Modal动画管理者
HXJumpViewController: 要弹出的控制器(小菜单)
HXPresentationController:管理弹出小菜单HXJumpViewControllergit
github代码:https://github.com/huberyhx/HXCustomModal.git

- 首先是主控制器界面ViewController
控制器非常简单,设置导航条的titleView后监听titleView的点击弹出jumpVc
jumpVc是将要Modal出来的控制器
HXPopoverAnimator是自定义用来管理转场动画的类,我会在下面介绍
需要注意的是这句:jumpVc.modalPresentationStyle = UIModalPresentationCustom;
这句的作用是让新控制器Modal出来之后新控制器下面的旧控制器依然显示
如果不设置是不显示的
因为我们新Modal出来的控制器是一个菜单,他并不是全屏显示
所以如果不让旧控制器显示,后果将不堪设想….
我们平时正常的Modal展示出的控制器都是占据整个屏幕所以旧控制器就算不显示也不会有影响
弹出后效果图:
![结构图.jpeg](http://upload-images.jianshu.io/upload_images/2954364-b023722c7dbdf9b0.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
-(void)setUpTitleView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"菜单" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}
-(void)btnClick{
    //创建弹出的控制器
    HXJumpViewController *jumpVc = [[HXJumpViewController alloc]init];
    //设置modal的样式  默认是UIModalPresentationNone:该控制器后面的控制器不会显示
    jumpVc.modalPresentationStyle = UIModalPresentationCustom;
    //设置弹出View的frame 是自定义的属性
    self.popoverAnimator.presentFrame = CGRectMake(100, 55, 180, 250);
    //设置转场代理transitioningDelegate来实现动画
    jumpVc.transitioningDelegate = self.popoverAnimator;
    [self presentViewController:jumpVc animated:YES completion:nil];
}
//懒加载 
//这里的popoverAnimator一定要是强引用
//不然等btnClick 执行结束后 popoverAnimator销毁了,就不会执行popoverAnimator中定义的dismiss代理方法,我就被坑了...
-(HXPopoverAnimator *)popoverAnimator{
    if (!_popoverAnimator) {
        _popoverAnimator = [[HXPopoverAnimator alloc]init];
    }
    return _popoverAnimator;
}
```

- 然后是比较简单的HXPresentationController:
Modal的实现原理是:把将要弹出控制器的View塞进UIPresentationController里面弹出
所以自定义Modal就要自己控制UIPresentationController要做的工作
UIPresentationController做的很简单,只做两件事:
1:添加手势View监听点击dismiss自己
2:设置弹出View的Frame效果图可参考上图
代码如下:
```
-(void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    //在这里设置弹出View的Frame
    self.presentedView.frame = self.presentFrame;
    //添加手势View
    [self.containerView insertSubview:self.maskView atIndex:0];
}
-(void)tapGes{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
//懒加载背景View
-(UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        _maskView.frame = self.containerView.bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}
```
- 最后是HXPopoverAnimator:
HXPopoverAnimator是继承NSObject 
并且遵循UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning协议的类
用来管理Modal动画
这个类的代码较多,就不在文章里粘贴了,请下载demo看吧
demo中有详细的代码注释
demo地址在上面👆
也可以移步博客:
http://www.itcyz.cn/ios%E8%87%AA%E5%AE%9A%E4%B9%89%E8%BD%AC%E5%9C%BA%E5%8A%A8%E7%94%BB/

谢谢阅读
有不合适的地方请指教
喜欢请点个赞
抱拳了!
