//
//  JSCustomBadge.h
//
//  
//  Original work by Sascha Marc Paulus
//  Copyright (c) 2011
//  https://github.com/ckteebe/CustomBadge
//  http://www.spaulus.com
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//
//  http://www.hexedbits.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@interface JSCustomBadge : UIView

/**
 *  The content that the badge should display. Any time this property is set, an internal call will be made to render the new value.
 *  One can also just call updateBadgeContentWithString method if they would rather use bracket syntax rather than dot syntax.
 */
@property (strong, nonatomic) NSString *badgeText;

/**
 *  Indicates what the badge text color should be, by default it is white.
 */
@property (strong, nonatomic) UIColor *badgeTextColor;

/**
 *  Indicates what the fill color of the badge should be, by default the color is iOS 7 red.
 */
@property (strong, nonatomic) UIColor *badgeInsetColor;

/**
 *  Indicates what the fill color of the border of the badge should be.
 */
@property (strong, nonatomic) UIColor *badgeFrameColor;

/**
 *  Indicates if the badge should have a border around itself.
 */
@property (assign, nonatomic) BOOL badgeFrame;

/**
 *  Indicates if a shine should be on the badge.
 */
@property (assign, nonatomic) BOOL badgeShining;

/**
 *  Indicates if a shadow should be on the badge.
 */
@property (assign, nonatomic) BOOL badgeShadow;

/**
 *  The sharpness of our corners. Default is set at 0.4f
 */
@property (assign, nonatomic) CGFloat badgeCornerRoundness;

/**
 *  The scale factor that should be used. By default the factor is 1. The default size is set at 25 points.
 */
@property (assign, nonatomic) CGFloat badgeScaleFactor;

/**
 *  Intializies a badge with a specific string.
 *
 *  @param badgeString The specific string to set the badge text value to initially.
 *
 *  @return A valid JSCustomBadge instance.
 */
+ (JSCustomBadge *)customBadgeWithString:(NSString *)badgeString;

/**
 *  Intializies a customized badge.
 *
 *  @param badgeString     The specific string to set the badge text value to initially.
 *  @param stringColor     The color the text should be.
 *  @param insetColor      The fill color for the badge
 *  @param badgeFrameYesNo A frame wrapped, border, around the badge.
 *  @param frameColor      The color the border of the badge should be.
 *  @param scale           A scale factor that is a multiple of the default content size of 25.0f points.
 *  @param shining         Adds a shine to the badge.
 *  @param shadow          Adds a shadow to the badge.
 *
 *  @return A valid JSCustomBadge instance.
 */
+ (JSCustomBadge *)customBadgeWithString:(NSString *)badgeString
                         withStringColor:(UIColor*)stringColor
                          withInsetColor:(UIColor*)insetColor
                          withBadgeFrame:(BOOL)badgeFrameYesNo
                     withBadgeFrameColor:(UIColor*)frameColor
                               withScale:(CGFloat)scale
                             withShining:(BOOL)shining
                              withShadow:(BOOL)shadow;

/**
 *  Use to change the badge text after the first rendering
 *
 *  @param badgeString The string to display in the badge.
 */
- (void)autoBadgeSizeWithString:(NSString *)badgeString;

@end
