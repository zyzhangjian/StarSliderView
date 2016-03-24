//
//  ViewController.m
//  StarSlider
//
//  Created by Eleven Chen on 15/7/17.
//  Copyright (c) 2015年 Eleven. All rights reserved.
//

#import "ViewController.h"

#import "StartView.h"

#import "StarSlider.h"


@interface ViewController ()
@property (nonatomic, strong) StartView* startView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];

}
- (IBAction)showScoreView:(UIButton *)sender {
    
    [[UIApplication sharedApplication].keyWindow addSubview:[[StartView alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 130) withBlcok:^(NSString *number) {
        
        NSLog(@"%@",number);
    
    }]];
}
@end
