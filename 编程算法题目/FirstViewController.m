//
//  FirstViewController.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/17.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"计算100的阶乘";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    NSArray *array = [NSArray array];
    NSInteger res = MAX((NSInteger)(array.count - 1), 0);
    NSLog(@"result的结果是:%ld",(long)res);
    
//    //内存大约消耗12M
//    long long result1 = dofactorial(0, 100);
//    NSLog(@"100的阶乘使用循环实现的结果为%lld",result1);
//
    //内存大约12.5M
    long long result2 = [self recursion1:100];
    NSLog(@"100的阶乘使用递归的计算结果为%lld",result2);
}

//使用循环实现
long long dofactorial(int min, int max) {
    if (min > max) {
        return 0;
    }
    if (min == 0) {
        if (max == 0) {
            //0的阶乘是1
            return 1;
        } else {
            min = 1;
        }
    }
    long long result = 1;
    for (int i = min; i < max; i++) {
        result *= i;
        
        NSLog(@"result = %lld",result);
        if (result > INT_MAX) {
            return  -1;
        }
    }
    return result;
}

//使用递归实现
- (long long)recursion1:(NSInteger)n {
    if (n == 0) {
        return 1;
    }
    return n * [self recursion1:(n-1)];//递归公式
}

//n! = 1*2*3*...*n  0! = 1 n! = (n-1)! * n
//- (void)beginCalculate {
//    NSLog(@"开始计算100的阶乘");
//    int i = 1;
//    //改为使用double的数据类型才可以计算得出阶乘的大小
//    double result = 1.0;
//    do {
//        //使用NSInteger存储，计算100的阶乘，会因为数值太大超限，最后清零，内存大概13兆左右
//        result = result * i;
//        NSLog(@"当前的result为%ld",(long)result);
//        NSLog(@"当前的i的值为%d",i);
//        if (result >= NSIntegerMax) {
//            NSLog(@"当前的i的值为%d",i);
//        }
//        i++;
//    } while ( i < 100);
//    NSLog(@"100的阶乘为%lf",result);
//}

@end
