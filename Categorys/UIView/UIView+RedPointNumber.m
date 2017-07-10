//
//  UIImageView+RedPointNumber.m
//  mytest
//
//  Created by 李胜书 on 15/7/22.
//  Copyright (c) 2015年 李胜书. All rights reserved.
//

#import "UIView+RedPointNumber.h"

@implementation UIView(RedPointNumber)

- (void)imageWithRedPoint {
    UILabel *pointView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
    pointView.backgroundColor = [UIColor redColor];
    [pointView imageWithRound:NO];
    pointView.center = CGPointMake(self.frame.size.width-3, 3);
    [self addSubview:pointView];
}

- (void)imageWithRedNumber:(NSInteger)number {
    UILabel *numberView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    numberView.backgroundColor = [UIColor redColor];
    numberView.tag = 99;
    [numberView imageWithRound:NO];
    numberView.center = CGPointMake(self.frame.size.width-3-8, 23+10);
    numberView.text = [NSString stringWithFormat:@"%ld",(long)number];
    numberView.textAlignment = NSTextAlignmentCenter;
    numberView.font = [UIFont systemFontOfSize:15.0];
    numberView.textColor = [UIColor whiteColor];
    [self addSubview:numberView];
}

- (void)imageWithRedNumberUp:(NSInteger)number {
    UILabel *numberView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    numberView.backgroundColor = [UIColor redColor];
    numberView.tag = 99;
    [numberView imageWithRound:NO];
    numberView.center = CGPointMake(self.frame.size.width-3, 3);
    numberView.text = [NSString stringWithFormat:@"%ld",(long)number];
    numberView.textAlignment = NSTextAlignmentCenter;
    numberView.font = [UIFont systemFontOfSize:15.0];
    numberView.textColor = [UIColor whiteColor];
    [self addSubview:numberView];
}

- (void)imageRemoveRedNumber {
    [[self viewWithTag:99] removeFromSuperview];
}

-(void)imageWithRedNumber:(NSInteger)number Radio:(float)radio FontFloat:(float)fontFloat {
    UILabel *numberView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, radio, radio)];
    numberView.backgroundColor = [UIColor redColor];
    [numberView imageWithRound:NO];
    numberView.center = CGPointMake(self.frame.size.width-3, 3);
    numberView.text = [NSString stringWithFormat:@"%ld",(long)number];
    numberView.textAlignment = NSTextAlignmentCenter;
    numberView.font = [UIFont systemFontOfSize:fontFloat];
    numberView.textColor = [UIColor whiteColor];
    [self addSubview:numberView];
}

@end
