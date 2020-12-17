//
//  SecondViewController.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/17.
//

#import "SecondViewController.h"
#import "AView.h"
#import "BView.h"
#import "CView.h"
#import "DView.h"

@interface SecondViewController ()
@property (nonatomic, strong) NSMutableArray *DArray;
@property (nonatomic, strong) NSMutableArray *CArray;

@end


@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"寻找两个UIView的最近公共父类";
//    [self solveMethod1];//时间复杂度O(n2)
    [self solveMethod2];//时间复杂度为O(n)
    
}

- (void)solveMethod1 {
    //寻找DView和CView的最近公共父类，一定会存在公共父类的，因为所有的类都继承于基类NSObject，而且DView和CView都属于UIView的子类
    Class DSuperClass = [DView superclass];
    while (DSuperClass != nil) {
        [self.DArray addObject:DSuperClass];
        DSuperClass = [DSuperClass superclass];
    }
    NSLog(@"DView的所有的父类为%@",self.DArray);
    Class CSuperClass = [CView superclass];
    while (1) {
        BOOL success = false;
        for (int i = 0; i < self.DArray.count; i++) {
            if (CSuperClass == [self.DArray objectAtIndex:i]) {
                NSLog(@"CView和DView共同的最近父类为%@",CSuperClass);
                success = true;
                break;
            }
        }
        //当success为true时，说明已经找到相应的父类，跳出循环
        if (success) {
            break;
        }
        CSuperClass = [CSuperClass superclass];
    }
    //这样的话，时间复杂度是O(n2)，需要进行优化
}

//倒Y型链表
- (void)solveMethod2 {
    Class CSuperClass = [CView superclass];
    while (CSuperClass != nil) {
        [self.CArray addObject:CSuperClass];
        CSuperClass = [CSuperClass superclass];
    }
    
    Class DSuperClass = [DView superclass];
    while (DSuperClass != nil) {
        [self.DArray addObject:DSuperClass];
        DSuperClass = [DSuperClass superclass];
    }
    
    NSInteger count = MIN(self.CArray.count, self.DArray.count);
    Class resultClass;
    for (int i = 0; i < count; i++) {
        Class classC = [self.CArray objectAtIndex:self.CArray.count - 1 - i];
        Class classD = [self.DArray objectAtIndex:self.DArray.count - 1 - i];
        if (classC == classD) {
            resultClass = classC;
        } else {
            break;;
        }
    }
    NSLog(@"最近的公共父类为%@",resultClass);
}

- (NSMutableArray *)CArray {
    if (_CArray) {
        return _CArray;
    }
    _CArray = [NSMutableArray array];
    return _CArray;
}

- (NSMutableArray *)DArray {
    if (_DArray) {
        return _DArray;
    }
    _DArray = [NSMutableArray array];
    return _DArray;
}

@end
