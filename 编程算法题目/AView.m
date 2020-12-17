//
//  AView.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/17.
//

#import "AView.h"

@implementation AView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    NSLog(@"该方法执行，用来判断是否会被子类的setup所覆盖");
}

@end
