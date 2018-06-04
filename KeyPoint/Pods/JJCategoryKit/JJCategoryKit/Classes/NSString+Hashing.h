

#import <Foundation/Foundation.h>
@interface NSString (NSString_Hashing)

//MD5加密
- (NSString *)MD5Hash;
/**
 *  处理异常字符串的问题
 */
+ (instancetype)stringAbnormal:(id)abnormalString;
@end
