//
//  ViewController.m
//  NSNotificationCenterDemo
//
//  Created by blue on 2017/10/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "LJNotificationCenter.h"
@interface ViewController ()
@property (nonatomic,strong)SecondViewController *viewVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [button setTitle:@"Second" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goSecondVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}
- (void)goSecondVC{
    [self presentViewController:self.viewVC animated:YES completion:nil];
    NSInteger num = arc4random()%100;
    NSDictionary *dic = @{@"num":@(num)};
    [[LJNotificationCenter defaultCenter] postNotificationName:@"NSNotificationDemoLog" object:self userInfo:dic];
}
- (SecondViewController *)viewVC{
    if (!_viewVC) {
        _viewVC = [SecondViewController new];
    }
    return _viewVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
