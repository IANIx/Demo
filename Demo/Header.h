//
//  Header.h
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#ifndef Header_h
#define Header_h



#define MainScreenHeight [[UIScreen mainScreen]bounds].size.height
#define MainScreenWidth [[UIScreen mainScreen]bounds].size.width

//Color
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define zkHexColor(hexValue) [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1.0]
#define HexAlphaColor(hexValue,a) [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:(a)/1.0f]


#define XM_COMMON_BG_COLOR zkHexColor(0x181c28)
#define XM_COMMON_BGTITLE_COLOR zkHexColor(0x818fb2)
#define XM_COMMON_TITLE_COLOR zkHexColor(0xffffff)
// Hook初始化

#define XXConcat_(a, b) a ## b
#define XXConcat(a, b) XXConcat_(a, b)

#define XXConstructor static __attribute__((constructor)) void XXConcat(XXConstructor, __LINE__)()

// 交换示例方法
#define XXHookInstanceMethod(classname, ori_sel, new_sel) \
\
{ \
Class class = objc_getClass(#classname); \
Method ori_method = class_getInstanceMethod(class, ori_sel); \
Method new_method = class_getInstanceMethod(class, new_sel); \
method_exchangeImplementations(ori_method, new_method); \
} \
\

// 交换类方法
#define XXHookClassMethod(classname, ori_sel, new_sel) \
\
{ \
Class class = objc_getClass(#classname); \
Method ori_method = class_getClassMethod(class, ori_sel); \
Method new_method = class_getClassMethod(class, new_sel); \
method_exchangeImplementations(ori_method, new_method); \
} \
\

// .h文件
#define XX_SingletonH(name) + (instancetype)shared##name;

// .m文件
#define XX_SingletonM(name) \
static id _instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

#endif /* Header_h */
