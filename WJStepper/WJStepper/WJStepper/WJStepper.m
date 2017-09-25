//
//  WJStepper.m
//  WJStepperDemo
//
//  Created by 孙鸿吉 on 2017/9/25.
//  Copyright © 2017年 孙鸿吉. All rights reserved.
//

#import "WJStepper.h"
#import <Masonry.h>

#define ColorHex(hexValue) \
[UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface WJStepper()
@property (nonatomic, strong) UIButton *subButton;//减
@property (nonatomic, strong) UIButton *addButton;//加
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@end
@implementation WJStepper

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
- (void)layoutSubviews {
    [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(self);
        make.width.mas_equalTo(self.bounds.size.width * 0.3);
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(self);
        make.width.mas_equalTo(self.bounds.size.width * 0.3);
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(self.subButton.mas_right);
        make.width.mas_equalTo(0.5);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.right.equalTo(self.addButton.mas_left);
        make.width.mas_equalTo(0.5);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(self.line1.mas_right);
        make.right.equalTo(self.line2.mas_left);
    }];
}
- (void)configUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 3;
    self.layer.borderColor = ColorHex(0x666666).CGColor;
    self.layer.borderWidth = 0.5;
    [self addSubview:self.subButton];
    [self addSubview:self.addButton];
    [self addSubview:self.infoLabel];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
    self.currentCount = 1;
    self.maxCount = 100;
    self.minCount = 1;
}
#pragma mark - Event
- (void)subButtonAction:(UIButton *)button {
    NSInteger count = [self.infoLabel.text integerValue];
    if (count == _minCount) {
        return;
    }
    self.infoLabel.text = [NSString stringWithFormat:@"%ld",count - 1];
    if (_delegate && [_delegate respondsToSelector:@selector(WJStepperTouchEndWithResult:)]) {
        [_delegate WJStepperTouchEndWithResult:[self.infoLabel.text integerValue]];
    }
}
- (void)addButtonAction:(UIButton *)button {
    NSInteger count = [self.infoLabel.text integerValue];
    if (count == _maxCount) {
        return;
    }
    self.infoLabel.text = [NSString stringWithFormat:@"%ld",count + 1];
    if (_delegate && [_delegate respondsToSelector:@selector(WJStepperTouchEndWithResult:)]) {
        [_delegate WJStepperTouchEndWithResult:[self.infoLabel.text integerValue]];
    }
}
#pragma mark - Setter 
- (void)setCurrentCount:(NSInteger)currentCount {
    _currentCount = currentCount;
    self.infoLabel.text = [NSString stringWithFormat:@"%ld",currentCount];
}
- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
}
- (void)setMinCount:(NSInteger)minCount {
    _minCount = minCount;
}
- (void)setColorStyle:(UIColor *)colorStyle {
    _colorStyle = colorStyle;
    self.layer.borderColor = colorStyle.CGColor;
    self.infoLabel.textColor = colorStyle;
    self.line1.backgroundColor = self.line2.backgroundColor = colorStyle;
    [self.subButton setImage:[self imageWithColor:colorStyle Image:[UIImage imageNamed:@"button_sub"]] forState:UIControlStateNormal];
    [self.addButton setImage:[self imageWithColor:colorStyle Image:[UIImage imageNamed:@"button_add"]] forState:UIControlStateNormal];
}
#pragma mark - Getter
- (UIButton *)subButton {
    if (!_subButton) {
        _subButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subButton setImage:[UIImage imageNamed:@"button_sub"] forState:UIControlStateNormal];
        [_subButton addTarget:self action:@selector(subButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subButton;
}
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"button_add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.textColor = ColorHex(0x333333);
        _infoLabel.textAlignment = 1;
        _infoLabel.font = [UIFont systemFontOfSize:15];
    }
    return _infoLabel;
}
- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = ColorHex(0x666666);
    }
    return _line1;
}
- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = ColorHex(0x666666);
    }
    return _line2;
}
#pragma mark - Private
- (UIImage *)imageWithColor:(UIColor *)color Image:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
