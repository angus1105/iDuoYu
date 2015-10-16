//
//  UFC.m
//  UFC
//
//  Created by Roy on 11-1-3.
//  Copyright 2011 UFIDA. All rights reserved.
//

#import "Common.h"
#import "Constants.h"
//#import "Context.h"

// 实现模态询问提示框
@interface UFAlertView : UIAlertView
{
	int _selectedButton;
}

- (int)showModal;

@end

@implementation UFAlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	_selectedButton = (int)buttonIndex;
}

- (int)showModal
{
	_selectedButton = -1;
	self.delegate = self;
	[self show];
	
	NSRunLoop* curRunLoop = [NSRunLoop currentRunLoop];
	while ([curRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.5]])
	{
		if (_selectedButton != -1)
			break;
	}
	
	return _selectedButton;
}

@end


void msgBox(NSString* msg)
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg
												   delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles: nil];
	[alert show];
}

void errBox(NSString* msg)
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:msg
												   delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles: nil];
	[alert show];
}

int askBox(NSString* msg)
{
	UFAlertView *alert = [[UFAlertView alloc] initWithTitle:nil message:msg
							delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
	return [alert showModal];
}

int askBoxWithButtons(NSString* msg, NSString* cancelButton, NSString* button1, NSString* button2, NSString* button3, NSString* button4)
{
	UFAlertView *alert = [[UFAlertView alloc] initWithTitle:nil message:msg
					delegate:nil cancelButtonTitle:cancelButton otherButtonTitles:button1,button2,button3,button4,nil];
	return [alert showModal];
}

int askBoxWithTitleAndButtons(NSString* title,NSString* msg, NSString* cancelButton, NSString* button1, NSString* button2, NSString* button3, NSString* button4)
{
	UFAlertView *alert = [[UFAlertView alloc] initWithTitle:title message:msg
                                                   delegate:nil cancelButtonTitle:cancelButton otherButtonTitles:button1,button2,button3,button4,nil];
	return [alert showModal];
}

int findString(NSString* string, NSString* findWhat, int startPos)
{
	if(string == nil || findWhat == nil)
	{
		return -1;
	}
	else if(startPos <= 0)
	{
		NSRange result = [string rangeOfString:findWhat];
		if(result.location != NSNotFound)
			return (int)result.location;
	}
	else
	{
		NSRange range = {startPos, [string length] - startPos};
		NSRange result = [string rangeOfString:findWhat options:0 range:range];
		if(result.location != NSNotFound)
			return (int)result.location;
	}
	
	return -1;
}

int findChar(NSString* string, char findWhat, int startPos)
{
	if(string == nil)
		return -1;
	
	if(startPos < 0)
		startPos = 0;
	int i, len = (int)[string length];
	for(i = startPos; i < len; i ++)
	{
		if([string characterAtIndex:i] == findWhat)
			return i;
	}
	
	return -1;
}

int findCharCount(NSString* string, char findWhat, int startPos)
{
	if(string == nil)
		return 0;
	
	if(startPos < 0)
		startPos = 0;
	int i, len = (int)[string length], count = 0;
	for(i = startPos; i < len; i ++)
	{
		if([string characterAtIndex:i] == findWhat)
			count ++;
	}
	
	return count;
}

int reverseFindChar(NSString* string, char findWhat, int startPos)
{
	if(string == nil)
		return -1;
	
	int i, len = (int)[string length];
	if(startPos < 0 || startPos >= len)
		startPos = len - 1;
	for(i = startPos; i >= 0; i --)
	{
		if([string characterAtIndex:i] == findWhat)
			return i;
	}
	
	return -1;
}

NSString* subString(NSString* string, int start, int stop)
{
	if(string == nil || (stop >= 0 && stop < start))
		return nil;
	
	if(stop == start)
		return @"";
	
	if(stop == -1)
	{
		return [string substringFromIndex:start];
	}
	else if(start == 0)
	{
		return [string substringToIndex:stop];
	}
	else
	{
		NSRange range = {start, stop - start};
		return [string substringWithRange:range];
	}
}

NSString* findSubString(NSString* string, NSString* head, NSString* tail, int startPos)
{
	int pos1 = findString(string, head, startPos);
	if(pos1 < 0)
		return nil;
	
	pos1 += [head length];
	int pos2 = findString(string, tail, pos1);
	if(pos2 < 0)
		return nil;
	
	return subString(string, pos1, pos2);
}

void replaceString(NSMutableString* string, int start, int stop, NSString* replaceWith)
{
	NSRange range = {start, stop - start};
	[string replaceCharactersInRange:range withString:replaceWith];
}

NSString* findAndReplaceString(NSString* string, NSString* findWhat, NSString* replaceWith)
{
	if(string == nil)
		return nil;
	
	NSRange result = [string rangeOfString:findWhat];
	if(result.location == NSNotFound)
		return string;
	
	int repLen = (int)[replaceWith length];
	NSRange range = {0, [string length]};
	NSMutableString* theString = [[NSMutableString alloc] initWithString:string];
	while (range.length > 0)
	{
		//result = [theString rangeOfString:findWhat];
		result = [theString rangeOfString:findWhat options:0 range:range];
		if(result.location == NSNotFound)
			break;
		
		[theString replaceCharactersInRange:result withString:replaceWith];
		range.location = result.location + repLen;
		range.length = [theString length] - range.location;
	}
	
	return theString;
}

//Excel风格格式化字符串
NSString* formatNumber(NSString* format, double value)
{
	//TODO: 完善Excel格式字符串解析
	NSMutableString* result = [[NSMutableString alloc] initWithString:format];
	NSRange range = [result rangeOfString:@"#"];
	if (range.location != NSNotFound)
	{
		int nDec = INT_MAX;
		bool bComma = false;
		NSInteger i, n = [result length];
		range.length = 0;
		for(i = range.location; i < n; i ++)
		{
			switch ([result characterAtIndex:i])
			{
				case '"':
					if(i > range.location)
					{
						range.length = i - range.location;
						break;
					}
					else 
					{
						i = findChar(result, '"', (int)i+1);
						if (i < 0)
							break;
					}
					continue;
					
				case '#':
					if(nDec <= 0)
						nDec --;
					continue;
					
				case '0':
					if(nDec != INT_MAX && nDec >= 0)
						nDec ++;
					continue;
					
				case '.':
					nDec = 0;
					continue;
					
				case ',':
					bComma = true;
					continue;
					
				case '%':
					value = value * 100.0;
					range.length = i - range.location;
					break;
					
				default:
					break;
			}
			if (range.length > 0 || i < 0)
				break;
		}
		if(range.length == 0)
			range.length = n - range.location;
		
		//e.g. #0.00, #,###0.00
		NSString* number = nil;
		if(nDec != INT_MAX)
		{
			NSString* cformat = [NSString stringWithFormat:@"%%.0%df", abs(nDec)];
			number = [NSString stringWithFormat:cformat, value];
			if (nDec < 0)
			{
				//#.##格式，需要去掉后面多余的小数0
				int i, n = (int)[number length];
				for (i = n-1; i >= 0; i --)
				{
					switch ([number characterAtIndex:i])
					{
						case '0':
							continue;
							
						case '.':
							number = subString(number, 0, i);
							i = -1;
							break;
							
						default:
							number = subString(number, 0, i+1);
							i = -1;
							break;
					}
				}
			}
		}
		else
		{
			//不保留小数点
			if (value >= 0) {
				number = [NSString stringWithFormat:@"%d", (int)(value+0.5)];
			}else {
				number = [NSString stringWithFormat:@"%d", (int)(value - 0.5)];
			}

			
		}
		
		if (bComma)
		{
			//支持千分位分隔
			int pos = findChar(number, '.', 0);
			if (pos < 0)
				pos = (int)[number length];
			if (pos > 3)
			{
				NSMutableString* commaNumber = [[NSMutableString alloc] initWithString:number];
				for (i = pos-3; i > 0; i -= 3)
				{
					if (i == 1 && [commaNumber characterAtIndex:0] == '-')
						break;
					
					[commaNumber insertString:@"," atIndex:i];
				}
				number = commaNumber;
			}
		}
		
		if(number != nil)
			[result replaceCharactersInRange:range withString:number];
	//Add by Yin Lianqiang
	}else if (findString(format, @"\"@\"", 0) >= 0) {
		NSString *string = [NSString stringWithFormat:@"%.0f",value];//[NSString stringWithFormat:@"%d",value];
		//[result appendFormat:@"%@",findAndReplaceString(format, @"\"@\"", string)];
		[result setString:findAndReplaceString(format, @"\"@\"", string)];
	}
	
	return findAndReplaceString(result, @"\"", @"");
}

NSString* formatDate(NSString* format, NSString* text)
{
	if (isStringEmpty(text) || isStringEmpty(format))
		return text;
	
	NSString* year = nil, *month = nil, *day = nil;
	if (findChar(text, '/', 0) > 0)
	{
		if (findChar(text, ':', 0) > 0)
		{
			//包含时间
			text = getField(text, 0, ' ');
		}
		
		year = getField(text, 0, '/');
		month = getField(text, 1, '/');
		day = getField(text, 2, '/');
		if (year == nil || month == nil || day == nil)
			return nil;
		
		if ([year length] < [day length])
		{
			//月/日/年
			text = day;
			day = month;
			month = year;
			year = text;
		}
		text = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
	}
	else if (findChar(text, '-', 0) > 0)
	{
		if (findChar(text, ':', 0) > 0)
		{
			//包含时间
			text = getField(text, 0, ' ');
		}
		
		year = getField(text, 0, '-');
		month = getField(text, 1, '-');
		day = getField(text, 2, '-');
		if (year == nil || month == nil || day == nil)
			return nil;
		
		if ([year length] < [day length])
		{
			//月/日/年
			text = day;
			day = month;
			month = year;
			year = text;
		}
		text = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
	}
	
	NSString* result = nil;
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	//[df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
	[df setDateFormat:@"yyyy-MM-dd"];
	NSDate* date = [df dateFromString:text];
	if (date != nil)
	{
		format = findAndReplaceString(format, @"mm", @"MM");
		format = findAndReplaceString(format, @"m", @"M");
		format = findAndReplaceString(format, @"DD", @"dd");
		format = findAndReplaceString(format, @"d", @"d");
		[df setDateFormat:format];
		//[df setTimeZone:[NSTimeZone localTimeZone]];
		result = [df stringFromDate:date];
	}
	
	return result;
}

NSString* formatText(NSString* format, NSString* text)
{
	if (isStringEmpty(text))
		return text;
	
	if (findChar(format, '#', 0) >= 0)
		return formatNumber(format, [text doubleValue]);
	
	if (findString(format, @"yy", 0) >= 0)
		return formatDate(format, text);
	
	NSString* result = findAndReplaceString(format, @"@", text);
	result = findAndReplaceString(result, @"\"", @"");
	return result;
}

CGFloat calcAngle(CGPoint basePoint,  CGPoint point)
{
	//Cocoa坐标系：原点在左上角，顺时针角度为正
	//夹角θ=arctan|(k1-k2)/(1+k1k2)| 	
	CGFloat angle = atan((point.y - basePoint.y) / (point.x - basePoint.x));
	if (angle <= 0 && point.y >= basePoint.y && point.x < basePoint.x)
	{
		//位于第2象限
		angle = M_PI + angle;
	}
	else if(angle >= 0 && point.y < basePoint.y && point.x <= basePoint.x)
	{
		//位于第3象限
		angle = M_PI + angle;
	}
	else if (angle <= 0 && point.y <= basePoint.y && point.x > basePoint.x)
	{
		//位于第4象限
		angle = M_PI * 2 + angle;
	}
	
	//NSLog(@"\nx=%f,y=%f,angle=%f", point.x, point.y, angle);
	return angle;
}

CGPoint calcCirclePoint(CGPoint center, CGFloat radius, CGFloat angle)
{
	CGPoint point;
	point.x = center.x + radius * cos(angle);
	point.y = center.y + radius * sin(angle);
	return point;
}

CGFloat calcDistance(CGPoint point1,  CGPoint point2)
{
	CGFloat dx = point1.x - point2.x;
	CGFloat dy = point1.y - point2.y;
	return sqrtf(dx * dx + dy * dy);
}

CGFloat radians(CGFloat degrees)
{
	return degrees * M_PI / 180;
}

BOOL isLandscapeOrientation(int nowScreen)
{
	// TODO: 未考虑iPad
	CGRect frame = [[UIScreen mainScreen] applicationFrame];
	//CGRect bounds = [[UIScreen mainScreen] bounds];
	return (frame.size.width == 300);
}

NSString* dataTypeName(DATATYPE dt)
{
	NSString* result = nil;
	switch (dt)
	{
		case DT_CHAR:
			result = @"string";
			break;
			
		case DT_NUMBER:
			result = @"double";
			break;
			
		case DT_DATE:
			result = @"datetime";
			break;
			
		case DT_BINARY:
			result = @"binary";
			break;
			
		default:
			break;
	}
	
	return [[NSString alloc] initWithString:result];
}

DATATYPE dataTypeFromName(NSString* name)
{
	if ([name isEqualToString:@"string"])
		return DT_CHAR;
	else if ([name isEqualToString:@"double"])
		return DT_NUMBER;
	else if ([name isEqualToString:@"datetime"])
		return DT_DATE;
	else if ([name isEqualToString:@"binary"])
		return DT_BINARY;
	else
		return DT_NODEF;
}

NSString* getField(NSString* source, int index, char delimiter)
{
	if(source == nil)
		return nil;
	
	NSString* value = nil;
	int posStart = 0, posFind = -1;
	for (int i = 0; i <= index; i++)
	{
		posFind = findChar(source, delimiter, posStart);
		if (posFind < 0 && i < index)
			return nil;
		
		if (i < index)
			posStart = posFind + 1;
	}
	
	if (posFind < 0)
		value = [source substringFromIndex:posStart];
	else
		value = subString(source, posStart, posFind);
	
	return value;
}

CGRect stringToRect(NSString* rectString)
{
	CGRect rect = CGRectNull;
	if(rectString == nil || [rectString isEqual:@""])
		return rect;
	
	rect.origin.x = [getField(rectString, 0, ',') intValue];
	rect.origin.y = [getField(rectString, 1, ',') intValue];
	rect.size.width = [getField(rectString, 2, ',') floatValue] - rect.origin.x;
	rect.size.height = [getField(rectString, 3, ',') floatValue] - rect.origin.y;
	
	return rect;
}

#define FromHex(n)	(((n) >= 'A') ? ((n) + 10 - 'A') : ((n) - '0'))
long hexToLong(NSString* hexString)
{
	if(hexString == nil || [hexString isEqual:@""])
		return 0;
	
	hexString = [hexString uppercaseString];
	
	long nValue = 0;
	char c;
	int nLen = (int)[hexString length];
	for(int i = 0; i < nLen; i ++)
	{
		c = [hexString characterAtIndex:nLen - 1 - i];
		nValue += FromHex(c) << i * 4;
	}
	
	return nValue;
}

UIColor* stringToColor(NSString* colorString)
{
	return stringToColorWithAlpha(colorString, -1);
}

UIColor* stringToColorWithAlpha(NSString* colorString, CGFloat alpha)
{
	if(colorString == nil || [colorString isEqual:@""])
		return nil;
	
	if([colorString characterAtIndex:0] == '#')
		colorString = [colorString substringFromIndex:1];
	
	UIColor* color = nil;
	if ([colorString length] == 6 || alpha >= 0)
	{
		CGFloat red = (CGFloat)hexToLong([colorString substringToIndex:2]);
		CGFloat green = (CGFloat)hexToLong(subString(colorString, 2, 4));
		CGFloat blue = (CGFloat)hexToLong([colorString substringFromIndex:4]);
		if (alpha < 0)
			alpha = 1.0;
		color = [UIColor colorWithRed:(CGFloat)red/255 green:(CGFloat)green/255 blue:(CGFloat)blue/255 alpha:alpha];
	}
	else if ([colorString length] == 8)
	{
		CGFloat alpha = (CGFloat)hexToLong([colorString substringToIndex:2]);
		CGFloat red = (CGFloat)hexToLong(subString(colorString, 2, 4));
		CGFloat green = (CGFloat)hexToLong(subString(colorString, 4, 6));
		CGFloat blue = (CGFloat)hexToLong([colorString substringFromIndex:6]);
		color = [UIColor colorWithRed:(CGFloat)red/255 green:(CGFloat)green/255 blue:(CGFloat)blue/255 alpha:alpha/255];
	}
	
	return color;
}

uint stringHashKey(NSString* string)
{
	uint nHash = 0;
	int i, n = (int)[string length];
	for (i = 0; i < n; i ++)
	{
		nHash = (nHash<<5) + nHash + [string characterAtIndex:i];
	}

	return nHash;
}

void setInitParameter(NSString* name, NSString* value)
{
	NSString* appDocPath = getDocPath(1);
	NSString* configFile = [NSString stringWithFormat:@"%@/application.cfg", appDocPath];
	NSString* item = nil;
	if (isStringEmpty(value))
		item = @"";
	else 
		item = [NSString stringWithFormat:@"\n%@=%@", name, value];
	
	//先读入文件
	NSMutableString* data = nil;
	NSData* reader = [NSData dataWithContentsOfFile:configFile];
	if (reader != nil)
	{
		data = [[NSMutableString alloc] initWithData:reader encoding:NSUTF8StringEncoding];
		
		//查找配置项
		int pos1 = findString(data, [NSString stringWithFormat:@"\n%@=", name], 0);
		if (pos1 > 0)
		{
			int pos2 = findChar(data, '\n', pos1+2);
			if (pos2 < 0)
				pos2 = (int)[data length];
			
			replaceString(data, pos1, pos2, item);
		}
		else
		{
			[data appendString:item];
		}
		
	}
	else
	{
		data = [[NSMutableString alloc] initWithFormat:@"[Global]%@", item];
	}
	
	//写入文件
    NSMutableData* writer = [[NSMutableData alloc] init];
	[writer setData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    [writer writeToFile:configFile atomically:YES];
}

NSString* getInitParameter(NSString* name)
{
	NSString* appDocPath = getDocPath(1);
	NSString* configFile = [NSString stringWithFormat:@"%@/application.cfg", appDocPath];
	
	//先读入文件
	NSString* data = nil;
	NSData* reader = [NSData dataWithContentsOfFile:configFile];
	if (reader != nil)
	{
		data = [[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding];
		
		//查找配置项
		int pos1 = findString(data, [NSString stringWithFormat:@"\n%@=", name], 0);
		if (pos1 > 0)
		{
			int pos2 = findChar(data, '\n', pos1+2);
			if (pos2 < 0)
				pos2 = (int)[data length];
			
			NSString* value = subString(data, pos1+2+(int)[name length], pos2);
			return value;
		}
	}
	
	return nil;
}

BOOL isStringEmpty(NSString* string)
{
	return (string == nil || [@"" isEqualToString:string] || [string isEqual: [NSNull null]] || [@"null" isEqualToString:string]);
}

NSString* trimString(NSString* string)
{
	if (isStringEmpty(string))
		return string;
	
	if ([string characterAtIndex:0] != ' ' && [string characterAtIndex:[string length]-1] != ' ')
		return string;
	
	NSMutableString* result = [string mutableCopy];
	CFStringTrimWhitespace((CFMutableStringRef)result);   
	return result;
}

UIFont* stringToFont(NSString* string)
{
	//e.g. Verdana,18,Italic,Bold
	CGFloat fontSize = [getField(string, 1, ',') floatValue];
	if (fontSize > 0)
	{
		//Font: Helvetica-Oblique 
		//Font: Helvetica-BoldOblique 
		//Font: Helvetica 
		//Font: Helvetica-Bold 
		NSString* fontName = nil, *baseName = @"Helvetica";
		if (findString(string, @"Bold", 0) > 0 && findString(string, @"Italic", 0) > 0)
			fontName = [NSString stringWithFormat:@"%@-BoldOblique", baseName];
		else if (findString(string, @"Bold", 0) > 0)
			fontName = [NSString stringWithFormat:@"%@-Bold", baseName];
		else if (findString(string, @"Italic", 0) > 0)
			fontName = [NSString stringWithFormat:@"%@-Oblique", baseName];
		else
			fontName = baseName;
		
		UIFont* font = [UIFont fontWithName:fontName size:fontSize];
		return font;
	}
	
	return nil;
}

BOOL isTradNaming(NSString* nameString)
{
	if(isStringEmpty(nameString))
		return false;
	
	char ch = [nameString characterAtIndex:0];
	bool bTradHeader = (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')	|| ch == '_';
	if(!bTradHeader)
		return false;
	
	bool bTradNamingChar;
	int i, n = (int)[nameString length];
	for(i = 0; i < n; i ++)
	{
		ch = [nameString characterAtIndex:i];
		bTradNamingChar = (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')	|| 
							ch == '_' || (ch >= '0' && ch <= '9');
		if(!bTradNamingChar)
			return false;
	}
	
	return true;
}

BOOL isTradNaming1(NSString* nameString)
{
	if(isStringEmpty(nameString))
		return false;
	
	char ch = [nameString characterAtIndex:0];
	bool bTradNamingChar;
	int i, n = (int)[nameString length];
	for(i = 0; i < n; i ++)
	{
		ch = [nameString characterAtIndex:i];
		bTradNamingChar = (ch >= 'a' && ch <= 'z') || ch == '_' || (ch >= '0' && ch <= '9');
		if(!bTradNamingChar)
			return false;
	}
	
	return true;
}

BOOL isTradUrl(NSString* urlString){
    BOOL isUrl = NO;
    //NSRegularExpression类里面调用表达的方法需要传递一个NSError的参数。下面定义一个
    NSError *error;
    //http+:[^\\s]* 这个表达式是检测一个网址的。
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http+:[^\\s]*" options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            //从urlString当中截取数据
            NSString *result=[urlString substringWithRange:resultRange];
            if ([urlString isEqualToString:result]) {
                isUrl = YES;
            }
        }
    }
    
    //检查是否为https://
    NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"https+:[^\\s]*" options:0 error:&error];
    
    if (regex1 != nil) {
        NSTextCheckingResult *firstMatch=[regex1 firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            //从urlString当中截取数据
            NSString *result=[urlString substringWithRange:resultRange];
            if ([urlString isEqualToString:result]) {
                isUrl = YES;
            }
        }
    }
    return isUrl;
}

UIImage* captureView(UIView* view)
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [view bounds].size;
    //if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
	//else
	//	UIGraphicsBeginImageContext(imageSize);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Iterate over every window from back to front
	/*for (UIWindow *window in [[UIApplication sharedApplication] windows])
	{
		if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
		{
			// -renderInContext: renders in the coordinate space of the layer,
			// so we must first apply the layer's geometry to the graphics context
			CGContextSaveGState(context);
			// Center the context around the window's anchor point
			CGContextTranslateCTM(context, [window center].x, [window center].y);
			// Apply the window's transform about the anchor point
			CGContextConcatCTM(context, [window transform]);
			// Offset by the portion of the bounds left of and above the anchor point
			CGContextTranslateCTM(context,
								  -[window bounds].size.width * [[window layer] anchorPoint].x,
								  -[window bounds].size.height * [[window layer] anchorPoint].y);
			
			// Render the layer hierarchy to the current context
			[[window layer] renderInContext:context];
			
			// Restore the context
			CGContextRestoreGState(context);
		}
	}*/
	
	[view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

NSString* getMessage(int code)
{
//	if (code < 0)
//	{
//		//错误信息
//		NSString* strServerError = [[UFContext sharedContext] serverAccess].lastErrorMessage;
//		if (strServerError != nil)
//		{
//			NSString* result = [NSString stringWithString:strServerError];
//			[[UFContext sharedContext] serverAccess].lastErrorMessage = @"";
//			return result;
//		}
//		
//		//TODO
//		return @"";
//	}
//	else
//	{
//		//TODO
		return @"TODO";
//	}
}

NSString* getDocPath(int noUse)
{
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

NSString* getTempPath(BOOL autoCreate)
{
	NSString* tempPath = [NSString stringWithFormat:@"%@/Temp", getDocPath(1)];
	if (autoCreate)
		[[NSFileManager defaultManager] createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
	
	return tempPath;
}

NSString* getPhotoTempPath(BOOL autoCreate)
{
	NSString* tempPath = [NSString stringWithFormat:@"%@/TempPhoto", getDocPath(1)];
	if (autoCreate)
		[[NSFileManager defaultManager] createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
	
	return tempPath;
}

void waitSeconds(double seconds)
{
	NSDate* begin = [NSDate dateWithTimeIntervalSinceNow:0];
	NSRunLoop* curRunLoop = [NSRunLoop currentRunLoop];
	while ([curRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]])
	{
		NSDate* now = [NSDate dateWithTimeIntervalSinceNow:0];
		if([now timeIntervalSince1970] - [begin timeIntervalSince1970] >= seconds)
			break;
	}
}

UIImageView* createDummyView(UIView* view, CGRect rect)
{
	UIImage* image = captureView(view);
	CGRect frame = view.frame;
	frame.origin.x = frame.origin.y = 0;
	UIImageView* dummyView = [[UIImageView alloc] initWithFrame:frame];
	
	UIGraphicsBeginImageContext(frame.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
//	if (rect == nil)
//	{
//		[image drawInRect:frame];
//	}
//	else
//	{
		CGContextSaveGState(ctx);
		UIRectClip(rect);
		[image drawInRect:frame];
		CGContextRestoreGState(ctx);
//	}
	
	CGContextFlush(ctx);
	dummyView.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return dummyView;
}

UIImage* createColorImage(UIImage* sourceImage, UIColor* targetColor)
{
	// 根据原图像，产生指定颜色的新图像
	CGRect rect = CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height);
	UIGraphicsBeginImageContext(rect.size);
	[sourceImage drawInRect:rect];
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetBlendMode(ctx, kCGBlendModeColor);
	CGContextClipToMask(ctx, rect, sourceImage.CGImage); // this restricts drawing to within alpha channel
	CGContextSetFillColorWithColor(ctx, targetColor.CGColor);
	CGContextFillRect(ctx, rect);
	CGContextFlush(ctx);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();;
	UIGraphicsEndImageContext();
	return newImage;
}

NSString* regularPhoneNumber(NSString* string)
{
	string = findAndReplaceString(string, @"-", @"");
	string = findAndReplaceString(string, @"(", @"");
	string = findAndReplaceString(string, @")", @"");
	string = findAndReplaceString(string, @" ", @"");
	
	NSString* pattern;
	NSRegularExpression* regex;
	NSRange range = NSMakeRange(0, [string length]);
	NSInteger len = [string length];
	
	// 固定电话（仅号码）：
	pattern = @"\\b(\\d{7,8})\\b";
	regex = [NSRegularExpression regularExpressionWithPattern:pattern
													  options:NSRegularExpressionCaseInsensitive error:nil];
	if ([regex numberOfMatchesInString:string options:0 range:range] > 0 && (len == 7 || len == 8))
		return string;
	
	// 固定电话（区号+号码）：0xx-xxxxxx(7~8位)
	pattern = @"\\b(0\\d{2,3}\\d{7,8})\\b";
	regex = [NSRegularExpression regularExpressionWithPattern:pattern
													  options:NSRegularExpressionCaseInsensitive error:nil];
	if ([regex numberOfMatchesInString:string options:0 range:range] > 0 && (len >= 10 && len <= 12))
		return string;
	
	// 特殊电话：5位，如：96103
	pattern = @"\\b(\\d{5})\\b";
	regex = [NSRegularExpression regularExpressionWithPattern:pattern
													  options:NSRegularExpressionCaseInsensitive error:nil];
	if ([regex numberOfMatchesInString:string options:0 range:range] > 0 && len == 5)
		return string;
	
	// 手机（仅号码）
	pattern = @"\\b(1\\d{10})\\b";
	regex = [NSRegularExpression regularExpressionWithPattern:pattern
													  options:NSRegularExpressionCaseInsensitive error:nil];
	if ([regex numberOfMatchesInString:string options:0 range:range] > 0 && len == 11)
		return string;
	
	// 手机（国家+号码）,e.g.+8613811223344
	pattern = @"\\b\\+{0,1}\\d{1,2}(1\\d{10})\\b";
	regex = [NSRegularExpression regularExpressionWithPattern:pattern
													  options:NSRegularExpressionCaseInsensitive error:nil];
	if ([regex numberOfMatchesInString:string options:0 range:range] > 0 && (len >= 10 && len <= 15))
		return string;
	
	return nil;
}

NSString* regularMobilePhoneNumber(NSString* string){
	string = findAndReplaceString(string, @"-", @"");
	string = findAndReplaceString(string, @"(", @"");
	string = findAndReplaceString(string, @")", @"");
	string = findAndReplaceString(string, @" ", @"");
	
	NSString* pattern;
	NSRegularExpression* regex;
	NSRange range = NSMakeRange(0, [string length]);
	NSInteger len = [string length];

	// 手机（仅号码）
	pattern = @"\\b(1\\d{10})\\b";
	regex = [NSRegularExpression regularExpressionWithPattern:pattern
													  options:NSRegularExpressionCaseInsensitive error:nil];
	if ([regex numberOfMatchesInString:string options:0 range:range] > 0 && len == 11)
		return string;
	
//	// 手机（国家+号码）,e.g.+8613811223344
//	pattern = @"\\b\\+{0,1}\\d{1,2}(1\\d{10})\\b";
//	regex = [NSRegularExpression regularExpressionWithPattern:pattern
//													  options:NSRegularExpressionCaseInsensitive error:nil];
//	if ([regex numberOfMatchesInString:string options:0 range:range] > 0 && (len >= 10 && len <= 15))
//		return string;
	
	return nil;
}

BOOL isEMailAddress(NSString* string)
{
	NSString* pattern;
	NSRegularExpression* regex;
	NSRange range = NSMakeRange(0, [string length]);
	
	pattern = @"\\b(\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*)\\b";
	regex = [NSRegularExpression regularExpressionWithPattern:pattern
													  options:NSRegularExpressionCaseInsensitive error:nil];
	if ([regex numberOfMatchesInString:string options:0 range:range] > 0)
		return true;
	
	return false;
}

UIWindow* getMainWindow(int noUse)
{
	NSArray* windows = [UIApplication sharedApplication].windows;
	if (windows != nil && [windows count] > 0)
		return [windows objectAtIndex:0];
	
	return nil;
}

// 处理XML时，转换特殊字符；
//<表示方式是&it;
//>表示方式是&gt;
//&表示方式是&amp;
//"表示方式是&quot
NSString *encodeSpecialCharacter(NSString *string)
{
	string = findAndReplaceString(string, @"&", @"&amp;");
	string = findAndReplaceString(string, @"<", @"&lt;");
	string = findAndReplaceString(string, @">", @"&gt;");
	return string;
}

NSString *decodeSpecialCharacter(NSString *string)
{
	string = findAndReplaceString(string, @"&amp;", @"&");
	string = findAndReplaceString(string, @"&lt;", @"<");
	string = findAndReplaceString(string, @"&gt;", @">");
	return string;
}

/*void unzipFile(NSString* zipFile, NSString* targetPath)
{
	ZipArchive* zip;
}*/

UIImage* imageToImage(UIImage *srcImg, CGFloat width, CGFloat height) {
//    CGSize srcSize = [srcImg size];
    CGRect rec = CGRectMake(0, 0, width, height);
    
    //create a context to do our clipping in
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    [srcImg drawInRect:rec blendMode:kCGBlendModeNormal alpha:1.0];
    //create a rect with the size we want to crop the image to
    CGRect clippedRect = CGRectMake(0, 0, width, height);
    CGContextClipToRect(currentContext, clippedRect);
    
    //create a rect equivalent to the full size of the image
//    CGRect drawRect = CGRectMake(0, 0, srcSize.width, srcSize.height);
    
    CGContextTranslateCTM(currentContext, 0, height);  //画布的高度
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    //draw the image to our clipped context using our offset rect
//    CGContextDrawImage(currentContext, drawRect, srcImg.CGImage);
    
    UIImage *dstImg =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return dstImg;
}

UIImage* proportionScalingImage(UIImage* scrImg, CGFloat width, CGFloat height){
    int h = scrImg.size.height;
    int w = scrImg.size.width;
    float b = 0.0;
    if (!(width > 0)&& !(height > 0)) {
        if(h <= 320 && w <= 480){
            return imageToImage(scrImg, w, h);
        }else{
            b = (float)320/w < (float)480/h ? (float)320/w : (float)480/h;
            return imageToImage(scrImg, b*w, b*h);
        }
    }else if(width > 0 && !(height > 0)){
        b = width*h/w;
        return imageToImage(scrImg, width, b);
    }else if(!(width > 0) && height > 0){
        b = height*w/h;
        return imageToImage(scrImg, b, height);
    }else{
        return imageToImage(scrImg, width, height);
    }
    return nil;
}

NSString* getImagePath(NSString* originImageName, NSString* ext){
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 4.0){
    if (isHDScreen(1)) {
        originImageName = [NSString stringWithFormat:@"%@@2x",originImageName];
	}
    return [[NSBundle mainBundle] pathForResource:originImageName ofType:ext];
}

BOOL isPureInt(NSString* string){
    NSScanner* scan = [NSScanner scannerWithString:string]; 
    int val; 
    return[scan scanInt:&val] && [scan isAtEnd];
}

BOOL isPureDouble(NSString* string){
    NSScanner* scan = [NSScanner scannerWithString:string];
    double val;
    return[scan scanDouble:&val] && [scan isAtEnd];
}
//计算 宽度
CGFloat calculateTextWidth(NSString *strContent, UIFont *font){
    //    CGSize constraint = CGSizeMake(heightInput, heightInput);
    CGFloat constrainedSize = 26500.0f; //其他大小也行
    CGSize size = [strContent sizeWithFont:font
                         constrainedToSize:CGSizeMake(constrainedSize, CGFLOAT_MAX) 
                             lineBreakMode:NSLineBreakByWordWrapping];
    //    CGFloat height = MAX(size.height, 44.0f);
    return size.width;
}

BOOL isHDScreen(int noUse){
    static int hasHighResScreen = -1;
    
    if (hasHighResScreen > -1) {
        return hasHighResScreen;
    }
    
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        CGFloat scale = [[UIScreen mainScreen] scale];
        hasHighResScreen = NO;
        if (scale > 1.0) {
            hasHighResScreen = YES;
        }
    }
    
    return hasHighResScreen;
}

NSString *getITunesURLString(int noUse){
    return @"http://itunes.apple.com/lookup?id=534454809";
}

NSString *getBundleVersion(int noUse){
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //获取软件的版本号
    NSString *version = [infoDict objectForKey:@"CFBundleVersion"];
    
    return version;
}

UIColor* colorWithHexString(NSString* hexColor)
{
    if (!isStringEmpty(hexColor)) {
        unsigned int red, green, blue;
        NSRange range;
        range.length = 2;
        
        range.location = 1;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
        range.location = 3;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
        range.location = 5;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
        
        return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
    }else{
        return [UIColor clearColor];
    }

}

BOOL isContainChinese(NSString *str){
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            return true;
    }
    return false;
}

float formattedFileSize(unsigned long long size)
{
	NSString *formattedStr = [NSString stringWithFormat:@"%.2f", (size / pow(1024, 2))];
	return [formattedStr floatValue];
}

float getLabelHeight(NSString* str){
    NSString *tmpStr = [str length]>0?[str substringWithRange:NSMakeRange(1,[str length]-1)]:str;
    CGSize size = [tmpStr sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(160.0f, 200.0f) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height>40?size.height+5:40;
}


