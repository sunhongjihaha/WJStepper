//
//  WJStepper.h
//  WJStepperDemo
//
//  Created by 孙鸿吉 on 2017/9/25.
//  Copyright © 2017年 孙鸿吉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WJStepperDelegate <NSObject>

- (void)WJStepperTouchEndWithResult:(NSInteger)result;

@end

@interface WJStepper : UIView

@property (nonatomic, weak) id<WJStepperDelegate> delegate;
/**当前值(默认为1)*/
@property (nonatomic, assign) NSInteger currentCount;
/**最大值(默认100)*/
@property (nonatomic, assign) NSInteger maxCount;
/**最小值(默认1)*/
@property (nonatomic, assign) NSInteger minCount;
/**整体风格(默认灰色)*/
@property (nonatomic, strong) UIColor *colorStyle;

@end
