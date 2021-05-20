//
//  LATPenColorElementView.m
//  WhiteboardTest
//
//  Created by mac on 2021/5/18.
//

#import "LATToolbarColorButton.h"

@implementation LATToolbarColorButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    float radius_color = MIN(rect.size.width,rect.size.height) * self.scale;

    if(self.colorSelected)
    {
        UIColor * bgColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];

        float radius_background = radius_color * 1.4f;
        [self drawCircle:bgColor bounds:[self getRectForRadius:radius_background rect:rect]];
    }
    [self drawCircle:self.color bounds:[self getRectForRadius:radius_color rect:rect]];
   
}
-(void)drawCircle:(UIColor *)color  bounds:(CGRect)rect_
{
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillEllipseInRect(context, rect_);
}
-(CGRect)getRectForRadius:(CGFloat)radius rect:(CGRect)rect
{
    float left = rect.origin.x + (rect.size.width - radius)/2.0f;
    float top = rect.origin.y + (rect.size.height - radius)/2.0f;
    
    return CGRectMake(left, top, radius, radius);
}
@end
