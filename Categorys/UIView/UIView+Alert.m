//
//  UIView+Alert.m
//  TTAlert
//
//  Created by tang on 2017/3/20.
//  Copyright © 2017年 tang. All rights reserved.
//

#import "UIView+Alert.h"
#import <objc/runtime.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/UIView+Toast.h>

NSString *tttt = @"000";

const NSString *TTToastPositionCenter = @"CSToastPositionCenter";
const NSString *TTToastPositionBottom = @"CSToastPositionBottom";
const NSString *TTToastPositionTop    = @"CSToastPositionTop";

@implementation UIView (Alert)

#pragma mark - HUD

static void *hud_key = &hud_key;

- (void)setHUD:(MBProgressHUD *)hud {
    objc_setAssociatedObject(self, hud_key, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (MBProgressHUD *)hud {
    return objc_getAssociatedObject(self, hud_key);
}

- (void)tt_showHUD {
    [self tt_showHUDWithText:@""];
}

- (void)tt_showHUDWithText:(NSString *)text {
    MBProgressHUD *hud = self.hud;
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
//        hud.dimBackground = NO;
        hud.removeFromSuperViewOnHide = YES;
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self setHUD:hud];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    hud.label.text = text;
    [hud showAnimated:YES];
}

- (void)tt_hideHUD {
    [self.hud hideAnimated:NO];
}

#pragma mark - Toast

static void *toast_key = &toast_key;

- (void)setToastView:(UIView *)toView {
    objc_setAssociatedObject(self, toast_key, toView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)toastView {
    return objc_getAssociatedObject(self, toast_key);
}

- (void)tt_showToastWithText:(NSString *)toText {
    [self tt_showToastWithText:toText position:CSToastPositionCenter];
}

- (void)tt_showToastWithText:(NSString *)toText removeAfter:(NSTimeInterval)interval {
    [self tt_showToastWithText:toText position:CSToastPositionCenter removeAfter:interval];
}

- (void)tt_showToastWithText:(NSString *)toText position:(id)position {
    [self tt_showToastWithText:toText position:position removeAfter:2.0];
}

- (void)tt_showToastWithText:(NSString *)toText position:(id)position removeAfter:(NSTimeInterval)interval {
    [self tt_showToastWithText:toText title:nil image:nil position:position removeAfter:interval];
}


- (void)tt_showToastWithText:(NSString *)toText title:(NSString *)title image:(UIImage *)image {
    [self tt_showToastWithText:toText title:title image:image position:TTToastPositionCenter removeAfter:2.0];
}

- (void)tt_showToastWithText:(NSString *)toText
                       title:(NSString *)title
                       image:(UIImage *)image
                    position:(id)position
                 removeAfter:(NSTimeInterval)interval {
    if (toText.length > 0) {
        if (!self.toastView) {
            [CSToastManager setQueueEnabled:NO];
            [CSToastManager sharedStyle].backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            [CSToastManager sharedStyle].verticalPadding = 15; // 文字的垂直内边距
            [CSToastManager sharedStyle].horizontalPadding = 10; // 文字水平内边距
        }
//        UIView *keyWindow = [UIApplication sharedApplication].windows.lastObject;
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

        UIView *toastV = [keyWindow toastViewForMessage:toText title:title image:image style:nil];
        [UIView animateWithDuration:0.25 animations:^{
            self.toastView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.toastView removeFromSuperview];
            [self setToastView:toastV];
        }];
        [keyWindow showToast:toastV duration:interval position:position completion:nil];
        UIView *bgView = [[UIView alloc] initWithFrame:keyWindow.bounds];
        [keyWindow addSubview:bgView];
        [bgView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:interval];
    }
}

- (void)tt_showToastWithText:(NSString *)toText afterDelay:(NSTimeInterval)interval {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self tt_showToastWithText:toText];
    });
}

#pragma mark - Alert
- (void)tt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message {
    [self tt_showAlertWithTitle:title
                        message:message completion:nil];
}

- (void)tt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                   completion:(void (^)(UIAlertAction *))completion {
    [self tt_showAlertWithTitle:title
                        message:message
                   confirmTitle:@"确定"
                    cancelTitle:nil
                     completion:completion];
}

- (void)tt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                  cancelTitle:(NSString *)cancelTitle
                   completion:(void (^)(UIAlertAction *))completion {
    [self tt_showAlertWithTitle:title
                        message:message
                   confirmTitle:@"确定"
                    cancelTitle:cancelTitle
                     completion:completion];
}

- (void)tt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                 confirmTitle:(NSString *)confirmTitle
                  cancelTitle:(NSString *)cancelTitle
                   completion:(void(^)(UIAlertAction *))completion {
    if (cancelTitle.length == 0 && confirmTitle.length == 0) {
        return;
    }
    UIAlertAction *cancelAction;
    UIAlertAction *confirmlAction;
    if (cancelTitle.length != 0) {
        cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    }
    if (confirmTitle.length != 0) {
        confirmlAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:completion];
    }
    [self tt_showAlertWithTitle:title
                        message:message
                   cancelAction:cancelAction
                  confirmAction:confirmlAction];
}

- (void)tt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                 cancelAction:(UIAlertAction *)cancelAction
                confirmAction:(UIAlertAction *)confirmAction {
    
    if (cancelAction == nil && confirmAction == nil) return;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    cancelAction != nil ? [alertController addAction:cancelAction] : nil;
    confirmAction != nil ? [alertController addAction:confirmAction] : nil;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}


@end


@implementation UIViewController (Alert)

#pragma mark - HUD

- (void)tt_showHUD {
    [self.view tt_showHUD];
}

- (void)tt_showHUDWithText:(NSString *)text {
    [self.view tt_showHUDWithText:text];
}

- (void)tt_hideHUD {
    [self.view tt_hideHUD];
}

#pragma mark - Toast
- (void)tt_showToastWithText:(NSString *)toText {
    [self.view tt_showToastWithText:toText];
}

- (void)tt_showToastWithText:(NSString *)toText position:(id)position {
    [self.view tt_showToastWithText:toText position:position];
}

- (void)tt_showToastWithText:(NSString *)toText removeAfter:(NSTimeInterval)interval {
    [self.view tt_showToastWithText:toText removeAfter:interval];
}

- (void)tt_showToastWithText:(NSString *)toText position:(id)position removeAfter:(NSTimeInterval)interval {
    [self.view tt_showToastWithText:toText position:position removeAfter:interval];
}

- (void)tt_showToastWithText:(NSString *)toText title:(NSString *)title image:(UIImage *)image {
    [self.view tt_showToastWithText:toText title:title image:image];
}

- (void)tt_showToastWithText:(NSString *)toText title:(NSString *)title image:(UIImage *)image position:(id)position removeAfter:(NSTimeInterval)interval {
    [self.view tt_showToastWithText:toText title:title image:image position:position removeAfter:interval];
}

- (void)tt_showToastWithText:(NSString *)toText afterDelay:(NSTimeInterval)interval {
    [self.view tt_showToastWithText:toText afterDelay:interval];
}

#pragma mark - Alert
- (void)tt_showAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self.view tt_showAlertWithTitle:title message:message];
}
- (void)tt_showAlertWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(UIAlertAction *))completion {
    [self.view tt_showAlertWithTitle:title message:message completion:completion];
}

- (void)tt_showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle completion:(void (^)(UIAlertAction *))completion {
    [self.view tt_showAlertWithTitle:title message:message cancelTitle:cancelTitle completion:completion];
}

- (void)tt_showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle completion:(void (^)(UIAlertAction *confirmAction))completion {
    [self.view tt_showAlertWithTitle:title message:message confirmTitle:confirmTitle cancelTitle:cancelTitle completion:completion];
}

@end
