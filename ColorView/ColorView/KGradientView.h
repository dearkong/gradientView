//
//  KGradientView.h
//  ColorView
//
//  Created by cheyipai.com on 16/12/12.
//  Copyright © 2016年 kong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{

    KLinearGradient = 0,
    KRadialGradient

} GradientType;


@interface KGradientView : UIView {

    CGGradientRef gradient;

}

@property (nonatomic ,assign) GradientType type;
@property (nonatomic ,assign) BOOL beforeStart;
@property (nonatomic ,assign) BOOL afterEnd;

@end
