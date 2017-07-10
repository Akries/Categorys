//
//  UIView+Alert.h
//  TTAlert
//
//  Created by tang on 2017/3/20.
//  Copyright © 2017年 tang. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Toast position key
UIKIT_EXTERN NSString *TTToastPositionCenter;
UIKIT_EXTERN NSString *TTToastPositionBottom;
UIKIT_EXTERN NSString *TTToastPositionTop;

@protocol TTAlertDelegate <NSObject>

#pragma mark - HUD
- (void)tt_showHUD;
- (void)tt_showHUDWithText:(NSString *)text;
- (void)tt_hideHUD;

#pragma mark - Toast
- (void)tt_showToastWithText:(NSString *)toText;

- (void)tt_showToastWithText:(NSString *)toText
                    position:(id)position;

- (void)tt_showToastWithText:(NSString *)toText
                 removeAfter:(NSTimeInterval)interval;

- (void)tt_showToastWithText:(NSString *)toText
                    position:(id)position
                 removeAfter:(NSTimeInterval)interval;

- (void)tt_showToastWithText:(NSString *)toText
                       title:(NSString *)title
                       image:(UIImage *)image;

- (void)tt_showToastWithText:(NSString *)toText
                       title:(NSString *)title
                       image:(UIImage *)image
                    position:(id)position
                 removeAfter:(NSTimeInterval)interval;

- (void)tt_showToastWithText:(NSString *)toText
                  afterDelay:(NSTimeInterval)interval;


#pragma mark - Alert
- (void)tt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message;

- (void)tt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                   completion:(void(^)(UIAlertAction *confirmAction))completion;

- (void)tt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                  cancelTitle:(NSString *)cancelTitle
                   completion:(void(^)(UIAlertAction *confirmAction))completion;

- (void)tt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                 confirmTitle:(NSString *)confirmTitle
                  cancelTitle:(NSString *)cancelTitle
                   completion:(void(^)(UIAlertAction *confirmAction))completion;

@end



@interface UIView (Alert)<TTAlertDelegate>

@end


@interface UIViewController (Alert)<TTAlertDelegate>

@end
