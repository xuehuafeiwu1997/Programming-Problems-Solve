//
//  DView.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/17.
//

#import "DView.h"

@implementation DView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor yellowColor];
}

@end
