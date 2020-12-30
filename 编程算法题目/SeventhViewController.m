//
//  SeventhViewController.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/30.
//

#import "SeventhViewController.h"
#import "FooBar.h"

@interface SeventhViewController ()

@property (nonatomic, strong) FooBar *fooBar;

@end

@implementation SeventhViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"多线程练习2:交替输出foolBar";
    
    self.fooBar = [FooBar sharedInstance];
//    [self.fooBar foo];
//    [self.fooBar bar];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;//最大并发线程数为2
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        [self.fooBar foo];
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        [self.fooBar bar];
    }];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    
}



@end
