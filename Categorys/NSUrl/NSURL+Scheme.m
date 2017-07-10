//
//  NSURL+Scheme.m
//  XXDIOS
//
//  Created by Ak on 8/21/16.
//  Copyright © 2016 Yonsen Financial Services. All rights reserved.
//

#import "NSURL+Scheme.h"
#import "NSObject+Ext.h"
#import "DayDayGainController.h"
#import <objc/runtime.h>

@implementation NSURL (Scheme)

- (void)handleUrlScheme:(NSURL *)url TabbarControl:(UITabBarController *)tabbarControl Navigation:(UINavigationController *)navigation {
    NSString *host = url.host;
    NSString *query = url.query;
    
    NSDictionary *h5NativeDic = [self getH5NativeDictionary];
    
    NSString *pageName = [host stringByReplacingOccurrencesOfString:@"pagename=" withString:@""];
    if ([pageName isEqualToString:@"poppage"]) {
        [navigation popViewControllerAnimated:YES];
    }else if ([pageName isEqualToString:@"popRootPage"]) {
        [navigation popToRootViewControllerAnimated:YES];
    }else {
        NSDictionary *resultDic = h5NativeDic[pageName];
        if ([resultDic isKindOfClass:[NSDictionary class]] && resultDic) {
            NSString *vcClassStr = resultDic[@"C"];
            NSString *modelClassStr = resultDic[@"M"];
            NSString *tabbarNumberClassStr = resultDic[@"id"];
            if ([pageName isEqualToString:@"contactus"]) {
                [[GlobalUtil ShareInstance] recordBigData:[BigDataRecordDic ShareInstance].FAQPageDic To:[BigDataRecordDic ShareInstance].relationOurPageDic By:[BigDataRecordDic ShareInstance].FAQPageCallClickDic];
            }
            if (tabbarNumberClassStr && ![tabbarNumberClassStr isEqualToString:@""]) {
                if (tabbarControl) {
//                    [tabbarControl setSelectedIndex:[tabbarNumberClassStr integerValue]];
//                    [navigation popToRootViewControllerAnimated:YES];
//                    navigation = (UINavigationController *)tabbarControl.selectedViewController;
                }
            }
            Class H5VCClass = NSClassFromString(vcClassStr);
            Class H5ModelClass = NSClassFromString(modelClassStr);
            UIViewController *h5VC;
            
            if (modelClassStr && ![modelClassStr isEqualToString:@""]) {
                NSArray *h5VCTypeArr = [@[] getAllPropertiesTypeArr:H5VCClass];
                __block BOOL containsBool = NO;
                [h5VCTypeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *temp = obj;
                    if ([temp containsString:modelClassStr]) {
                        containsBool = YES;
                    }
                }];
                if (containsBool) {
                    NSObject *h5Model;
                    NSDictionary *queryDic = [self handleQueryStr:query];
                    h5Model = [H5ModelClass xxd_objFromKeyValue:queryDic];
                    
                    NSMutableDictionary *h5VCDic = [[@{} classPropsFor:H5VCClass] mutableCopy];
                    __block NSMutableDictionary *h5VCSetDic = [@{} mutableCopy];
                    [h5VCDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
                        if ([obj isEqualToString:modelClassStr]) {
                            h5VCSetDic[key] = h5Model;
                        }
                    }];
                    
                    h5VC = [H5VCClass xxd_objFromKeyValue:h5VCSetDic];
                }else {
                    h5VC = [[H5VCClass alloc]init];
                }
            }else {
                NSDictionary *queryDic = [self handleQueryStr:query];
                
                if ([vcClassStr isEqualToString:@"DayDayGainController"]) {//老Tony坑死我了
                    DayDayGainController *dayCtr = [[DayDayGainController alloc] init];
                    dayCtr.productId = queryDic[@"productId"];
                    dayCtr.productIndex = [queryDic[@"productIndex"] integerValue];
                    h5VC = dayCtr;
                }else h5VC = [H5VCClass xxd_objFromKeyValue:queryDic];

            }
            [navigation pushViewController:h5VC animated:YES];
        }
    }
}

- (NSDictionary *)handleQueryStr:(NSString *)query {
    __block NSMutableDictionary *finalDic = [@{} mutableCopy];
    if ([query containsString:@"url="]) {
        NSArray *tempArr = [query componentsSeparatedByString:@"url="];
        NSArray *firstPartArr = [tempArr[0] componentsSeparatedByString:@"&"];
        __block NSMutableDictionary *firstDic = [@{} mutableCopy];
        [firstPartArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *tempDicArr = [obj componentsSeparatedByString:@"="];
            if (tempDicArr.count > 1) {
                NSString *value = tempDicArr[1];
                value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                finalDic[tempDicArr[0]] = value;
            }
        }];
        finalDic = [NSMutableDictionary dictionaryWithDictionary:firstDic];
        NSString *urlStr = [query stringByReplacingOccurrencesOfString:tempArr[0] withString:@""];
        if (urlStr.length > 4) {
            NSString *finalUrlStr = [urlStr substringFromIndex:4];
            finalDic[@"url"] = finalUrlStr;
        }
    }else if ([query containsString:@"urlshared="]) {
        
    }else {
        NSArray *tempArr = [query componentsSeparatedByString:@"&"];
        [tempArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *tempDicArr = [obj componentsSeparatedByString:@"="];
            if (tempDicArr.count > 1) {
                NSString *value = tempDicArr[1];
                value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                finalDic[tempDicArr[0]] = value;
            }
        }];
    }
    return finalDic;
}

- (NSDictionary *)getH5NativeDictionary {
    return @{@"home":@{@"id":@"0",
                       @"M":@"",
                       @"C":@"RootHomeViewController"
                       },
             @"web":@{@"id":@"0",
                      @"M":@"",
                      @"C":@"WebViewViewController"
                      },
             @"quickmenu":@{@"id":@"0",
                            @"M":@"",
                            @"C":@"XXDQuickMenuController"
                            },
             @"message":@{@"id":@"0",
                          @"M":@"MessageModel",
                          @"C":@"RootMessageViewController"
                          },
             
             @"hotproduct":@{@"id":@"1",
                             @"M":@"",
                             @"C":@""
                             },
             @"pddetail":@{@"id":@"1",
                           @"M":@"",
                           @"C":@"DayDayGainController"
                           },
             @"pdintroduce":@{@"id":@"1",
                              @"M":@"",
                              @"C":@"DayDayGainController"
                              },
             @"pdrecord":@{@"id":@"1",
                           @"M":@"",
                           @"C":@"DayDayGainController"
                           },
             @"pdbuy":@{@"id":@"1",
                        @"M":@"",
                        @"C":@"BuyViewController"
                        },
             
             @"known":@{@"id":@"2",
                        @"M":@"",
                        @"C":@"XXDKnowViewController"
                        },
             
             @"discover":@{@"id":@"3",
                           @"M":@"",
                           @"C":@"XXDFindViewController"
                           },
             
             @"mine":@{@"id":@"4",
                       @"M":@"",
                       @"C":@"MineRootViewController"
                       },
             @"setting":@{@"id": @"4",
                          @"M": @"",
                          @"C": @"SettingController"},
             
             @"charge":@{@"id": @"4",
                         @"M": @"",
                         @"C": @"MyTopUpViewController"},
             
             @"postal":@{@"id": @"4",
                         @"M": @"",
                         @"C": @"MyCashOutViewController"},
             
             @"totalmoney": @{@"id": @"4",
                              @"M": @"",
                              @"C": @"TotalMoneyViewController"},
             @"balance": @{@"id": @"4",
                           @"M": @"RestMoneyModel",
                           @"C": @"RestMoneyViewController"},
             @"existincome": @{@"id": @"4",
                               @"M": @"TotalProfitModel",
                               @"C": @"TotalProfitViewController"},
             @"laterincome": @{@"id": @"4",
                               @"M": @"LaterProfitModel",
                               @"C": @"LaterProfitViewController"},
             @"voterecord": @{@"id": @"4",
                              @"M": @"",
                              @"C": @"VoteMoneyViewController"},
             @"moneyplan": @{@"id": @"4",
                             @"M": @"ProfitPlanModel",
                             @"C": @"ProfitPlanViewController"},
             @"manageaccount": @{@"id": @"4",
                                 @"M": @"",
                                 @"C": @"ManageAccountController"},
             @"myreward": @{@"id": @"4",
                            @"M": @"",
                            @"C": @"RedPacketController"},
             
             @"secturecenter":@{@"id" : @"4",
                                @"M":@"",
                                @"C":@"SafeCenterViewController"},
             
             @"service": @{@"id": @"4",
                           @"M": @"",
                           @"C": @"ServiceController"},
             @"freezemoney": @{@"id": @"4",
                               @"M": @"FreezeMoneyModel",
                               @"C": @"FreezeMoneyViewController"},
             
             @"managevip":@{},
             
             @"voteproductrecord": @{@"id": @"4",
                                     @"M": @"VoteProductDetailModel",
                                     @"C": @"VoteProductDetailViewController"},
             @"traderecord": @{@"id": @"4",
                               @"M": @"TradeHistoryModel",
                               @"C": @"TradeHistoryViewController"},
             @"xxdcoinrecord": @{@"id": @"4",
                                 @"M": @"RedPacketCoinModel",
                                 @"C": @"CoinRecordController"},
             @"myprizerecord": @{@"id": @"4",
                                 @"M": @"RedPacketDetailModel",
                                 @"C": @"WinRecordController"},
             
             @"login":@{@"id":@"",
                        @"M":@"",
                        @"C":@"LoginAndRegistViewController"
                        },
             @"regist":@{@"id":@"",
                         @"M":@"",
                         @"C":@"LoginAndRegistViewController"
                         },
             @"resetpassword":@{@"id":@"",
                                @"M":@"",
                                @"C":@"LoginAndRegistViewController"
                                },
             @"contactus": @{@"id":@"",
                                @"M":@"",
                                @"C":@"ContactController"
                                }
             };
}

@end
