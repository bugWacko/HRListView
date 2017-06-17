//
//  ViewController.m
//  HRListView
//
//  Created by 陈晨昕 on 2017/6/14.
//  Copyright © 2017年 bugWacko. All rights reserved.
//

#import "ViewController.h"
#import "HRListView.h"

@interface ViewController ()<HRListViewDelegate>

@property (weak, nonatomic) HRListView * listView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * button = [[UIButton alloc] init];
    button.frame = CGRectMake(30, 200, ([UIScreen mainScreen].bounds.size.width - 60), 45);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * button1 = [[UIButton alloc] init];
    button1.frame = CGRectMake(30, 300, ([UIScreen mainScreen].bounds.size.width - 60), 45);
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

-(void)buttonAction:(UIButton *)sender {
    
    //判断是否已经存在
    if ([self isHaveHRListView]) return;
    
    NSArray * array = [[NSArray alloc] initWithObjects:@"123",@"123",@"123",@"123", nil];
    
    HRListView * listView = [[HRListView alloc] init];
    listView.delegate = self;
    listView.itemArray = array;
    listView.type = HRListShowTypeUp;
    listView.object = sender;
    [listView show];
    self.listView = listView;
}

-(void)buttonAction1:(UIButton *)sender {
    
    //判断是否已经存在
    if ([self isHaveHRListView]) return;
    
    NSArray * array = [[NSArray alloc] initWithObjects:@"123",@"123",@"123",@"123", nil];
    
    HRListView * listView = [[HRListView alloc] init];
    listView.delegate = self;
    listView.itemArray = array;
    listView.type = HRListShowTypeDown;
    listView.object = sender;
    [listView show];
    self.listView = listView;
}

#pragma mark - 判断是否已经存在
-(BOOL)isHaveHRListView {

    if (self.listView) {
        [self.listView dimiss];
        return YES;
    }
    return NO;
}

#pragma mark - HRListViewDelegate
-(void)HRListView:(HRListView *)view withIndex:(NSInteger)index withValue:(NSString *)value {
    NSLog(@"HRListViewDelegate : %@ - %ld - %@",[view class],index,value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
