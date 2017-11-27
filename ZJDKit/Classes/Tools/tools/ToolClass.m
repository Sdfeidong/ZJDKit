//
//  ToolClass.m
//  NEWSapp
//
//  Created by aidong on 14-10-28.
//  Copyright (c) 2014年 aidong. All rights reserved.
//

#import "ToolClass.h"
#import "YYkit.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "ZJD_Header.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYKit.h"

@implementation ToolClass

+ (void)simpleAlertWithTips:(NSString *)tips withAlert:(NSString *)alert superVC:(UIViewController *)superVC isAutoDismiss:(BOOL)isAutoDismiss {
    
    // 延时
    double delayInSeconds = 1.5f;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:tips message:alert preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    
    UIViewController *rootVC = nil;
    if (superVC) {
        rootVC = superVC;
    } else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        rootVC = window.rootViewController;
    }
    
    [rootVC presentViewController:alertController animated:YES completion:^{
        
    }];
    
    if (isAutoDismiss) {
        // 设置2.0秒后alertController自动消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
            
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
    }
}

#pragma mark - SDImageCache清理
+ (void)SDImageCacheClearWithSleepTimeInterval:(CGFloat)TimeInterval SDWebImageManagerCancelAll:(BOOL)cancelAll{
    
    // 停止下载图片 一般不可启用
    if (cancelAll) {
        [[SDWebImageManager sharedManager] cancelAll];
    }
    
    // 清除内存缓存图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
    // 这两句应该
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
    // 停顿
    [NSThread sleepForTimeInterval:TimeInterval];
}

#pragma mark - image

- (void)hahah{
    /**
     *UPLOADS_ROOT_PATH
     
     RESOURCE_PATH
     
     RESOURCE_TRANSFORM_PATH
     
     RESOURCE_TRANSFORM_PATH =》 untransform,transform
     
     rt_id
     1 => image
     2 => video
     3 => audio
     4 => document
     5 => other
     肖连义  05:54:42
     Uploads\Resource\transform\image\20150915.rf_savename
     *
     */
}

/**
 *  资源类文件
 */
+ (UIImage *)getResourceWithRf_transform_status:(NSString *)status rt_id:(NSString *)rt_id timeStr:(NSString *)timeStr saveName:(NSString *)saveName{
    
    NSString *finalUrlStr = [ToolClass getResourceImageURL_StrWithRf_transform_status:status rt_id:rt_id timeStr:timeStr saveName:saveName];
    
    return [ToolClass imageWithStrUrl:finalUrlStr];
}
+ (NSString *)getResourceImageURL_StrWithRf_transform_status:(NSString *)status rt_id:(NSString *)rt_id timeStr:(NSString *)timeStr saveName:(NSString *)saveName{
    
    NSArray *rt_id_arr = @[@"",@"image",@"video",@"audio",@"document",@"other"];
    rt_id = ([rt_id integerValue] > 5 || [rt_id integerValue] < 0) ? @"0" : rt_id;
    NSString *rt_str = rt_id_arr[[rt_id integerValue]];
    
    NSString *urlStr = @"";
    if ([status integerValue] == 0) {
        urlStr = @"./Uploads/Resource/untransform/";
    } else {
        urlStr = @"./Uploads/Resource/transform/";
    }
    
    NSString *timeNum = [NSDate get_yyyyMMdd_DateFromTimestamp:timeStr];
    urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@",rt_str,timeNum,saveName]];
    
    // 不带IP后的Str
    NSString *halfUrlStr = urlStr;
    return halfUrlStr;
}
/**
 *  根据数据获取资源地址
 */
+ (NSString *)getResourceImageUrlStrWithResourceDict:(NSDictionary *)reDict{
    
    NSString *halfUrl = [ToolClass getResourceImageURL_StrWithRf_transform_status:reDict[@"rf_transform_status"] rt_id:reDict[@"rt_id"] timeStr:reDict[@"rf_created"] saveName:reDict[@"rf_savename"]];
    return [ToolClass imageUrlWithStrUrl:halfUrl];
}

/**
 *  头像类文件
 */
+ (UIImage *)getAvatarWithUser_id:(NSString *)user_id withExt:(NSString *)ext{
    
    NSString *finalUrlStr = [ToolClass getAvatarImageUrlWithUser_id:user_id withExt:ext];
    return [ToolClass imageWithStrUrl:finalUrlStr];
}
+ (NSString *)getAvatarImageUrlWithUser_id:(NSString *)user_id withExt:(NSString *)ext{
    
    //    NSString *urlStr = @"./Uploads/Auth/";
    //    NSInteger  tempID = [user_id integerValue]%1000;
    //    NSString *md5Str = [[NSString stringWithFormat:@"%@%@",KF_ENCRYPT_KEY,user_id] md5String];
    //    NSString *avatarStr = [NSString stringWithFormat:@"%@%ld/%@/%@.%@",urlStr,(long)tempID,user_id,md5Str,ext];
    //
    //    // 不带IP后的Str
    //    NSString *halfUrlStr = avatarStr;
    //    // 完整的URLStr
    //    NSString *completeStr = [ToolClass imageUrlWithStrUrl:halfUrlStr];
    //    return completeStr;
    return nil;
}

+ (NSString *)getOwnAvatarUrlStr{
    return nil;
    //    return [ToolClass getAvatarImageUrlWithUser_id:[UserEntity sharedInstance].user_id withExt:[UserEntity sharedInstance].user_avatar_ext];
}
/**
 *  科学实践活动AB面路径的获取
 */
+ (NSString *)getActivityCoverImageURL_StrWithCo_id:(NSString *)co_id ac_ext:(NSString *)ac_ext A_or_B:(NSString *)ab{
    
    NSString *urlStr = @"./Uploads/Course/";
    NSInteger tempID = [co_id integerValue]%1000;
    NSString *md5Str = [[NSString stringWithFormat:@"JSQ_XK_2015%@%@",co_id,ab] md5String];
    NSString *avatarStr = [NSString stringWithFormat:@"%@%ld/%@/%@.%@",urlStr,(long)tempID,co_id,md5Str,ac_ext];
    
    // 不带IP后的Str
    NSString *halfUrlStr = avatarStr;
    return halfUrlStr;
}

+ (UIImage *)getActivityCoverWithCo_id:(NSString *)co_id ac_ext:(NSString *)ac_ext A_or_B:(NSString *)ab{
    
    NSString *finalUrlStr = [ToolClass getActivityCoverImageURL_StrWithCo_id:co_id ac_ext:ac_ext A_or_B:ab];
    
    NSLog(@"%@",finalUrlStr);
    return [ToolClass imageWithStrUrl:finalUrlStr];
}


+ (UIImage *)imageWithStrUrl:(NSString *)url{
    
    NSString *urlStr = [ToolClass imageUrlWithStrUrl:url];
    if (urlStr == nil) {
        return nil;
    }
    
    // 以下代码完全有效。
    // 可解决大量的图片缓存问题。
    NSData *imageData = nil;
    NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:urlStr]];
    if (cacheImageKey.length) {
        NSString *cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
        if (cacheImagePath.length) {
            imageData = [NSData dataWithContentsOfFile:cacheImagePath];
        }
    }
    
    if (!imageData) {
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    }
    
    UIImage *img = [[UIImage alloc] initWithData:imageData];
    return img;
}

+ (NSString *)imageUrlWithStrUrl:(NSString *)url{
    
    if (!kStringIsNotEmpty(url)) {
        return nil;
    }
    
    @try {
        
        if ([url containsString:@"http"]) {
            return url;
        }
        
        return nil;
    }
    @catch (NSException *exception) {
        
        return nil;
        
    }
    @finally {
        
    }
    
}

+ (UIImage *) imageFromView: (UIView *)theView {
    // draw a view's contents into an image context
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef  context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
/**
 *  头像的加载 原 200 * 267 先截取上部分 200 * 200 再填充 IV
 */
+ (void)setAvatarImageWithImageURL:(NSURL *)url avatar_IV:(UIImageView *)avatar_IV{
    
    [avatar_IV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"social_默认头像"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        
        if (image) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.width)];
            [iv setImage:image];
            iv.contentMode = UIViewContentModeTop;
            ViewRadius(iv, 0);
            
            UIImage *image_new = [ToolClass imageFromView:iv];
            [avatar_IV setImage:image_new];
        }
    }];
    
    avatar_IV.contentMode = UIViewContentModeScaleAspectFill;
    ViewRadius(avatar_IV, 1);
}

#pragma mark - 图片变模糊处理
+ (UIImage *)transferBlurImage:(UIImage *)image withBlurLevel:(CGFloat)blur rect:(CGRect)rect
{
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage,
                        @"inputRadius", @(blur),
                        nil];
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage:outputImage fromRect:rect];
    UIImage *returnImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return returnImage;
}


/**
 *颜色值转换成图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ ( NSString *)imageWithUrl:(NSString *)uStr1 :(NSString *)uStr2 :(NSString *)uStr3{
    
    // 图片根据 url 请求
    
    //NSString *url = [NSString stringWithFormat:@"%@%@%@/%@.%@",NewsIP,ARTICLE_FILE_PATH,uStr1,uStr2,uStr3];
    
    //NSLog(@"imgUrl :%@",url);
    
    //    NSData *imgData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    //    UIImage *img = [[UIImage alloc] initWithData:imgData];
    
    return uStr1;
}

// NSData 转 数组或字典
+(id)iOS5_JSONObjectWithData:(NSData *)jsonData{
    
    // iOS5 自带解析类解析
    // NSData *jsonData = [sender responseData];
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    if (jsonData!=nil && error==nil) {
        
        if ([jsonData isKindOfClass:[NSArray class]]) {
            
        }else if ([jsonData isKindOfClass:[NSDictionary class]]){
            
        }else{
            
            NSLog(@"An error happened while deserializing the JSON data.");
        }
    }else{
        
    }
    
    return jsonObject; //  无论什么结果都返回jsonObject
}

// 数组或字典转NSData
+ (NSData *)objectToJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

#pragma -mark NSString

/**
 *  字符 @“A” 、@“B”、@“C” ... 转数字 @“1”、@“2”、@“3”
 */
+ (NSString *)numberStringWithCharacterString:(NSString *)charStr {
    
    if (kStringIsNotEmpty(charStr)) {
        
        if ([charStr isEqualToString:@"A"]) {
            return @"1";
        } else if ([charStr isEqualToString:@"B"]) {
            return @"2";
        } else if ([charStr isEqualToString:@"C"]) {
            return @"3";
        } else if ([charStr isEqualToString:@"D"]) {
            return @"4";
        } else if ([charStr isEqualToString:@"E"]) {
            return @"5";
        } else if ([charStr isEqualToString:@"F"]) {
            return @"6";
        } else if ([charStr isEqualToString:@"G"]) {
            return @"7";
        } else {
            return @"0";
        }
        
    } else {
        return @"0";
    }
}

/**
 *  字符串拼接 如：（A,B,C,D）
 *
 *  @param array  array 拼接的字符串的数组
 *  @param midStr @","
 *
 *  @return A,B,C,D
 */
+ (NSString *)StringByArrayStr:(NSArray <NSString *> *)array midStr:(NSString *)midStr {
    
    // 注意有可能传过来空格 @“ ”
    NSString *ids = nil;
    for (NSString *index in array) {
        ids = (ids == nil) ? index : [NSString stringWithFormat:@"%@%@%@",ids,midStr,index];
    }
    return ids;
}

/**
 *  字符串替换
 */
+ (NSString *)string:(NSString *)originalStr withSearchStr:(NSString *)search withReplace:(NSString *)replace{
    originalStr = [originalStr stringByReplacingOccurrencesOfString:search withString:replace];
    return originalStr;
}

/**
 *  HTML字符串替换
 */
+ (NSString *)replaceHtmlStr:(NSString *)htmlStr{
    
    NSString *notice = [ToolClass string:htmlStr withSearchStr:@"&amp;" withReplace:@"&"];
    notice = [ToolClass string:notice withSearchStr:@"&nbsp;" withReplace:@" "];
    notice = [ToolClass string:notice withSearchStr:@"&lt;" withReplace:@"<"];
    notice = [ToolClass string:notice withSearchStr:@"&gt;" withReplace:@">"];
    notice = [ToolClass string:notice withSearchStr:@"&#039;" withReplace:@"'"];
    notice = [ToolClass string:notice withSearchStr:@"&quot;" withReplace:@"\""];
    
    // other
    notice = [ToolClass string:notice withSearchStr:@"&ldquo;" withReplace:@"“"];
    notice = [ToolClass string:notice withSearchStr:@"&rdquo;" withReplace:@"”"];
    
    notice = [ToolClass string:notice withSearchStr:@"&middot;" withReplace:@"·"];
    notice = [ToolClass string:notice withSearchStr:@"&mdash;" withReplace:@"-"];
    
    notice = [ToolClass string:notice withSearchStr:@"<br/" withReplace:@""];
    
    return notice;
}


/**
 *  截取字符串 (向前截取)
 */
+ (NSString *)fromString:(NSString *)originalStr withString:(NSString *)midStr{
    
    NSRange range = [originalStr rangeOfString:midStr];
    NSUInteger location = range.location;
    // 被截取字符串 前边的部分
    NSString *headerStr = [originalStr substringToIndex:location];
    // 被截取字符串 后边的部分
    //NSString *footerStr = [originalStr substringFromIndex:location+1];
    
    return headerStr;
}
/**
 *  截取字符串 (向后截取)
 */
+ (NSString *)backwardFromString:(NSString *)originalStr withString:(NSString *)midStr{
    
    if (![originalStr containsString:midStr]) {
        return originalStr;
    }
    
    NSRange range = [originalStr rangeOfString:midStr];
    NSUInteger location = range.location;
    // 被截取字符串 后边的部分
    NSString *footerStr = [originalStr substringFromIndex:(location + midStr.length)];
    
    return footerStr;
}

/**
 *  替换字符串 (向后截取)
 */
+ (NSString *)fromString:(NSString *)originalStr withString:(NSString *)midStr appendingStr:(NSString *)appendingStr{
    
    return [[ToolClass fromString:originalStr withString:midStr] stringByAppendingString:appendingStr];
}

+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font{
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize resultSize = [string sizeWithAttributes:attribute];
    return resultSize;
}

+ (CGSize)getSingleRowSizeWithString:(NSString *)string
                            withFont:(UIFont *)font{
    CGSize size =[string sizeWithAttributes:@{NSFontAttributeName:font}];
    return size;
}

+ (CGSize)string:(NSString *)string boundingRectWithWidth:(CGFloat)width font:(UIFont *)font{
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize resultSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                             options:\
                         NSStringDrawingTruncatesLastVisibleLine |
                         NSStringDrawingUsesLineFragmentOrigin |
                         NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return resultSize;
}

/**
 *  字典转json字符串 （按自定义的key顺序转换）
 */
+ (NSString *) jsonStrWithDict:(NSDictionary *)dict keyArr:(NSArray *)keyArr {
    
    NSString *jsonStr = @"{";
    for (NSInteger i = 0; i < [keyArr count]; i++) {
        
        if (i == 0) {
            jsonStr = [jsonStr stringByAppendingString:[ToolClass jsonItemKey:keyArr[i] dict:dict isFrist:YES]];
        } else {
            jsonStr = [jsonStr stringByAppendingString:[ToolClass jsonItemKey:keyArr[i] dict:dict isFrist:NO]];
        }
    }
    // 最后 “}”;
    jsonStr = [jsonStr stringByAppendingString:@"}"];
    
    return jsonStr;
}

/**
 *  字典转XML字符串 （按自定义的key顺序转换）
 */
+ (NSString *) xmlStrWithDict:(NSDictionary *)dict keyArr:(NSArray *)keyArr headMsg:(NSString *)headMsg headNode:(NSString *)headNode {
    
    NSString *xmlString = @"";
    headNode = (kStringIsNotEmpty(headNode)) ? headNode : @"param";
    xmlString = (kStringIsNotEmpty(headMsg)) ? headMsg : @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
    xmlString = [NSString stringWithFormat:@"%@\n<%@>\n</%@>",xmlString,headNode,headNode];
    
    NSString *paramStr = @"";
    for (NSString *key in keyArr) {
        paramStr = [NSString stringWithFormat:@"%@\n <%@>%@</%@>",paramStr,key,dict[key],key];
    }
    
    NSString *searchStr = [NSString stringWithFormat:@"<%@>",headNode];
    xmlString = [ToolClass string:xmlString withSearchStr:searchStr withReplace:[NSString stringWithFormat:@"%@%@",searchStr,paramStr]];
    return xmlString;
}

+ (NSString *)jsonItemKey:(NSString *)key dict:(NSDictionary *)dict isFrist:(BOOL)isFrist{
    
    NSString *jsonItem = [NSString stringWithFormat:@"\"%@\":\"%@\"",key,dict[key]];
    return (isFrist) ? jsonItem : [NSString stringWithFormat:@",%@",jsonItem];
}

#pragma -mark label
/**
 *  label.text 行间距排列
 */
+ (void)labelText:(NSString *)string withLabel:(UILabel *)label withLabelSpace:(CGFloat)space limitRows:(NSInteger)number{
    
    if (string.length < 1) {
        return;
    }
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    label.numberOfLines = number;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    [label setAttributedText:attributedString];
}
/**
 *  string 获取高度
 */
+ (CGFloat)getStringHeightWithText:(NSString *)string withLabelWidth:(CGFloat)width withTextFont:(UIFont *)font withSpace:(CGFloat)space{
    
    // CGSize size = [label2 sizeThatFits:CGSizeMake(label2.width, MAXFLOAT)];
    
    // 整体文字高度
    CGSize strSize = [ToolClass string:string boundingRectWithWidth:width font:font];
    // 单行文字高度 - 10 计算文字显示偏差
    CGSize rowSize = [ToolClass string:@"test" boundingRectWithWidth:width font:font];
    
    // (行数-1)*间距
    NSInteger row = strSize.height/rowSize.height + 1;
    
    return CEIL(row * space + strSize.height);
}

/**
 *  label 获取高度
 */
+ (CGFloat)getLabelHeightWithText:(NSString *)string withLabel:(UILabel *)label withSpace:(CGFloat)space{
    
    return [ToolClass getStringHeightWithText:label.text withLabelWidth:label.width withTextFont:label.font withSpace:space];
}
/**
 *  获取一段文字的高度 space(行间距)针对可显示的TextView
 */
+ (CGFloat)getHeightWithString:(NSString *)string rectWidth:(CGFloat)width textFont:(UIFont *)font space:(CGFloat)space{
    
    // 文字信息宽度
    CGFloat TextWdith = width;
    // 单行文字高度
    CGSize rowSize = [ToolClass string:@"test" boundingRectWithWidth:TextWdith font:font];
    
    CGFloat resultHeight = 0;
    // 文字
    if (kStringIsNotEmpty(string)) {
        // 实际情况 还得再减*，每行边上没有字
        CGSize ttSize = [ToolClass string:string boundingRectWithWidth:TextWdith - space font:font];
        // 行高+间距
        resultHeight = ceil(ttSize.height/rowSize.height) * (rowSize.height+space) + space;
        // 多少行
        //NSLog(@"%f",ttSize.height/rowSize.height);
    } else {
        resultHeight = 10;
    }
    return resultHeight;
}
+ (UILabel *)labelWithText:(NSString *)string withLabelWidth:(CGFloat)width withSpace:(CGFloat)space withFont:(UIFont*)font limitRows:(NSInteger)number{
    
    if (!kStringIsNotEmpty(string)) {
        string = @"0";
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 0, 0, width, 0)];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = number;
    label.font = font;
    label.text = string;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    // 刚刚合适的size
    CGSize size = [label sizeThatFits:CGSizeMake(label.width, MAXFLOAT)];
    // 整体文字高度
    CGSize strSize = [ToolClass string:string boundingRectWithWidth:label.width font:label.font];
    // 单行文字高度
    CGSize rowSize = [ToolClass string:@"test" boundingRectWithWidth:label.width font:label.font];
    
    if (number == 0) {
        // 不限制行
        // (行数-1)*间距
        label.height = (strSize.height/rowSize.height - 1) * space + size.height;
    } else {
        label.height = (number - 1) * space + size.height;
    }
    
    label.height = label.height;
    
    [ToolClass labelText:string withLabel:label withLabelSpace:space limitRows:number];
    
    return label;
}


+ (void)labelText:(NSString *)string textColor:(UIColor *)textColor withLabel:(UILabel *)label withRangeString:(NSString *)rangeStr rangeColor:(UIColor *)rangeColor{
    
    NSRange range = [string rangeOfString:rangeStr];
    NSMutableAttributedString*attribute = [[NSMutableAttributedString alloc] initWithString: string];
    [attribute addAttributes: @{NSForegroundColorAttributeName: textColor}range: NSMakeRange(0, range.location)];
    [attribute addAttributes: @{NSForegroundColorAttributeName: rangeColor}range: range];
    
    [label setText: string];
    [label setAttributedText: attribute];
}
/**
 *  导航栏中心label
 */
+ (UILabel *)navCenterTitleLabelWithUILabel:(UILabel *)label{
    
    [label setFont:BOLDSYSTEMFONT(18)];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

#pragma mark - Img_label_View
+ (UIView *)getImg_label_ViewWithImage:(UIImage *)image img_width:(CGFloat)img_width label_text:(NSString *)label_text label_font:(UIFont *)label_font text_color:(UIColor *)text_color image_label_space:(CGFloat)space{
    
    UIView *img_label = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 0, img_width)];
    img_label.backgroundColor = [UIColor clearColor];
    img_label.userInteractionEnabled = YES;
    
    UIImageView *imgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, (img_label.height - img_width)/2, img_width, img_width)];
    imgIV.image = image;
    [img_label addSubview:imgIV];
    imgIV.userInteractionEnabled = YES;
    
    CGFloat label_width = [ToolClass getSingleRowSizeWithString:label_text withFont:label_font].width + 2;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( imgIV.right + space, 0, label_width, img_label.height)];
    label.font = label_font;
    label.text = label_text;
    label.textColor = text_color;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    [img_label addSubview:label];
    label.userInteractionEnabled = YES;
    
    img_label.width = label.right;
    return img_label;
}

#pragma mark - NSString
//
+ (BOOL)verifyStringisNumber:(NSString *)string{
    
    // 编写正则表达式：只能是英文
    NSString *regex = @"^[0-9]*$";
    //    NSString *regex = @"^[a-zA-Z]*$";
    // 创建谓词对象并设定条件的表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    // 对字符串进行判断
    if ([predicate evaluateWithObject:string]) {
        return YES;
    } else {
        return NO;
    }
}
/*0--1 : lerp( float percent, float x, float y ){ return x + ( percent * ( y - x ) ); };*/
+ (float)lerp:(float)percent min:(float)nMin max:(float)nMax
{
    float result = nMin;
    
    result = nMin + percent * (nMax - nMin);
    
    return result;
}

/**
 * 渐变图层
 */
+ (void) insertTransparentGradientView:(UIView *)tempView{
    UIColor *colorOne = [UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:0.0];
    UIColor *colorTwo = [UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:0.5];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor,nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    //crate gradient layer
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = tempView.bounds;
    
    [tempView.layer insertSublayer:headerLayer atIndex:0];
}

#pragma mark - 排序
/**
 *  选择排序 数组里都是dict 排序关键字是可转int  ascending 升（YES）/降
 */

+ (NSArray *)selectSortWithArray:(NSArray *)arrDict keywords:(NSString *)keywords ascending:(BOOL)ascending{
    
    if ([arrDict count] < 1) {
        return arrDict;
    }
    
    if (!kStringIsNotEmpty(keywords)) {
        return arrDict;
    }
    
    //    // 验证key是否为数字
    //    NSString *regex =  @"^[1-9]d*|0$"; //非负整数（正整数 + 0） ;
    //    if (![keywords isValidateWithRegex:regex]) {
    //        return arrDict;
    //    }
    
    // 选择排序
    NSMutableArray *keyArr = [NSMutableArray new];
    for (NSDictionary *dic in arrDict) {
        NSString *key = [NSString stringWithFormat:@"%@",dic[keywords]];
        if (kStringIsNotEmpty(key)) {
            [keyArr addObject:key];
        }
    }
    
    NSArray *arr_key_new = (ascending == YES) ? [ToolClass selectSortWithArray:[keyArr copy]] : [ToolClass selectSortReverseOrderWithArray:[keyArr copy]];
    
    NSMutableArray *arData = [NSMutableArray new];
    for (NSString *key in arr_key_new) {
        for (NSDictionary *dict in arrDict) {
            NSString *key0 = [NSString stringWithFormat:@"%@",dict[keywords]];
            if ([key isEqualToString:key0]) {
                [arData addObject:dict];
                break;
            }
        }
    }
    return arData;
    
}
/**
 *  选择排序 数组里都是dict 排序关键字是可转int (顺序)
 */
+ (NSArray *)selectSortWithArray:(NSArray *)arrDict keywords:(NSString *)keywords{
    return [ToolClass selectSortWithArray:arrDict keywords:keywords ascending:YES];
}
/**
 *  选择排序 数组里都是可转int (顺序)
 */
+ (NSArray *)selectSortWithArray:(NSArray *)aData{
    
    if ([aData count] < 2) {
        return aData;
    }
    
    NSMutableArray *data = [[NSMutableArray alloc]initWithArray:aData];
    for (int i=0; i<[data count]-1; i++) {
        int m =i;
        for (int j =i+1; j<[data count]; j++) {
            if ([[data objectAtIndex:j] integerValue] < [[data objectAtIndex:m] integerValue]) {
                m = j;
            }
        }
        if (m != i) {
            [self swapWithData:data index1:m index2:i];
        }
    }
    //NSLog(@"选择排序后的结果：%@",[data description]);
    return [data copy];
}
/**
 *  选择排序 数组里都是可转int (倒序)
 */
+ (NSArray *)selectSortReverseOrderWithArray:(NSArray *)aData{
    
    if ([aData count] < 2) {
        return aData;
    }
    
    NSMutableArray *data = [[NSMutableArray alloc]initWithArray:aData];
    for (int i=0; i<[data count]-1; i++) {
        int m =i;
        for (int j =i+1; j<[data count]; j++) {
            if ([[data objectAtIndex:j] integerValue] > [[data objectAtIndex:m] integerValue]) {
                m = j;
            }
        }
        if (m != i) {
            [self swapWithData:data index1:m index2:i];
        }
    }
    //NSLog(@"选择排序后的结果：%@",[data description]);
    return [data copy];
}
+ (void)swapWithData:(NSMutableArray *)aData index1:(NSInteger)index1 index2:(NSInteger)index2{
    NSNumber *tmp = [aData objectAtIndex:index1];
    [aData replaceObjectAtIndex:index1 withObject:[aData objectAtIndex:index2]];
    [aData replaceObjectAtIndex:index2 withObject:tmp];
}

/**
 排序 前提是 mutArr 中是 dict 且 dict 存在 key
 
 @param mutArr 目标数组
 @param key 对关键字排序
 @param ascend 是否升序
 @return 结果数组
 */
+ (NSMutableArray *)sortArrayWithMutableArray:(NSMutableArray *)mutArr Key:(NSString *)key ascending:(BOOL)ascend{
    // 排序 前提是 mutArr 中是 dict 且 dict 存在 key
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascend]];
    [mutArr sortUsingDescriptors:sortDescriptors];
    return mutArr;
}

/**
 *  sortDescriptor  排序
 *
 *  dataArray       源数据
 *  keyArray        排序的关键字
 *  ascendingArray  升降序数组 @[@YES,@YES]
 */
+ (NSMutableArray *)sortDescriptorWithDataArray:(NSMutableArray *)dataArray keyArray:(NSArray *)keyArray ascendingArray:(NSArray *)ascendingArray{
    
    NSMutableArray *descArr = [NSMutableArray new];
    for (NSInteger i = 0; i < [keyArray count]; i++) {
        
        if ([ascendingArray count] >= i && ascendingArray[i]) {
            [descArr addObject:[NSSortDescriptor sortDescriptorWithKey:keyArray[i] ascending:(BOOL)ascendingArray[i]]];
        } else {
            // 默认 YES 升序
            [descArr addObject:[NSSortDescriptor sortDescriptorWithKey:keyArray[i] ascending:YES]];
        }
    }
    [dataArray sortUsingDescriptors:descArr];
    return dataArray;
}

#pragma mark - NSUserDefault
/**
 清除 所有NSUserDefault的数据
 */
+ (void)cleanAllUserDefault{
    NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [defatluts dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys]){
        [defatluts removeObjectForKey:key];
        [defatluts synchronize];
    }
}
#pragma mark - 判断对象是否为空
/**
 *  判断对象是否为空
 *  PS：nil、NSNil、@""、@0 以上4种返回YES
 *
 *  @return YES 为空  NO 为实例对象
 */
+ (BOOL)isNullOrNilWithObject:(id)object {
    
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)object;
        if (kStringIsValid(string)) {
            return NO;
        } else {
            return YES;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *num = (NSNumber *)object;
        if ([num isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

/**
 *  判断对象是否为非空字典
 */
+ (BOOL)isNotEmptyDict:(id)object {
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)object;
        if ([dict.allKeys count] > 0) {
            return YES;
        }
    }
    return NO;
}

/**
 *  判断对象是否为非空数组
 */
+ (BOOL)isNotEmptyArray:(id)object {
    
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)object;
        if ([array count] > 0) {
            return YES;
        }
    }
    return NO;
}
/**
 *  判断对象是数组 但为空
 */
+ (BOOL)isEmptyArray:(id)object {
    
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)object;
        if ([array count] == 0) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 其它
/**
 当前账号是否支持 指纹登录验证
 
 @return YES/NO
 */
+ (BOOL)isCurrentAccountSupportTouch:(NSString *)sud_key {
    
    if (![NUD_SUD objectForKey:sud_key]) {
        // 不存在登录的账号
        return NO;
    }
    // 获取 LogFlag 值来
    BOOL isTouch = [NUD_SUD boolForKey:[NUD_SUD objectForKey:sud_key]];
    return isTouch;
}

+ (void)telephoneTnterviewWithTel:(NSString *)tel {
    // 电话咨询
    UIWebView * callWebview = [[UIWebView alloc]init];
    tel = [NSString stringWithFormat:@"tel:%@",tel];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tel]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}

/**
 *  是否调用系统相机
 */
+ (BOOL)isCanOpenCamera {
    //判断是否已授权
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == ALAuthorizationStatusDenied||authStatus == ALAuthorizationStatusRestricted) {
            [ToolClass simpleAlertWithTips:@"提示" withAlert:@"请前往设置->隐私->相机授权应用拍照权限" superVC:nil isAutoDismiss:NO];
            return NO;
        }
    }
    // 判断是否可以打开相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return YES;
    } else {
        if (TARGET_IPHONE_SIMULATOR) {
            [ToolClass simpleAlertWithTips:@"提示" withAlert:@"模拟器不支持摄像头功能" superVC:nil isAutoDismiss:NO];
        } else {
            [ToolClass simpleAlertWithTips:@"提示" withAlert:@"摄像头损坏" superVC:nil isAutoDismiss:NO];
        }
        return NO;
    }
}
/**
 *  是否可以调用系统相册
 */
- (BOOL)isCanOpenPhoto {
    //判断是否已授权
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusDenied) {
            [ToolClass simpleAlertWithTips:@"提示" withAlert:@"请前往设置->隐私->相册授权应用访问相册权限" superVC:nil isAutoDismiss:NO];
            return NO;
        }
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return YES;
    } else {
        [ToolClass simpleAlertWithTips:@"提示" withAlert:@"不支持调用相册" superVC:nil isAutoDismiss:NO];
        return NO;
    }
}
#pragma mark - 随机数据
/**
 获取几张随机图片name
 */
+ (NSArray *)getPictureNameWithTotal:(NSInteger)total {
    
    NSMutableArray *arrName = [NSMutableArray new];
    for (NSInteger i = 0; i < total; i++) {
        // 不可重复
        srand((int)time(0));
        NSString *name = [NSString stringWithFormat:@"QQ%u",RANDNUM(16)];
        [arrName addObject:name];
    }
    return arrName;
}
/**
 获取几张随机图片
 */
+ (NSArray *)getPictureWithTotal:(NSInteger)total {
    NSMutableArray *arrPicture = [NSMutableArray new];
    NSArray *arrName = [ToolClass getPictureNameWithTotal:total];
    for (NSInteger i = 0; i < total; i++) {
        [arrPicture addObject:[UIImage imageNamed:arrName[i]]];
    }
    return arrPicture;
}

/**
 获取随机的标签(tags)
 */
+ (NSArray *)getRandTags {
    
    NSArray *tags1 = @[@"亲子",@"公益",@"亲子活动"];
    NSArray *tags2 = @[@"赛事",@"讲座",@"故事会"];
    NSArray *tags3 = @[@"国学",@"文化节",@"聚会",@"演出"];
    
    NSMutableArray *arrTags = [NSMutableArray new];
    
    NSUInteger count = (arc4random() % 3) + 1;
    int index1 = (arc4random() % tags1.count);
    int index2 = (arc4random() % tags2.count);
    int index3 = (arc4random() % tags3.count);
    
    switch (count) {
        case 1:
        {
            [arrTags addObject:tags1[index1]];
        }
            break;
        case 2:
        {
            [arrTags addObject:tags1[index1]];
            [arrTags addObject:tags2[index2]];
        }
            break;
        case 3:
        {
            [arrTags addObject:tags1[index1]];
            [arrTags addObject:tags2[index2]];
            [arrTags addObject:tags3[index3]];
        }
            break;
        default:
            break;
    }
    return arrTags;
}

+ (NSString *)getRandPhotoUrl {
    
    NSArray *arrHeadUrl = [NSMutableArray arrayWithObjects:@"http://i9.download.fd.pchome.net/g1/M00/12/1C/ooYBAFbpI0mICtMaAAOO40OgNKEAAC4CAPum6AAA477169.jpg",
                           @"http://i4.download.fd.pchome.net/g1/M00/0F/0D/ooYBAFU_PFyIGi8eAAPotewjNYoAACcOgI_fFgAA-jN703.jpg",
                           @"http://i5.download.fd.pchome.net/g1/M00/0C/1E/ooYBAFR-sMmIPII9AAQ44H7d-mkAACIYAFCbLMABDj4877.jpg",
                           @"http://i4.download.fd.pchome.net/g1/M00/0C/1E/oYYBAFR-sOeIF8DvAALddopx87EAACIYAGfCF0AAt2O799.jpg",
                           @"http://i2.download.fd.pchome.net/g1/M00/12/05/oYYBAFZX48CIZvN4AAdCTLqK6OEAACyRANW6YIAB0Jk130.jpg",
                           @"http://i9.download.fd.pchome.net/g1/M00/10/0F/ooYBAFWVBg2IPOHiAAQCRrcQQhQAACkqQNHyk4ABAJe933.jpg",
                           @"http://i6.download.fd.pchome.net/g1/M00/0E/01/oYYBAFTRvsWIWgGrAB0ClZt8mJgAACRUwCT534AHQKt428.jpg",
                           @"http://i2.download.fd.pchome.net/g1/M00/0D/1A/oYYBAFTAw-yIPJ7QABQEd17ze4kAACPnQEZdIYAFASP791.jpg",
                           @"http://i9.download.fd.pchome.net/g1/M00/0C/15/oYYBAFRuldCID7I_AAW9FwJLAHoAACGQQLxMdAABb0v093.jpg", nil];
    int indexHead = (arc4random() % arrHeadUrl.count);//生成随机下标
    return arrHeadUrl[indexHead];
}

+ (NSString *)getRandUsername {
    
    NSArray *arrUsername = @[@"Jasper",@"郭嘉",@"醒梦者",@"^_^",@"书香京城",@"国家图书馆",@"小东",@"游zhe戏人生",@"lala♪(^∇^*)啦啦",@"德玛西亚"];
    int indexUsername = (arc4random() % arrUsername.count);
    return arrUsername[indexUsername];
}

+ (NSString *)getRandComment {
    
    NSArray *arrComment = @[@"棒棒的！",@"就在家门口好近诶。。。",@"读万卷书，行千里路。",@"书中自有颜如玉，书中自有黄金屋。",@"读书使人充实，讨论使人机智，笔记使人准确，读史使人明智，读诗使人灵秀，数学使人周密，科学使人深刻，伦理使人庄重，逻辑修辞使人善辩。凡有所学，皆成性格。",@"读书时要深思多问。只读而不想，就可能人云亦云，沦为书本的奴隶；或者走马看花，所获甚微。",@"为乐趣而读书。",@"纸上得来终觉浅，绝知此事要躬行。",@"读活书，活读书，读书活。",@"从来没有人为了读书而读书，只有在书中读自己，在书中发现自己，或检查自己。",@"养心莫若寡欲；至乐无如读书。"];
    int indexComment = (arc4random() % arrComment.count);
    return arrComment[indexComment];
}

+ (NSString *)getRandActivityTitle {
    
    NSArray *arrTitle = @[@"海淀区传统文化社区诗歌赏析活动",@"昌平图书馆亲子讲座",@"第二届天桥艺术中心“诗意生活节”",@"艺术讲坛|中国画的传承与创新",@"梅洛伊cake布鲁斯口琴、吉他、卡祖笛",@"小宝贝启迪系列互动儿童剧《猜猜看》",@"沪剧折子戏"];
    int indexTitle = (arc4random() % arrTitle.count);
    return arrTitle[indexTitle];
}

+ (NSString *)getRandPlaceTitle {
    
    NSArray *arrTitle = @[@"北京图书馆",@"昌平图书馆",@"海淀少年文化宫",@"国家大剧院",@"北京博物馆",@"故宫"];
    int indexTitle = (arc4random() % arrTitle.count);
    return arrTitle[indexTitle];
}

+ (NSString *)getRandPlaceAddress {
    
    NSArray *arrTitle = @[@"中关村南大街33号",@"中关村互联网教育创新中心",@"中关村海淀新技术大厦"];
    int indexTitle = (arc4random() % arrTitle.count);
    return arrTitle[indexTitle];
}

@end
