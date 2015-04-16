//
//  UFC.h
//  用友BQ基础类库头文件
//
//  Created by Roy on 10-12-19.
//  Copyright 2010 UFIDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef int HRESULT;

typedef enum
{
	DT_NODEF,
	DT_CHAR,
	DT_NUMBER,
	DT_DATE,
	DT_BINARY,
} DATATYPE;

#ifdef __cplusplus
extern "C" {
#endif

	// 显示信息提示框
	void msgBox(NSString* msg);
	void errBox(NSString* msg);
	int askBox(NSString* msg);
	int askBoxWithButtons(NSString* msg, NSString* cancelButton, NSString* button1, NSString* button2, NSString* button3, NSString* button4);
    int askBoxWithTitleAndButtons(NSString* title,NSString* msg, NSString* cancelButton, NSString* button1, NSString* button2, NSString* button3, NSString* button4);

    
	// 根据角度返回弧度
	CGFloat radians(CGFloat degrees);

	// 计算指定点point到基准点（如圆心）basePoint连线的角度
	CGFloat calcAngle(CGPoint basePoint,  CGPoint point);

	// 计算圆上指定角度点的坐标
	CGPoint calcCirclePoint(CGPoint center, CGFloat radius, CGFloat angle);

	// 计算两点间距离
	CGFloat calcDistance(CGPoint point1,  CGPoint point2);

	// 从指定位置开始查找子串
	int findString(NSString* string, NSString* findWhat, int startPos);

	// 从指定位置开始查找字符
	int findChar(NSString* string, char findWhat, int startPos);
	int findCharCount(NSString* string, char findWhat, int startPos);
		
	// 从指定位置反向查找字符
	int reverseFindChar(NSString* string, char findWhat, int startPos);

	// 根据起始位置取子串
	NSString* subString(NSString* string, int start, int stop);

	// 根据收尾标识，返回匹配的首个子字符串
	NSString* findSubString(NSString* string, NSString* head, NSString* tail, int startPos);

	// 根据指定分隔符取指定序号的子串
	NSString* getField(NSString* source, int index, char delimiter);

	// 替换指定起始位置的字符串
	void replaceString(NSMutableString* string, int start, int stop, NSString* replaceWith);

	// 查找并替换
	NSString* findAndReplaceString(NSString* string, NSString* findWhat, NSString* replaceWith);

	// 按Excel格式串格式化数字
	NSString* formatNumber(NSString* format, double value);
	NSString* formatText(NSString* format, NSString* text);
	NSString* formatDate(NSString* format, NSString* text);

	// 判断当前屏幕是否横屏
	BOOL isLandscapeOrientation(int nowScreen);

	// 数据类型名称与枚举值的相互转换
	NSString* dataTypeName(DATATYPE dt);
	DATATYPE dataTypeFromName(NSString* name);

	CGRect stringToRect(NSString* rectString);

	// 颜色字符串转换为颜色值
	UIColor* stringToColor(NSString* colorString);
	UIColor* stringToColorWithAlpha(NSString* colorString, CGFloat alpha);

	// 字体字符串转为字体对象
	UIFont* stringToFont(NSString* string);

	// 将十六进制字符串转换为整数
	long hexToLong(NSString* hexString);

	// 返回指定字符串的Hash值
	uint stringHashKey(NSString* string);

	// 设置/获取应用程序参数
	void setInitParameter(NSString* name, NSString* value);
	NSString* getInitParameter(NSString* name);

	BOOL isStringEmpty(NSString* string);
	NSString* trimString(NSString* string);

	// 判断是否传统命名（字母或下划线开始，含字母数字或下划线组成）
	BOOL isTradNaming(NSString* nameString);
    
	// 判断是否传统命名1（英文小写字母、阿拉伯数字、下划线组成）
	BOOL isTradNaming1(NSString* nameString);
    
    //判断是否为网址
    BOOL isTradUrl(NSString* urlStr);

	// 截取指定View的屏幕输出
	UIImage* captureView(UIView* view);

	// 获取多语言信息，包括错误信息
	NSString* getMessage(int code);

	// 获取当前app documents目录路径
	NSString* getDocPath(int noUse);

	// 获取临时目录路径
	NSString* getTempPath(BOOL autoCreate);
    
	// 获取头像临时目录路径
	NSString* getPhotoTempPath(BOOL autoCreate);
		
	// 通过消息循环等待n毫秒
	void waitSeconds(double seconds);

	// 创建指定视图的遮盖层视图，用于淡入淡出等变换
	// rect 如果为NULL，则取全部区域
	UIImageView* createDummyView(UIView* view, CGRect rect);
	
	// 根据原图像，产生指定颜色的新图像
	UIImage* createColorImage(UIImage* sourceImage, UIColor* targetColor);
		
	// 判断指定字符串是否EMail地址
	BOOL isEMailAddress(NSString* string);
	
	// 判断并规范化电话号码
	NSString* regularPhoneNumber(NSString* string);
    
    // 判断并规范手机号码
    NSString* regularMobilePhoneNumber(NSString* string);
	
	// 获取当前应用程序的主窗口
	UIWindow* getMainWindow(int noUse);
	
	//Add By Yin Lianqiang
	// 处理XML时，转换特殊字符；
	//<表示方式是&it;
	//>表示方式是&gt;
	//&表示方式是&amp;
	//"表示方式是&quot
	NSString *encodeSpecialCharacter(NSString *string);
	NSString *decodeSpecialCharacter(NSString *string);
    
    //Add By Angus Chen
    // 将原图象按指定宽高生成新的图像
    UIImage* imageToImage(UIImage * srcImg, CGFloat width, CGFloat height);
    
    //Add By An
    //等比例缩放图片
    UIImage* proportionScalingImage(UIImage* scrImg, CGFloat width, CGFloat height);
    //根据ios版本号来控制图片名称是否加上@2x,并返回该图片路径
    NSString* getImagePath(NSString* originImageName,NSString* ext);
    //判断是否为整形：
    BOOL isPureInt(NSString* string);
    //判断是否为浮点形：
    BOOL isPureDouble(NSString* string);
    //计算 宽度
    CGFloat calculateTextWidth(NSString *strContent, UIFont *font);
    
// about device 
    BOOL isHDScreen(int noUse);
    
// get itunes url
    NSString *getITunesURLString(int noUse);
    NSString *getBundleVersion(int noUse);
    
    //16进制颜色(html颜色值)字符串转为UIColor
    UIColor* colorWithHexString(NSString* stringToConvert);
    
    BOOL isContainChinese(NSString *str);
    
    //返回附件的大小，已M为单位
    float formattedFileSize(unsigned long long size);
    
    //返回动态label的高度
    float getLabelHeight(NSString *str);
#ifdef __cplusplus
}
#endif
