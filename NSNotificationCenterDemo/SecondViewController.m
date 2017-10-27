//
//  SecondViewController.m
//  NSNotificationCenterDemo
//
//  Created by blue on 2017/10/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "SecondViewController.h"
#import "LJNotificationCenter.h"
@interface SecondViewController ()
@property (nonatomic,strong) UILabel *label;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [button setTitle:@"return" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnLastVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 0, 40, 40);
    label.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2-60);
    label.textColor = [UIColor redColor];
    self.label = label;
    [self.view addSubview:label];
    
    
    [[LJNotificationCenter defaultCenter] addObserver:self selector:@selector(clicked:) name:@"NSNotificationDemoLog" object:nil];
    
    [[LJNotificationCenter defaultCenter] addObserverForName:@"NSNotificationDemoLog" object:self queue:[NSOperationQueue mainQueue] usingBlock:^(LJNotification * _Nonnull note) {
        NSLog(@"1234567890");
    }];
}
- (void)returnLastVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clicked:(LJNotification*)notification{
    NSDictionary *dic = notification.userInfo;
    if ([dic.allKeys containsObject:@"num"]) {
        self.label.text = [NSString stringWithFormat:@"%ld",(long)[dic[@"num"] integerValue]];
        NSLog(@"-------- %ld",[dic[@"num"] integerValue]);
    }
}
- (void)dealloc{
    [[LJNotificationCenter defaultCenter] removeObserver:self name:@"NSNotificationDemoLog" object:nil];
    NSLog(@"SecondViewController dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
