//
//  FifthViewController.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/18.
//

#import "FifthViewController.h"

@interface FifthViewController ()

@property (nonatomic, strong) NSLock *lock;

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"多线程按序打印";
    
    //按照一三二的顺序打印输出
    /*
     1.第一种方法
     这样写的话number = 1，name = main，在主线程中运行，按照一三二的顺序打印输出
     */
//    [self first];
//    [self third];
//    [self second];
    
    //2.第二种方法，NSThread的信号量,创建三个不同的线程，如果不做处理，三者的执行顺序无法确定，所以为了使其执行顺序固定
    //可以使用lock，unlock，保证输出的顺序
    /*
     不能使用lock unlock 锁住NSthread detachNewThreadSelecor放法，这样处理的话会输出first third 1当前的线程为。3当前的线程为
     一个方法中的连续两个输出不一定能保证顺序
     
     使用lock unlock锁住每个方法内部
     
     NSLock：在线程A调用unlock之前，另一个线程B调用了同一个锁对象的lock方法，那么线程B只有等待，直到线程A调用了unlock方法
     
     */
    
    self.lock = [[NSLock alloc] init];
    
    [NSThread detachNewThreadSelector:@selector(first) toTarget:self withObject:nil];
    
    [NSThread detachNewThreadSelector:@selector(third) toTarget:self withObject:nil];
    
    [NSThread detachNewThreadSelector:@selector(second) toTarget:self withObject:nil];
    
}

- (void)first {
    [self.lock lock];
    NSLog(@"first");
    NSLog(@"1当前的线程为%@",[NSThread currentThread]);
    [self.lock unlock];
}

- (void)second {
    [self.lock lock];
    NSLog(@"second");
    NSLog(@"2当前的线程为%@",[NSThread currentThread]);
    [self.lock unlock];
}

- (void)third {
    [self.lock lock];
    NSLog(@"third");
    NSLog(@"3当前的线程为%@",[NSThread currentThread]);
    [self.lock unlock];
}

@end
