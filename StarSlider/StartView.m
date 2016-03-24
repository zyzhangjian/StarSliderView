//
//  StartView.m
//  StarSlider
//
//  Created by 张健 on 16/3/24.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "StartView.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((rgbValue >> 16) & 0xFF)/255.f \
green:((rgbValue >> 8) & 0xFF)/255.f \
blue:(rgbValue & 0xFF)/255.f \
alpha:1.0f]

@implementation StartView

- (instancetype) initWithFrame:(CGRect)frame withBlcok:(startNumberBlock)block {
    
    self = [super initWithFrame:frame];
    
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 4;

        self.layer.masksToBounds = YES;
        
        self.startNumber = block;
                
        [self initUI];
        
        [self showView];
    }
    
    return self;
}

-(void)initUI {
    
    
    self.center = CGPointMake([UIApplication sharedApplication].keyWindow.frame.size.width / 2, [UIApplication sharedApplication].keyWindow.frame.size.height / 2);
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10,self.frame.size.width , 21)];
    _titleLabel.text = @"滑动以评分";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLabel];
    
    
    [self addSubview:[[StarSlider alloc] initWithFrame:CGRectMake(30, 34, self.frame.size.width - 60, 40) withBlcok:^(int start) {

        _titleLabel.text = [NSString stringWithFormat:@"%d",start];
        
    }]];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:lineView];
    
    for (int i = 0 ; i < 2; i ++) {
        
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeSystem];
        selectButton.frame = CGRectMake(i * self.frame.size.width / 2, self.frame.size.height - 50, self.frame.size.width / 2, 50);
        [selectButton setTitle:i == 0 ? @"取消" : @"评分" forState:(UIControlStateNormal)];
        [selectButton addTarget:self action:@selector(selectClick:) forControlEvents:(UIControlEventTouchUpInside)];
        selectButton.tag = i + 10;
        [selectButton setTitleColor:UIColorFromRGB(0x1c7ada) forState:(UIControlStateNormal)];
        selectButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:selectButton];
    }
}

-(void)selectClick:(UIButton*)btn {
    
    if (btn.tag == 10) {
        
        [self dismiss:self withDuration:0.15];
   
    }else{
 
        if ([_titleLabel.text isEqualToString:@"滑动以评分"] || [_titleLabel.text intValue] == 0) {
            
            _titleLabel.text = @"评分必须大于0";
            
            [self performSelector:@selector(changeTitleLabelText) withObject:nil afterDelay:2];
           
            return;
        }
        
        if (self.startNumber != nil) {
            
            self.startNumber(_titleLabel.text);
        }
        
         [self dismiss:self withDuration:0.15];
    }
    
}

-(void)changeTitleLabelText {
    
     if ([_titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]].length > 0) {

         _titleLabel.text = @"滑动以评分";
     
     }
}


-(void)dismiss :(UIView*)view withDuration:(float)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [view removeFromSuperview];
            
        }
    }];
}


-(void)showView
{
    
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    self.alpha = 0;
    
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
