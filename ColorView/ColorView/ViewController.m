//
//  ViewController.m
//  ColorView
//
//  Created by cheyipai.com on 16/12/12.
//  Copyright © 2016年 kong. All rights reserved.
//

#import "ViewController.h"
#import "KGradientView.h"

@interface ViewController () {

    KGradientView *gradientView;
}
@property (nonatomic,strong) UIScrollView *scrollerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollerView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollerView];
    
    gradientView = [[KGradientView alloc] initWithFrame:self.view.bounds];
    [self.scrollerView addSubview:gradientView];

    
    UILabel *text1Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, 100, 50)];
    text1Label.text = @"渐变类型";
    [self.scrollerView addSubview:text1Label];
    
    
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 180, text1Label.frame.origin.y , 150, 30)];
    [control insertSegmentWithTitle:@"线性渐变" atIndex:0 animated:YES];
    [control insertSegmentWithTitle:@"圆形渐变" atIndex:1 animated:YES];
    [control addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.scrollerView addSubview:control];
    
    
    
    
    
    UILabel *text2Label = [[UILabel alloc] initWithFrame:CGRectMake(0, text1Label.frame.origin.y + text1Label.frame.size.height, 200, 50)];
    text2Label.text = @"填充起始点之前的区域";
    [self.scrollerView addSubview:text2Label];
    
    UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, text2Label.frame.origin.y,70 , text2Label.frame.size.height)];
    [switch1 addTarget:self action:@selector(switch1:) forControlEvents:UIControlEventValueChanged];
    [self.scrollerView addSubview:switch1];
    
    
    
    UILabel *text3Label = [[UILabel alloc] initWithFrame:CGRectMake(0, text2Label.frame.origin.y + text2Label.frame.size.height, 200, 50)];
    text3Label.text = @"填充结束点之后的区域";
    [self.scrollerView addSubview:text3Label];
    
    UISwitch *switch2 = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, text3Label.frame.origin.y,70 , text3Label.frame.size.height)];
    [switch2 addTarget:self action:@selector(switch2:) forControlEvents:UIControlEventValueChanged];
    [self.scrollerView addSubview:switch2];
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)switch1:(UISwitch *)sw {

    NSLog(@"switch1起始点");

    gradientView.beforeStart = sw.isOn;
}
- (void)switch2:(UISwitch *)sw {
    
    
    NSLog(@"switch2");
    gradientView.afterEnd = sw.isOn;
    
}
- (void)change:(UISegmentedControl *)seg {


    gradientView.type = seg.selectedSegmentIndex;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
