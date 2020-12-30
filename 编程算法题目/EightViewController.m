//
//  EightViewController.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/30.
//

#import "EightViewController.h"

@interface EightViewController ()

@property (nonatomic, assign) NSInteger initNumber;
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, assign) BOOL needZero;
@property (nonatomic, assign) BOOL needOdd;
@property (nonatomic, assign) BOOL needEven;

@end

@implementation EightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    /*
     这是最初的实现方法，很遗憾，达不到我们的效果
     思路和前面的交替输出类似，使用BOOL值和condition进行控制，可惜，出现一个问题，在zero中self.needZero为NO，但是在其他方法中self.needZero可能为YES，needZero这几个变量未同步，在ninthViewController中尝试使用多个NSCondition实现
     */
    self.title = @"多线程练习3:打印零与奇偶数";
    
    self.initNumber = 5;
    self.condition = [[NSCondition alloc] init];
    self.needZero = YES;
    self.needOdd = NO;
    self.needEven = YES;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 3;//最大并发数设置为3，共需3个线程
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
    for (int i = 0; i < self.initNumber; i ++) {
        [self.condition lock];
        if (!self.needZero) {
            [self.condition wait];
        }
        NSLog(@"--------------0");
        NSLog(@"zero 当前线程%@",[NSThread currentThread]);
        @synchronized (self) {
            self.needZero = NO;
            self.needOdd = YES;
            self.needEven = !self.needOdd;
        }
        [self.condition signal];
        [self.condition unlock];
    }
}

- (void)odd {
    for (int i = 0; i <= self.initNumber; i ++) {
        if (i %2 != 0) {
            [self.condition lock];
            if (self.needZero || self.needEven) {
                [self.condition wait];
            }
            NSLog(@"--------------%d",i);
            NSLog(@"odd 当前线程%@",[NSThread currentThread]);
            @synchronized (self) {
                self.needZero = YES;
                self.needOdd = NO;
                self.needEven = !self.needOdd;
            }
            
            [self.condition signal];
            [self.condition unlock];
        }
    }
}

- (void)even {
    //从1开始，因为0也是偶数
    for (int i = 1; i <= self.initNumber; i++) {
        if (i %2 == 0) {
            [self.condition lock];
            if (self.needZero || self.needOdd) {
                [self.condition wait];
            }
            NSLog(@"--------------%d",i);
            NSLog(@"even 当前线程%@",[NSThread currentThread]);
            @synchronized (self) {
                self.needZero = YES;
                self.needEven = NO;
                self.needOdd = !self.needOdd;
            }
            [self.condition signal];
            [self.condition unlock];
        }
    }
}
@end
