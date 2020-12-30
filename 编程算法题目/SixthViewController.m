//
//  SixthViewController.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/23.
//

#import "SixthViewController.h"

@interface SixthViewController ()

@property (nonatomic, strong) NSLock *lock;

@end

@implementation SixthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"多线程按序打印二";
    
    /*
     使用detchNewThreadWithBlock并不能保证输出顺序固定，除了加锁，目前找不到其他适合的方法
     */
//    [NSThread detachNewThreadWithBlock:^{
//        [self first];
//    }];
//
//    [NSThread detachNewThreadWithBlock:^{
//        [self third];
//    }];
//
//    [NSThread detachNewThreadWithBlock:^{
//        [self second];
//    }];
    
    /*
     使用GCD实现控制输出顺序，多线程按照顺序输出first,third,second
     */
//    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
//    //这里不能使用dispatch_get_main_queue,因为当前线程就是main线程，使用dispatch_get_main_queue的话，队列时同步队列，加入的话需要等待viewDidload方法执行完毕，然而viewDidload执行完毕需要dispatch_async
//    dispatch_sync(queue1, ^{
//        NSLog(@"当前的线程为%@",[NSThread currentThread]);
//       //同步队列
//        /*
//         猜测可以很好的实现相应的效果，在同步队列中，所有的程序都需要在main_queue中按照顺序执行，想要执行third，应该等待执行first方法结束才行
//
//         结果猜测错误
//         queue1是同步队列，将任务1、任务2、任务3添加进队列中,任务1，任务2，任务3都另外开辟了新的线程，相当于添加了异步任务
//         同步队列按顺序执行任务1，2，3，但是因为任务1时异步任务，所以任务2不必等待任务1结束而执行，达不到按照顺序执行first（），third（），second（）方法
//         */
//        [NSThread detachNewThreadWithBlock:^{
//            [self first];
//        }];
//
//        [NSThread detachNewThreadWithBlock:^{
//            [self third];
//        }];
//
//        [NSThread detachNewThreadWithBlock:^{
//            [self second];
//        }];
//    });
    
    /*
     使用另外的方法实现，可以尝试实现的方法，开辟一个同步队列，队列中按顺序执行任务1，任务2，任务3
     这种办法可以实现效果，但是对于多线程实现，其实也就是一个线程
     */
    //虽然是自定义了一个同步队列，其实系统还是将同步队列放到main队列中，最后的3室最后输出的
//    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(queue2, ^{
//        [self first];
//        [self third];
//        [self second];
//    });
//    NSLog(@"3");
    
    /*
     尝试其他方法实现,使用异步队列的优先级,设置三个优先级，结果并不能按照我们理想的顺序输出内容,只有设置为DISPATCH_QUEUE_PRIORITY_LOW等级的会最后执行
     */
//    dispatch_queue_t queue3 = dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue3, ^{
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self third];
//        });
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//            [self second];
//        });
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            [self first];
//        });
//    });
//
    /*
     尝试使用dispatch_group来实现这个需求 这样的话完成顺序并不固定，简书中有收藏文章，dispatch_group_t可以用来实现并发网络请求，也就是在接口数据全部获取后执行下一步操作
     */
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//        [self first];
//    });
//    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//        [self third];
//    });
//    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//        [self second];
//    });
    
    /*
     下面尝试使用NSOperationQueue来实现，使用addOperation依赖来实现按顺序打印,设置并发数为1，串行队列
     */
    
//    self.lock = [[NSLock alloc] init];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    //设置最大并发数
//    queue.maxConcurrentOperationCount = 5;//这样的话就是串行队列,只会开辟一个新的线程，例如线程为6，在线程6中执行操作，设置操作数大于1，就是并行队列，执行顺序不一定，加锁的话试一下相应的结果
//    //添加操作
//    [queue addOperationWithBlock:^{
//        [self first];
//    }];
    
//    [queue addOperationWithBlock:^{
//        for (int i = 0; i < 10000; i++) {
//            i += 1;
//        }
//        [self third];
//    }];
//
//    [queue addOperationWithBlock:^{
//        [self second];
//    }];
    
    //使用addOperation操作依赖,来实现按顺序执行相应的操作方法,
    //队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 5;//这个没有影响，设置了一个线程执行，那么就只会有一个线程执行
    //操作1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        [self first];
    }];
    //操作2
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        [self third];
    }];
    //操作3
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        [self second];
    }];
    
    [operation2 addDependency:operation1];//操作2依赖于操作1，先执行操作1，才能执行操作2
    [operation3 addDependency:operation2];
    
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation1];
}

- (void)first {
//    [self.lock lock];
    NSLog(@"first");
    NSLog(@"first当前线程为%@",[NSThread currentThread]);
//    [self.lock unlock];
}

- (void)second {
//    [self.lock lock];
    NSLog(@"second");
    NSLog(@"second当前线程为%@",[NSThread currentThread]);
//    [self.lock unlock];
}

- (void)third {
//    [self.lock lock];
    NSLog(@"third");
    NSLog(@"third当前线程为%@",[NSThread currentThread]);
//    [self.lock unlock];
}

@end
