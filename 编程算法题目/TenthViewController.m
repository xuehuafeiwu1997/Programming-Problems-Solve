//
//  TenthViewController.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/30.
//

#import "TenthViewController.h"

@interface TenthViewController ()

@property (nonatomic, assign) NSInteger oxygenNumber;//氧分子个数
@property (nonatomic, assign) NSInteger hydrogenNumber;//氢分子个数
@property (nonatomic, assign) NSInteger waterNumber;
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, strong) NSCondition *oxygenCondition;
@property (nonatomic, strong) NSCondition *hydrogenCondition;

@end

@implementation TenthViewController

/*
 注意点：wait和signal的写法，如果写线程wait，那么线程会停止在那里，不会再走后面的signal，
 
 另外使用dispatch_group_t只能输出一个H2O，还是使用NSCondition能很好的实现效果
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"多线程练习4:H2O生成";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //氧线程
    NSBlockOperation *oxygenOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self printH];
    }];
    
    //氢线程
    NSBlockOperation *hydrogenOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self printO];
    }];
    
    [queue addOperation:oxygenOperation];
    [queue addOperation:hydrogenOperation];
    
    //尝试使用Dispatch_group_t来完成
    self.oxygenNumber = 0;
    self.hydrogenNumber = 0;
    self.condition = [[NSCondition alloc] init];
    self.oxygenCondition = [[NSCondition alloc] init];
    self.hydrogenCondition = [[NSCondition alloc] init];
    self.waterNumber = 3;//生成3个水分子
    //创建任务组
//    dispatch_group_t group = dispatch_group_create();
//    //创建并发队列
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.xumingyang.queue", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self printH];
//    });
//
////    dispatch_group_async(group, concurrentQueue, ^{
////        [self printH];
////    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self printO];
//    });
//
//    //GCD通知中的方法，告诉两个任务完毕
//    dispatch_group_notify(group, concurrentQueue, ^{
//        NSLog(@"生成一个水分子");
//    });
}

- (void)printH {
    for (int i = 0; i < 2 * self.waterNumber; i++) {
        [self.hydrogenCondition lock];
        self.hydrogenNumber++;
        NSLog(@"H");
//        NSLog(@"H  i = %d,当前的线程为%@", i,[NSThread currentThread]);
        if (self.hydrogenNumber == 2 && self.oxygenNumber == 1) {
            self.hydrogenNumber = 0;
            self.oxygenNumber = 0;

            [self.oxygenCondition wait];
            [self.hydrogenCondition signal];
        } else if (self.hydrogenNumber == 2) {
            [self.oxygenCondition signal];//执行氧元素的输出
            [self.hydrogenCondition wait];
        } else {
        }
        [self.hydrogenCondition unlock];
    }
}

- (void)printO {
    for (int i = 0; i < 1 * self.waterNumber; i++) {
        [self.oxygenCondition lock];
        //氧元素可能比H先输出，再加个判断
        if (self.hydrogenNumber != 2) {
            [self.oxygenCondition wait];
        }
        self.oxygenNumber++;
        NSLog(@"O");
//        NSLog(@"O 当前的线程为%@",[NSThread currentThread]);
        if (self.oxygenNumber == 1 && self.hydrogenNumber == 2) {
            self.oxygenNumber = 0;
            self.hydrogenNumber = 0;
            NSLog(@"输出一个H2O水元素-----------------------");
            
            [self.hydrogenCondition signal];//wait要写在后面，因为wait代表线程停止在这里，不会再走后面的signal
            [self.oxygenCondition wait];
        }
        [self.oxygenCondition unlock];
    }
}


@end
