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

@end


@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"寻找两个UIView的最近公共父类";
    //寻找DView和CView的最近公共父类，一定会存在公共父类的，因为所有的类都继承于基类NSObject，而且DView和CView都属于UIView的子类
    Class DSuperClass = [DView superclass];
    while (DSuperClass != [NSObject class]) {
        [self.DArray addObject:DSuperClass];
        DSuperClass = [DSuperClass superclass];
//        if (self.DArray.count >= 6) {
//            break;
//        }
    }
    [self.DArray addObject:DSuperClass];
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
        if (success) {
            break;
        }
    }
    //这样的话，时间复杂度是O(n2)，需要进行优化
}

- (NSMutableArray *)DArray {
    if (_DArray) {
        return _DArray;
    }
    _DArray = [NSMutableArray array];
    return _DArray;
}

@end
