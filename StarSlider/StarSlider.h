//
//  StarSlider.h
//  StarSlider
//
//  Created by Eleven Chen on 15/7/17.
//  Copyright (c) 2015年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^startValueBlcok)(int);

@interface StarSlider : UIControl

@property(nonatomic,strong)startValueBlcok startBlock;

- (instancetype) initWithFrame:(CGRect)frame withBlcok:(startValueBlcok)block;

@end
