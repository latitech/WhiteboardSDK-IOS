//
//  GeneralParams.h
//  ChatboardCore
//
//  Created by 陈凯 on 2019/4/22.
//  Copyright © 2019 陈凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeneralParams : NSObject

@property (strong, nonatomic) NSString * requestUrl;//请求阿里云token的服务器地址

@property (strong, nonatomic) NSString * endPoint;//阿里云文件服务器参数

@property (strong, nonatomic) NSString * bucketName;//阿里云文件服务器参数

@property (strong, nonatomic) NSMutableArray * clientArray;

+(GeneralParams *)instance;

@end

NS_ASSUME_NONNULL_END
