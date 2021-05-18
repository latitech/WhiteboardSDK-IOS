//
//  WB_DocumentSize.h
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LATDocumentSize : NSObject

@property (nonatomic,assign,readonly) float currentWidth;
@property (nonatomic,assign,readonly) float currentHeight;
@property (nonatomic,assign,readonly) float maxWidth;
@property (nonatomic,assign,readonly) float maxHeight;


-(instancetype)initWithDictionary:(NSDictionary * )params_;
@end

NS_ASSUME_NONNULL_END
