//
//  Tool.h
//  JJPro
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DefuleWidth  375.0
#define DefuleHeight 667.0


@interface Tool : NSObject
+(Tool*) instance;

- (CGFloat)translatWidth:(CGFloat)width;
//根据宽度比例计算出高度 不能以实际屏幕屏幕比较 因为屏幕宽度一直 高度不一定一致或则说 view会变形
- (CGFloat)translatHeight:(CGFloat)height;
/**
 *  高度Jason 由于实际设计 宽度是和高度配合的  所以这里的高度只适合做view外部的计算.如果距离屏幕边框多多少
 *
 *  @param height <#height description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)translatRealHeight:(CGFloat)height;

/**
 获取当前版本号
 
 @return <#return value description#>
 */
- (NSString *)versionStr;

- (NSString *)appnameStr;

/**
 计算字符宽度

 @param str <#str description#>
 @param font <#font description#>
 @param size <#size description#>
 @return <#return value description#>
 */
+ (CGSize)getStringSize:(NSString*)str font:(UIFont*)font size:(CGSize)size;


/**
 加了Linebreak 和 lineSpace

 @param str <#str description#>
 @param font <#font description#>
 @param lineBreakMode <#lineBreakMode description#>
 @param lineSpacing <#lineSpacing description#>
 @param size <#size description#>
 @return <#return value description#>
 */
+ (CGSize)getStringSize:(NSString*)str font:(UIFont*)font lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpacing:(CGFloat)lineSpacing size:(CGSize)size;


+ (NSArray *)rangeOfSubString:(NSString *)subStr inString:(NSString *)string;


//写列表到本地dic
-(BOOL)writeListForDic:(NSDictionary*)list listName:(NSString*)listName;

//获取储存在本地的列表dic
-(NSDictionary*)getListForDic:(NSString*)listName;

-(NSArray*)getList:(NSString*)listName;
-(BOOL)writeList:(NSArray*)list listName:(NSString*)listName;

//删除
-(BOOL)deleteFile:(NSString*)fileName;


/**
 给一般label 加linespc

 @param str <#str description#>
 @param spc <#spc description#>
 @return <#return value description#>
 */
- (NSMutableAttributedString *)lineSpaceLable:(NSString *)str withSpc:(CGFloat)spc;

@end
