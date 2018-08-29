//
//  NSString+RegEx.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>
//================================== 正则、输入源 ==================================
/** 定义 输入类型 */
//数字
#define UA_Type_NUMBER      @"0123456789"
#define UA_Type_NUMBER_     @"0123456789."
//大写
#define UA_Type_CAPITAL     @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
//小写
#define UA_Type_LOWERCASE   @"abcdefghijklmnopqrstuvwxyz"
//大小写
#define UA_Type_CASE        @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
//大小写数字
#define UA_Type_KAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define UA_Type_KAlphaNum_  @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"

@interface NSString (RegEx)

//type 输入源 eg：type = @"0123456789."
//retern 过滤后的字符
- (NSString *)ua_componentsSeparatedInString:(NSString *)type;
//type 输入源 eg：type = @"0123456789."
//retern BOOL 字符是否符合规则
- (BOOL)ua_typeString:(NSString *)typeStr;

/*! 自己写正则传入进行判断*/
- (BOOL)ua_validateWithRegEx:(NSString *)RegEx;
//邮箱
- (BOOL)ua_validateEmail;
//手机号码验证
- (BOOL)ua_validateMobile;
//车牌号验证
- (BOOL)ua_validateCarNo;
//车型
- (BOOL)ua_validateCarType;
//用户名
- (BOOL)ua_validateUserName;
//密码
- (BOOL)ua_validatePassword;
//昵称
- (BOOL)ua_validateNickname;
//身份证号
- (BOOL)ua_validateIdentityCard;
//手机验证码-4位
- (BOOL)ua_validateCheckCode4;
//手机验证码-6位
- (BOOL)ua_validateCheckCode6;
//判断URL是否能够打开
- (void)ua_validateUrlBlock:(void(^)(BOOL))block;
@end
/*
 1 . 校验密码强度
 密码的强度必须是包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间。
 
 ^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$
 2. 校验中文
 字符串仅能是中文。
 
 ^[\\u4e00-\\u9fa5]{0,}$
 3. 由数字、26个英文字母或下划线组成的字符串
 ^\\w+$
 
 7. 校验金额
 金额校验，精确到2位小数。
 
 ^[0-9]+(.[0-9]{2})?$
 
 13. 提取URL链接
 下面的这个表达式可以筛选出一段文本中的URL。
 
 ^(f|ht){1}(tp|tps):\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- ./?%&=]*)?
 
 15. 提取Color Hex Codes
 有时需要抽取网页中的颜色代码，可以使用下面的表达式。
 
 ^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$
 16. 提取网页图片
 假若你想提取网页中所有图片信息，可以利用下面的表达式。
 
 \\< *[img][^\\\\>]*[src] *= *[\\"\\']{0,1}([^\\"\\'\\ >]*)
 17. 提取页面超链接
 提取html中的超链接。
 
 (<a\\s*(?!.*\\brel=)[^>]*)(href="https?:\\/\\/)((?!(?:(?:www\\.)?'.implode('|(?:www\\.)?', $follow_list).'))[^"]+)"((?!.*\\brel=)[^>]*)(?:[^>]*)>
 18. 查找CSS属性
 通过下面的表达式，可以搜索到相匹配的CSS属性。
 
 ^\\s*[a-zA-Z\\-]+\\s*[:]{1}\\s[a-zA-Z0-9\\s.#]+[;]{1}
 19. 抽取注释
 如果你需要移除HMTL中的注释，可以使用如下的表达式。
 
 <!--(.*?)-->
 20. 匹配HTML标签
 通过下面的表达式可以匹配出HTML中的标签属性。
 
 <\\/?\\w+((\\s+\\w+(\\s*=\\s*(?:".*?"|'.*?'|[\\^'">\\s]+))?)+\\s*|\\s*)\\/?>
 
 #define PhoneRegex       @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[0-9])|(17[0,3,5-8])|(18[0-9])|(147))\\d{8}$"
 #define EmailRegex       @"[A-Za-z0-9._-]+@[A-Za-z0-9._-]+\\.[A-Za-z]{2,5}"
 #define Name_normalStri  @"^[A-Za-z0-9\u4e00-\u9fa5]+$" //联系人名称
 #define Integer_all      @"^[0-9]*$" //验证数字类型
 */
