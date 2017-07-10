//
//  UITableView+Ext.m
//  XXDNew
//
//  Created by tang on 2017/3/27.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import "UITableView+Ext.h"
#import <objc/runtime.h>

@interface UITableView ()
//@property (nonatomic, assign) void (^refreshBlock)(RefreshType);

@end

@implementation UITableView (Ext)

- (void)setXxd_header:(MJRefreshHeader *)xxd_header {
    self.mj_header = xxd_header;
}

- (MJRefreshHeader *)xxd_header {
    return self.mj_header;
}

- (void)setXxd_footer:(MJRefreshFooter *)xxd_footer {
    self.mj_footer = xxd_footer;
}

- (MJRefreshFooter *)xxd_footer {
    return self.mj_footer;
}

- (void)tt_refreshRefresh:(BOOL)isRefresh
                    loadMore:(BOOL)loadMore
                  completion:(void (^)(RefreshType))typeBlock {
    if (isRefresh) {
        
        MJXXDRefershHeader *header = [MJXXDRefershHeader headerWithRefreshingBlock:^{
            self.mj_footer.state = MJRefreshStateIdle;
            if (typeBlock) {
                typeBlock(RefreshTypeNew);
            }
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.mj_header = header;
    }
    
    if (loadMore) {
//        MJRefreshAutoNormalFooter *tableFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            if (typeBlock) {
//                typeBlock(RefreshTypeLoadMore);//MJRefreshBackNormalFooter
//            }
//        }];
//        [tableFooter setTitle:NSLocalizedString(@"释放查看更多信息", @"") forState:MJRefreshStatePulling];
//        [tableFooter setTitle:NSLocalizedString(@"上拉查看更多信息", @"") forState:MJRefreshStateIdle];
//        tableFooter.stateLabel.font = kTextSmallFont;
//        tableFooter.stateLabel.textColor = kThemeColor;
        
        MJRefreshBackNormalFooter *tableFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (typeBlock) {
                typeBlock(RefreshTypeLoadMore);//MJRefreshBackNormalFooter
            }
        }];
        [tableFooter setTitle:NSLocalizedString(@"释放查看更多", @"") forState:MJRefreshStatePulling];
        [tableFooter setTitle:NSLocalizedString(@"上拉查看更多", @"") forState:MJRefreshStateIdle];
        tableFooter.stateLabel.font = kTextSmallFont;
        tableFooter.stateLabel.textColor = kThemeColor;
        self.mj_footer = tableFooter;
//        self.sectionFooterHeight = 30;
    }
}

- (void)hideHeaderAndFooter {
    self.mj_header.hidden = YES;
    self.mj_footer.hidden = YES;
}

- (void)showHeaderAndFooter {
    self.mj_header.hidden = NO;
    self.mj_footer.hidden = NO;
}

- (void)removeHeaderAndFooter {
    [self.mj_header removeFromSuperview];
    [self.mj_footer removeFromSuperview];
    self.mj_header = nil;
    self.mj_footer = nil;
}

- (void)xxd_endHeader {
    [self.mj_header endRefreshing];
}

- (void)xxd_endFooter:(BOOL)isNoData {
    if (isNoData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.mj_footer endRefreshing];
    }
}

- (void)xxd_resetFooter {
    self.mj_footer.state = MJRefreshStateIdle;
}


@end
