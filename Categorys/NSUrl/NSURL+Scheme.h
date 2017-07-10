//
//  NSURL+Scheme.h
//  XXDIOS
//
//  Created by Ak on 8/21/16.
//  Copyright © 2016 Yonsen Financial Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Scheme)

- (void)handleUrlScheme:(NSURL *)url TabbarControl:(UITabBarController *)tabbarControl Navigation:(UINavigationController *)navigation;

@end
