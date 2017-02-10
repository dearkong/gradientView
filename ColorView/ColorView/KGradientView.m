//
//  KGradientView.m
//  ColorView
//
//  Created by cheyipai.com on 16/12/12.
//  Copyright © 2016年 kong. All rights reserved.
//

#import "KGradientView.h"

@implementation KGradientView
- (instancetype)initWithFrame:(CGRect)frame {


    if (self = [super initWithFrame:frame]) {
        self.opaque = YES;
        self.backgroundColor = [UIColor blackColor];
        //设置每次清空上一次绘制的内容
        self.clearsContextBeforeDrawing = YES;
        //创建RGB颜色空间
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        //定义渐变颜色:红，绿，蓝
        CGFloat colors[] =
        {
        
            1,0,0,1,
            0,1,0,1,
            0,0,1,1,
        
        };
        //创建渐变对象
        gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[8])*4));
        CGColorSpaceRelease(rgb);
        
    }
    return self;

}
- (void)setType:(GradientType)type {
    
    if (_type != type) {
        _type = type;
        [self setNeedsDisplay];
    }
}
- (void)setBeforeStart:(BOOL)beforeStart {

    if (_beforeStart != beforeStart) {
        _beforeStart = beforeStart;
        [self setNeedsDisplay];
    }
}
- (void)setAfterEnd:(BOOL)afterEnd {

    if (_afterEnd != afterEnd) {
        _afterEnd = afterEnd;
        [self setNeedsDisplay];
    }
}
//根据用户选择计算渐变选项
- (CGGradientDrawingOptions)drawingOptions {
    CGGradientDrawingOptions options = 0;
    //如果beforeStart为yes
    if (self.beforeStart) {
        //使用kCGGradientDrawsBeforeStartLocation选项
        options|=kCGGradientDrawsBeforeStartLocation;
    }
    if (self.afterEnd) {
        //使用kCGGradientDrawsAfterEndLocation选项
        options|=kCGGradientDrawsAfterEndLocation;
    }

    return options;

}
//从写该方法绘制该控件
- (void)drawRect:(CGRect)rect {
    // Drawing cod
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //获取该组建四周各减少20px的区域
    CGRect clip = CGRectInset(CGContextGetClipBoundingBox(ctx), 20.0, 20.0);
    //定义开始绘制的开始点和结束点
    CGPoint start,end;
    CGFloat startRadius,endRadius;
    //创建一个Clip区域，用于控制只在clip区域内绘制
    CGContextClipToRect(ctx, clip);
    switch (self.type) {
        case KLinearGradient://线性渐变
            //以左上角（但Y坐标为clip内1/4处）作为线性渐变的起始点
            
            start = CGPointMake(clip.origin.x, clip.origin.y + clip.size.height/4.0);
//             start = CGPointMake(clip.origin.x, clip.origin.y);
            end = CGPointMake(clip.origin.x, clip.origin.y + clip.size.height/4.0*3);
            //填充线性渐变
            CGContextDrawLinearGradient(ctx, gradient, start, end, [self drawingOptions]);
            break;
        case KRadialGradient://圆形渐变
            //定义圆形渐变的开始圆心，结束圆心都是Clip的中心
            
            start = end = CGPointMake(CGRectGetMidX(clip), CGRectGetMidY(clip));
            //计算clip区域的长、宽中较短的一条
            CGFloat r = clip.size.width<clip.size.height?clip.size.width:clip.size.height;
            startRadius = r /8.0;//技算r的1/8作为起始圆的半径
            endRadius = r/2.0;//计算r的1/2作为结束圆的半径
            //填充圆形渐变
            CGContextDrawRadialGradient(ctx, gradient, start, startRadius, end, endRadius, [self drawingOptions]);
           ;
            break;
            
        default:
            break;
    }
    //绘制矩形边框
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextStrokeRectWithWidth(ctx, clip, 2.0);
}


@end
