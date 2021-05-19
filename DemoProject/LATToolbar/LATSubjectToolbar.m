//
//  LATSubjectToolbar.m
//  WhiteboardTest
//
//  Created by mac on 2021/5/19.
//

#import "LATSubjectToolbar.h"
@interface LATSubjectToolbar()
{
    NSDictionary * jsonData;
    NSArray * subjectArray;
    UICollectionView * collectionView;
}
@end
@implementation LATSubjectToolbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout: layout];
        [collectionView setDelegate:self];
        [collectionView setDataSource:self];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [collectionView setBackgroundColor:[UIColor redColor]];
        [self addSubview:collectionView];
    }
    return self;
}
-(void)loadJsonDictionary
{
    
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://commonshared.oss-cn-beijing.aliyuncs.com/svg/svg.json"]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError * jsonError;
        jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        if(jsonError == nil)
        {
            subjectArray = [self->jsonData objectForKey:@"result"];
        }
                
        }] resume];
    
}
-(void)updateSelection
{
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    cell.backgroundColor=[UIColor greenColor];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}
@end
