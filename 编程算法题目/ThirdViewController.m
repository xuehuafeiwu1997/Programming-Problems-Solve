//
//  ThirdViewController.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/17.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

#define Mouse_NUM 4

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     有15个瓶子，其中最多有一瓶有毒，现在有四只老鼠，喝了有毒的水之后，第二天就会死。如何在第二天就可以判断出哪个瓶子有毒
     */
    self.title = @"老鼠死亡问题";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self solveMethod];
}

- (void)solveMethod {
    //老鼠最初的状态
    NSMutableArray *mouseArr = [NSMutableArray arrayWithArray:@[@0,@0,@0,@0]];
    int drug = 0;//有毒的瓶子号码
    for (int i = 0; i < Mouse_NUM; i++) {
        mouseArr[i] = @(arc4random() % 2);//随机生成四只老鼠的死亡状态
    }
    NSLog(@"四只老鼠的状态为(0代表存活，1代表死亡),%@",mouseArr);
    for (int i = 0; i < Mouse_NUM; i++) {
        drug |= [mouseArr[i] integerValue] << (Mouse_NUM - i - 1);//进行位运算
    }
    NSLog(@"drug的值为%d",drug);
    if (drug == 0) {
        NSLog(@"毒药没有毒");
    } else {
        NSLog(@"有毒的那个瓶子是%d",drug);
    }
}

@end
