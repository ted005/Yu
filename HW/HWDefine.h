//
//  HWDefine.h
//  HW
//
//  Created by Wei Wei on 2017/11/22.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#define CTColorHex(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]

#define iPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define HW_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// UI适配的比例函数
CG_INLINE CGFloat HWR(CGFloat x) {
    return ceilf(iPAD ? x : (x) * (HW_SCREEN_WIDTH / 375.f));
}

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
