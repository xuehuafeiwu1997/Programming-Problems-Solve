//
//  FooBar.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/30.
//

#import "FooBar.h"

@interface FooBar()

@property (nonatomic, assign) NSInteger n;
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, assign) BOOL isRunFoo;

@end

@implementation FooBar

+ (instancetype)sharedInstance {
    static FooBar *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FooBar alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.n = 3;
        self.condition = [[NSCondition alloc] init];
        self.isRunFoo = true;
    }
    return self;
}

- (void)foo {
    for (int i = 0; i < self.n; i++) {
        [self.condition lock];
        if (!self.isRunFoo) {
            [self.condition wait];
        }
        NSLog(@"i = %d,foo",i);
        NSLog(@"foo 线程:%@",[NSThread currentThread]);
        self.isRunFoo = false;
        [self.condition signal];
        [self.condition unlock];
    }
}

- (void)bar {
    for (int i = 0; i < self.n; i++) {
//        [self.lock lock];
        [self.condition lock];
        if (self.isRunFoo) {
            [self.condition wait];
        }
        NSLog(@"i = %d, bar",i);
        NSLog(@"bar 线程:%@",[NSThread currentThread]);
        self.isRunFoo = true;
        [self.condition signal];
        [self.condition unlock];
//        [self.lock unlock];
    }
}

@end
