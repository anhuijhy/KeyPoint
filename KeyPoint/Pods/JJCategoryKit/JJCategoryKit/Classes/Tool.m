//
//  Tool.m
//  JJPro
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 Jason. All rights reserved.
//
#import "JJCategoryKitHeader.h"
#import "Tool.h"

@interface Tool ()
@end

@implementation Tool

+(Tool*) instance{
    
    static dispatch_once_t onceToken;
    static Tool *tool = nil;
    dispatch_once(&onceToken, ^{
        
        tool = [[Tool alloc] init];
        
    });
    
    return tool;
}

- (instancetype) init{
    
    if (self = [super init]) {
        
    }
    
    return self;
}

/**
 *  高度Jason 由于实际设计 宽度是和高度配合的  所以这里的宽度只适合做view外部的计算.如果距离屏幕边框多多少
 */
- (CGFloat)translatWidth:(CGFloat)width{
    
    return (kScreenWidth/DefuleWidth)*(width/2);
}

//根据宽度比例计算出高度 不能以实际屏幕屏幕比较 因为屏幕宽度一直 高度不一定一致或则说 view会变形
- (CGFloat)translatHeight:(CGFloat)height{
    
    return (kScreenWidth/DefuleWidth)*(height/2);
}

/**
 *  高度Jason 由于实际设计 宽度是和高度配合的  所以这里的高度只适合做view外部的计算.如果距离屏幕边框多多少
 *
 *  @param height <#height description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)translatRealHeight:(CGFloat)height{
    
    return (kScreenHeight/DefuleHeight)*(height/2);
}


/**
 获取当前版本号

 @return <#return value description#>
 */
- (NSString *)versionStr{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appCurVersion;
}


- (NSString *)appnameStr{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return appCurVersion;
}

+ (CGSize)getStringSize:(NSString*)str font:(UIFont*)font size:(CGSize)size{
    if([str isKindOfClass:[NSNull class]]){
        str = @"";
    }
    CGRect textFrame = CGRectZero;
    NSDictionary *attributes = @{NSFontAttributeName:font};
    textFrame = [str boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:attributes
                                  context:nil];
    return textFrame.size;
}


+ (CGSize)getStringSize:(NSString*)str font:(UIFont*)font lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpacing:(CGFloat)lineSpacing size:(CGSize)size{
    if([str isKindOfClass:[NSNull class]]){
        str = @"";
    }
    CGRect textFrame = CGRectZero;
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    [ps setLineBreakMode:lineBreakMode];
    if(lineSpacing>0){
        [ps setLineSpacing:lineSpacing];
    }
    
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:ps};
    textFrame = [str boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:attributes
                                  context:nil];
    return textFrame.size;
}

+ (NSArray *)rangeOfSubString:(NSString *)subStr inString:(NSString *)string {
    
    NSMutableArray *rangeArray = [NSMutableArray array];
    
    NSString *string1 = [string stringByAppendingString:subStr];
    
    NSString *temp;
    
    for (int i = 0; i < string.length; i ++) {
        
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        
        if ([temp isEqualToString:subStr]) {
            
            NSRange range = {i,subStr.length};
            
            [rangeArray addObject:NSStringFromRange(range)];
            
        }
        
    }
    
    return rangeArray;
    
}


//写入dic
-(BOOL)writeListForDic:(NSDictionary*)list listName:(NSString*)listName//写列表到本地dic
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   documentDirectory = [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",listName]];
    BOOL b = [list writeToFile:path atomically:YES];
    return b;
}

//获取dic
-(NSDictionary*)getListForDic:(NSString*)listName//获取储存在本地的列表dic
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   documentDirectory = [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",listName]];
    NSDictionary *a = [NSDictionary dictionaryWithContentsOfFile:path];
    if([a isKindOfClass:[NSNull class]] || a.count == 0)
        return [NSDictionary dictionary];
    else
        return a;
}


-(NSArray*)getList:(NSString*)listName//获取储存在本地的列表
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   documentDirectory = [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",listName]];
    NSArray *a = [NSArray arrayWithContentsOfFile:path];
    if([a isKindOfClass:[NSNull class]] || a.count == 0)
        return [NSArray array];
    else
        return a;
}
-(BOOL)writeList:(NSArray*)list listName:(NSString*)listName//写列表到本地
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   documentDirectory = [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",listName]];
    BOOL b = [list writeToFile:path atomically:YES];
    return b;
}


//删除dic
-(BOOL)deleteFile:(NSString*)fileName//删除储存在本地的文件
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   documentDirectory = [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    BOOL b = [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    return b;
}


- (NSMutableAttributedString *)lineSpaceLable:(NSString *)str withSpc:(CGFloat)spc{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spc];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    return attributedString;
}

- (NSDictionary *)urlDic:(NSString *)kvstr{

    NSURLComponents *com = [[NSURLComponents alloc] initWithString:kvstr];
    DBLog(@"url query 字符串%@",com.queryItems);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < [com.queryItems count]; i++) {
        
        NSURLQueryItem *itmq = com.queryItems[i];
        [dic setObject:[NSString stringAbnormal:itmq.value] forKey:[NSString stringAbnormal:itmq.name]];
    }

    return dic;
}
@end
