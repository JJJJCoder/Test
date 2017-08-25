//
//  HXServerRequstManager.h
//  NetworkManager
//
//  Created by iforvert on 2016/11/30.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HXServerRequestProtocol <NSObject>

@required

- (NSString*)funcName;
- (NSDictionary*)paramDict;
- (void)processResult:(nullable NSDictionary*)result error:(NSError * _Nullable * _Nonnull)error;

@optional

- (NSDictionary *)extraParaDict;

@end

NS_ASSUME_NONNULL_END
