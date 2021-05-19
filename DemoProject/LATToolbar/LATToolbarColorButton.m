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
    float radius = MIN(rect.size.width,rect.size.height) * self.scale;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context,self.color.CGColor);
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(rect.origin.x + (rect.size.width - radius)/2.0f, rect.origin.y + (rect.size.height - radius)/2.0f, radius, radius));
}

@end
