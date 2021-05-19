//
//  LATSubjectToolbar.h
//  WhiteboardTest
//
//  Created by mac on 2021/5/19.
//

#import "LATBaseToolbar.h"

NS_ASSUME_NONNULL_BEGIN

@interface LATSubjectToolbar : LATBaseToolbar <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

-(void)loadJsonDictionary;
@end

NS_ASSUME_NONNULL_END
