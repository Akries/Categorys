//
//  UITableView+Ext.h
//  XXDNew
//
//  Created by tang on 2017/3/27.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshTypeNew = 0, // 下拉刷新
    RefreshTypeLoadMore // 上拉加载更多
};


@interface UITableView (Ext)


@property (nonatomic, weak) MJRefreshHeader *xxd_header;
@property (nonatomic, weak) MJRefreshFooter *xxd_footer;


- (void)tt_refreshRefresh:(BOOL)isRefresh
                 loadMore:(BOOL)loadMore
               completion:(void(^)(RefreshType type))typeBlock;

- (void)hideHeaderAndFooter;
- (void)showHeaderAndFooter;

- (void)removeHeaderAndFooter;

- (void)xxd_endHeader;
- (void)xxd_endFooter:(BOOL)isNoData;

/// 加载完成之后 在需要的地方重置footer状态
- (void)xxd_resetFooter;

@end
