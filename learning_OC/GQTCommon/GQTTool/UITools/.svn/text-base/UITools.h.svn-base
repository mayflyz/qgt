//
//  UITools.h
//  vik_learning_ios
//
//  Created by viktyz on 13-2-21.
//  Copyright (c) 2013年 neu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface UITools : NSObject

#pragma mark -
#pragma markImage Handler

/**
 按比例修改图像大小
 @param image 输入图像
 @param scaleSize 目标大小比例
 @returns 修改完成后图像
 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(CGFloat)scaleSize;


/**
 按比例修改图像宽度
 @param image 输入图像
 @param _rationWidth 宽度比例
 @returns 修改完成后图像
 */
+ (UIImage *)scaleImage:(UIImage *)image widthRatio:(CGFloat)_rationWidth;


/**
 按比例修改图像高度
 @param image 输入图像
 @param _ratioHeight 高度比例
 @returns 修改完成后图像
 */
+ (UIImage *)scaleImage:(UIImage *)image heightRatio:(CGFloat)_ratioHeight;


/**
 按比例修改图像大小
 @param image 输入图像
 @param _rationWidth 宽度比例
 @param _ratioHeight 高度比例
 @returns 修改完成后图像
 */
+ (UIImage *)scaleImage:(UIImage *)image widthRatio:(CGFloat)_rationWidth heightRatio:(CGFloat)_ratioHeight;

/**
 按目标大小修改图像大小
 @param image 输入图像
 @param sizeTarget 目标大小
 @returns 返回指定大小的图像
 */
+ (UIImage*)resizeImage:(UIImage*)image toSize:(CGSize)sizeTarget;

#pragma mark -
#pragma mark Button Handler
/**
 按照指定格式获取 button
 @param title 按钮标题
 @param font 按钮标题字体大小
 @param target 按钮所对应target
 @param selector 按钮点击方法
 @param frame 按钮大小
 @param image 按钮图片
 @param imagePressed 按钮点击图片
 @param darkTextColor 按钮标题字体颜色（默认 YES 对应黑色 NO 对应白色 可自行修改）
 @returns 按指定格式生成的按钮
 */
+ (UIButton *)newButtonWithTitle:(NSString *)title
					   titleFont:(UIFont*)font
						  target:(id)target
						selector:(SEL)selector
						   frame:(CGRect)frame
						   image:(UIImage *)image
					imagePressed:(UIImage *)imagePressed
				   darkTextColor:(BOOL)darkTextColor;

#pragma mark -
#pragma mark AlertView Handler
/**
 显示一个需要用户确认的弹出窗口
 @param message 消息内容
 @param delegate 响应代理的对象
 @param tag 弹出窗口tag
 */
+(void) showConfirm:(NSString*)message
           delegate:(id<UIAlertViewDelegate>)delegate
               with:(NSInteger)tag;

/**
 显示一个提示的弹出窗口
 @param message 消息内容
 @param delegate 响应代理的对象
 */
+(void) showAlert:(NSString*)message
         delegate:(id<UIAlertViewDelegate>)delegate;

/**
 显示一个提示的弹出窗口
 @param message 消息内容
 @param delegate 响应代理的对象
 @param tag 弹出窗口tag
 */
+(void) showAlert:(NSString*)message
         delegate:(id<UIAlertViewDelegate>)delegate
             with:(NSInteger)tag;

#pragma mark -
#pragma mark UIView
/**
 动画显示页面
 @param aView 需要动画的页面
 @param bAnimation YES-动画显示 NO-常规显示
 */
+ (void)displayView:(UIView*)aView
           animated:(BOOL)bAnimation;


/**
 动画隐藏页面
 @param aView 需要动画的页面
 @param bAnimation YES-动画显示 NO-常规显示
 */
+ (void)hideView:(UIView*)aView
		animated:(BOOL)bAnimation;


/**
 动画载入页面
 @param aView 需要动画载入的页面
 */
+ (void)animationToScaleUpView:(UIView *)aView;


/**
 获取aView上的图片
 @param aView 需要获取图片的页面
 @returns 返回页面上的图像
 */
+(UIImage *)imageFromView:(UIView *)aView;

@end
