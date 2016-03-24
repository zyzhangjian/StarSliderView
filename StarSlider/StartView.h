//
//  StartView.h
//  StarSlider
//
//  Created by 张健 on 16/3/24.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StarSlider.h"

typedef void(^startNumberBlock)(NSString *);

@interface StartView : UIView

@property (nonatomic,strong) StarSlider       *sliderView;

@property (nonatomic,strong) startNumberBlock startNumber;

@property (nonatomic,strong) UILabel          *titleLabel;

- (instancetype) initWithFrame:(CGRect)frame withBlcok:(startNumberBlock)block;

@end
