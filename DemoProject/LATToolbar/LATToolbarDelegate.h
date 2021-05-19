//
//  LATToolbarDelegate.h
//  WhiteboardTest
//
//  Created by mac on 2021/5/18.
//

#import <Foundation/Foundation.h>
#import <LATWhiteboard/LATWhiteboard.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LATToolbarMenuKey)
{
    LATToolbarMenuPenSize,
    LATToolbarMenuGeometryColor,
    LATToolbarMenuGeometrySize,
    LATToolbarMenuGeometryMath,
    LATToolbarMenuGeometryPhysics,
    LATToolbarMenuGeometryChemetry,
};

typedef NS_ENUM(NSInteger,LATToolbarInputName)
{
    LATToolbarInputPencil,
    LATToolbarInputErase,
    LATToolbarInputLaser,
    LATToolbarInputSelect,
    LATToolbarInputGeometry,
    LATToolbarInputFile,
};

@protocol LATToolbarDelegate <NSObject>

-(LATInputConfig *)getInputConfigByMode:(LATToolbarInputName)mode_;

-(LATInputConfig *)getActiveInputConfig;
-(void)sendInputConfig:(LATToolbarInputName)mode_;

-(void)switchInputMode:(LATToolbarInputName)mode_;

-(void)onMenuEntryTaped:(LATToolbarMenuKey)menu_;

-(BOOL)isViewHidden:(Class)view_;


@end

NS_ASSUME_NONNULL_END
