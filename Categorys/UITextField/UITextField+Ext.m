//
//  UITextField+Ext.m
//  XXDNew
//
//  Created by tang on 2017/3/24.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import "UITextField+Ext.h"
#import <objc/runtime.h>

static void *keyboardChange       = &keyboardChange;
static void *keyOffsetSpace       = &keyOffsetSpace;
static void *keyReferView         = &keyReferView;
static void *keyOriginReViewFrame = &keyOriginReViewFrame;
static void *keyHideDuration_tf   = &keyHideDuration_tf;
static void *placeholderFontKey   = &placeholderFontKey;


@interface UITextField ()

/// 记录键盘变化
@property (nonatomic, copy) void (^changeBlock)(CGRect);
/// 记录相对于那个view的坐标 如果外界传了nil 则会以整个window作为参考
@property (nonatomic, weak) UIView *referView;
/// 记录referview的原始frame
@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, assign) CGFloat hideDuration;


@end

@implementation UITextField (Ext)

- (void)setChangeBlock:(void (^)(CGRect))changeBlock {
    objc_setAssociatedObject(self, keyboardChange, changeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(CGRect))changeBlock {
    return objc_getAssociatedObject(self, keyboardChange);
}

- (void)setOffsetSpace:(CGFloat)offsetSpace {
    objc_setAssociatedObject(self, keyOffsetSpace, @(offsetSpace), OBJC_ASSOCIATION_COPY);
}

- (CGFloat)offsetSpace {
    return [objc_getAssociatedObject(self, keyOffsetSpace) floatValue];
}

- (void)setReferView:(UIView *)referView {
    objc_setAssociatedObject(self, keyReferView, referView, OBJC_ASSOCIATION_ASSIGN);
}
- (UIView *)referView {
    return objc_getAssociatedObject(self, keyReferView);
}

- (void)setOriginFrame:(CGRect)originFrame {
    objc_setAssociatedObject(self, keyOriginReViewFrame, [NSValue valueWithCGRect:originFrame], OBJC_ASSOCIATION_COPY);
}
- (CGRect)originFrame {
    return [objc_getAssociatedObject(self, keyOriginReViewFrame) CGRectValue];
}

- (void)setHideDuration:(CGFloat)hideDuration {
    objc_setAssociatedObject(self, keyHideDuration_tf, @(hideDuration), OBJC_ASSOCIATION_COPY);
}
- (CGFloat)hideDuration {
    return [objc_getAssociatedObject(self, keyHideDuration_tf) floatValue];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    objc_setAssociatedObject(self, placeholderFontKey, placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
}

- (UIFont *)placeholderFont {
    
    return objc_getAssociatedObject(self, placeholderFontKey);
}

- (void)observeKeyboardChangeFrame:(void (^)(CGRect))changeBlock referTo:(UIView *)referView {
    self.changeBlock = changeBlock;
    self.referView = referView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (self.referView) {
        self.originFrame = self.referView.frame;
    } else {
        self.originFrame = [UIScreen mainScreen].bounds;
    }
}

#pragma mark - <Noti>
- (void)keyboardWillShow:(NSNotification *)notification {

    if (self.isFirstResponder) {
        
        CGPoint relativePoint;
        if (self.referView) {
            relativePoint = [self convertPoint: CGPointZero toView: self.referView];
            
        } else {
            relativePoint = [self convertPoint: CGPointZero toView: [UIApplication sharedApplication].keyWindow];
        }
        
        CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
        CGFloat actualHeight = CGRectGetHeight(self.frame) + relativePoint.y + keyboardHeight;
        CGFloat offset = self.offsetSpace ? self.offsetSpace : 10;// 键盘与输入框之间的距离
        CGFloat overstep = actualHeight - CGRectGetHeight([UIScreen mainScreen].bounds) + offset;
        if (overstep > 0) {
            CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            CGRect frame = [UIScreen mainScreen].bounds;
            frame.origin.y -= overstep;
            [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
                if (self.referView) {
                    if (self.changeBlock) {
                        self.changeBlock(frame);
                    }
                } else {
                    
                    [UIApplication sharedApplication].keyWindow.frame = frame;
                }
            } completion: nil];
            self.hideDuration = duration;
        }
    } else {
        
        // 多这个判断防止TextField不是第一响应者是 没有恢复referview的frame 
        if (self.hideDuration) {
            
            [UIView animateWithDuration: self.hideDuration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
                if (self.referView) {
    
                    if (self.changeBlock) {
                        self.changeBlock(self.originFrame);
                    }
                } else {
    
                    [UIApplication sharedApplication].keyWindow.frame = self.originFrame;
                }
            } completion: nil];
            self.hideDuration = 0;
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    if (self.isFirstResponder) {

        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
            if (self.referView) {
                
                if (self.changeBlock) {
                    self.changeBlock(self.originFrame);
                }
            } else {
                
                [UIApplication sharedApplication].keyWindow.frame = self.originFrame;
            }
        } completion: nil];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
