//
//  WhiteboardUIDelegate.h
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/26.
//

#import <Foundation/Foundation.h>
#import "WBInputConfig.h"
#import "WBActiveWidgetInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WhiteboardUIDelegate <NSObject>


@required
-(void)changeInputConfig:(WBInputConfig *)inputConfig_;
@required
-(void)changeCurrentPageNumber:(NSInteger)pageNo_;

-(void)changeWidgetNumber:(NSString *)widgetId_ pageNumber:(int)pageNo_;
-(void)deleteWidget:(NSString *)widgetId_;
-(void)downloadWidget:(WBActiveWidgetInfo *)widgetInfo_;

-(void)selectFile:(CGRect)frame_;
-(void)selectAlbum:(CGRect)frame_;
@end

NS_ASSUME_NONNULL_END
