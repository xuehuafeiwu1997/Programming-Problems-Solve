//
//  FooBar.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/30.
//

#import "FooBar.h"

@interface FooBar()

@property (nonatomic, assign) NSInteger n;

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
    }
    return self;
}

- (void)foo {
    for (int i = 0; i < self.n; i++) {
        NSLog(@"i = %d,foo",i);
    }
}

- (void)bar {
    for (int i = 0; i < self.n; i++) {
        NSLog(@"i = %d, bar",i);
    }
}

@end
