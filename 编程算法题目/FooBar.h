//
//  FooBar.h
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FooBar : NSObject

+ (instancetype)sharedInstance;
- (void)foo;
- (void)bar;
@end

NS_ASSUME_NONNULL_END
