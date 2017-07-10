//
//  UIButton (UIButtonExt).m
//  EHSYBeta
//
//  Created by 李胜书 on 16/2/19.
//  Copyright © 2016年 EHSY_SanLi. All rights reserved.
//

#import "UIButton+Ext.h"

@implementation UIButton(Ext)

- (void)centerImageAndTitle:(float)spacing {
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    CGFloat totalWidth = self.frame.size.width;
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height) + 10, 0.0, 0.0, - titleSize.width - 5);
    
    
    self.imageEdgeInsets = UIEdgeInsetsMake(8.0, (totalWidth - imageSize.width) * 0.5, titleSize.height + 5, (totalWidth - imageSize.width) * 0.5);

    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height), 0.0);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height), 0.0);


}

- (void)centerImageAndTitle {
    const int DEFAULT_SPACING = 6.0f;
    [self centerImageAndTitle:DEFAULT_SPACING];
}

- (void)centerImageAndTitleWithLayoutType:(ButtonLayoutType)layoutType {
    
    const int DEFAULT_SPACING = 6.0f;
    [self centerImageAndTitle:DEFAULT_SPACING type:layoutType];
}
// 布局button的image和title
- (void)centerImageAndTitle:(float)spacing type:(ButtonLayoutType)layoutType {
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    CGFloat totalWidth = self.frame.size.width;
    
    if (layoutType == afterAnimationLayout) {
        self.imageEdgeInsets = UIEdgeInsetsMake(5.0, (totalWidth - imageSize.width) * 0.5, titleSize.height + 5, (totalWidth - imageSize.width) * 0.5);
        self.titleEdgeInsets = UIEdgeInsetsMake(8.0, - imageSize.width, - (totalHeight - titleSize.height) + 5, 0.0);
    } else {
        self.imageEdgeInsets = UIEdgeInsetsMake(8.0, (totalWidth - imageSize.width) * 0.5, titleSize.height + 5, (totalWidth - imageSize.width) * 0.5);
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height) + 5, 0.0);

    }

}

- (void)changeButtonImageAndLabel {
    self.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    button.imageEdgeInsets = UIEdgeInsetsMake(0., button.frame.size.width - (image.size.width + 15.), 0., 0.);
//    button.titleEdgeInsets = UIEdgeInsetsMake(0., 0., 0., image.size.width);
}
@end
