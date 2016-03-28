//
//  ViewController.m
//  20160328004-Quart2D-CleanImage
//
//  Created by Rainer on 16/3/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建一个拖动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    
    // 2.将手势添加到当前控制器视图上
    [self.view addGestureRecognizer:panGestureRecognizer];
}

/**
 *  拖动手势事件处理
 */
- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)panGestureRecognizer {
    // 1.获取当前触摸点
    CGPoint currentPoint = [panGestureRecognizer locationInView:self.view];
    
    // 2.计算当前的擦除范围
    CGFloat cleanHW = 30;
    CGFloat cleanX = currentPoint.x - cleanHW * 0.5;
    CGFloat cleanY = currentPoint.y - cleanHW * 0.5;
    
    CGRect cleanRect = CGRectMake(cleanX, cleanY, cleanHW, cleanHW);
    
    // 3.创建一个位图上下文
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0.0);
    
    // 4.将图片视图的layer层渲染到当前上下文上
    // 4.1.获取当前上鲜文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 4.2.渲染当前上下文
    [self.imageView.layer renderInContext:context];
    
    // 5.擦除图片
    CGContextClearRect(context, cleanRect);
    
    // 6.从上下文中生成图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7.关闭上下文
    UIGraphicsEndImageContext();
    
    // 8.将新图片展示在视图上
    self.imageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
