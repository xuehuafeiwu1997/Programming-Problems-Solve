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
    [self.fooBar foo];
    [self.fooBar bar];
}



@end
