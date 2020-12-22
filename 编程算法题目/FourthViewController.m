//
//  FourthViewController.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/18.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"不用临时变量交换两个int型整数";
//    [self solveMethod1];
//    [self solveMethod2];
    
    /*
     结果是下面的for循环一次都没有进，数组的count是NSUInteger类型的，-1与其比较时隐式转换成NSUIteger,变成了一个很大的数字
     */
    NSArray *items = @[@1,@2,@3];
    int i = -1;
    for (; i < items.count; i++) {
        NSLog(@"%d",i);
    }
}

- (void)solveMethod1 {
    int x = 6;
    int y = 18;
    x = x + y;
    y = x - y;//将x赋值给y
    x = x - y;
    NSLog(@"交换后的x = %d",x);
    NSLog(@"交换后的y = %d",y);
}

//使用异或等运算方法来实现
- (void)solveMethod2 {
    int x = 6;
    int y = 18;
    x = x ^ y;//值为2,计算出两者共同的地方
    y = x ^ y;
    x = x ^ y;
    NSLog(@"交换后的x = %d",x);
    NSLog(@"交换后的y = %d",y);
}

@end
