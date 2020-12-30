//
//  NinthViewController.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/30.
//

#import "NinthViewController.h"

@interface NinthViewController ()

@property (nonatomic, assign) NSInteger initNumber;
@property (nonatomic, strong) NSCondition *zeroConidion;
@property (nonatomic, strong) NSCondition *oddCondition;
@property (nonatomic, strong) NSCondition *evenCondition;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger current;

@end

@implementation NinthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    /*
     参考leetcode上的解题思路，使用三个condition可以解决这个问题
     */
    self.title = @"多线程练习3:打印零与奇偶数";
    
    self.initNumber = 5;
    self.zeroConidion = [[NSCondition alloc] init];
    self.oddCondition = [[NSCondition alloc] init];
    self.evenCondition = [[NSCondition alloc] init];
    self.current = 1;//1代表下一个调用odd方法，0代表调用even方法
    self.state = 0;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *opZero = [NSBlockOperation blockOperationWithBlock:^{
        [self zero];
    }];
    NSBlockOperation *opOdd = [NSBlockOperation blockOperationWithBlock:^{
        [self odd];
    }];
    NSBlockOperation *opEven = [NSBlockOperation blockOperationWithBlock:^{
        [self even];
    }];
    [queue addOperation:opZero];
    [queue addOperation:opOdd];
    [queue addOperation:opEven];
}

- (void)zero {
    for (int i = 0; i < self.initNumber; i++) {
        [self.zeroConidion lock];
        if (self.state != 0) {
            [self.zeroConidion wait];
        }
        NSLog(@"--------------0");
        NSLog(@"zero 当前线程%@",[NSThread currentThread]);
        if (self.current == 1) {
            self.state = 1;
            [self.oddCondition signal];
        } else {
            self.state = 2;
            [self.evenCondition signal];
        }
        self.current = i;
        [self.zeroConidion unlock];
    }
}

- (void)odd {
    for (int i = 0; i <= self.initNumber; i++) {
        if (i % 2 != 0) {
            [self.oddCondition lock];
            if (self.state != 1) {
                [self.oddCondition wait];
            }
            NSLog(@"--------------%d",i);
            NSLog(@"odd 当前线程%@",[NSThread currentThread]);
            self.state = 0;
            self.current = 0;
            [self.zeroConidion signal];
            [self.oddCondition unlock];
        }
    }
}

- (void)even {
    for (int i = 1; i <= self.initNumber; i++) {
        if (i % 2 == 0) {
            [self.evenCondition lock];
            if (self.state != 2) {
                [self.evenCondition wait];
            }
            NSLog(@"--------------%d",i);
            NSLog(@"even 当前线程%@",[NSThread currentThread]);
            self.state = 0;
            self.current = 1;
            [self.zeroConidion signal];
            [self.evenCondition unlock];
        }
    }
}

@end
