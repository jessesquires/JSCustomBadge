//
//  JSCustomBadge.m
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

#import "JSCustomBadge.h"

static CGFloat const IC_DEFAULTCONTENTSIZE = 25.0f;
static CGFloat const IC_DEFAULTCORNERROUNDNESS = 0.4f;
static CGFloat const IC_DEFAULTSCALEFACTOR = 1.0f;
static CGFloat const IC_QUARTERFACTOR = 0.25f;

@interface JSCustomBadge ()

/**
 *  Represents the view's size internally. Once set, intrinsic content size is invalidated and Autolayout will ask our view's for its intrinsic content size.
 */
@property (assign, nonatomic) CGSize contentSize;

@end

@implementation JSCustomBadge

#pragma mark - Initialization

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(badgeText))];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize))];
}

- (void)awakeFromNib
{
    self.contentSize = CGSizeMake(IC_DEFAULTCONTENTSIZE, IC_DEFAULTCONTENTSIZE);
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(badgeText)) options:0 context:nil];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) options:0 context:nil];
    self.contentScaleFactor = [[UIScreen mainScreen] scale];
    self.backgroundColor = [UIColor clearColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeFrame = NO;
    self.badgeFrameColor = nil;
    self.badgeInsetColor =  [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f]; // iOS 7 red
    self.badgeCornerRoundness = IC_DEFAULTCORNERROUNDNESS;
    self.badgeScaleFactor = IC_DEFAULTSCALEFACTOR;
    self.badgeShining = NO;
    self.badgeShadow = NO;
    self.badgeText = @"";
}

- (instancetype)initWithString:(NSString *)badgeString withScale:(CGFloat)scale withShining:(BOOL)shining
{
	self = [super initWithFrame:CGRectMake(0.0f, 0.0f, IC_DEFAULTCONTENTSIZE, IC_DEFAULTCONTENTSIZE)];
    
	if (self)
    {
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(badgeText)) options:0 context:nil];
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) options:0 context:nil];
		self.contentScaleFactor = [[UIScreen mainScreen] scale];
		self.backgroundColor = [UIColor clearColor];
		self.badgeTextColor = [UIColor whiteColor];
		self.badgeFrame = NO;
		self.badgeFrameColor = nil;
		self.badgeInsetColor =  [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f]; // iOS 7 red
		self.badgeCornerRoundness = IC_DEFAULTCORNERROUNDNESS;
		self.badgeScaleFactor = scale;
		self.badgeShining = shining;
        self.badgeShadow = NO;
        self.badgeText = badgeString;
	}
    
	return self;
}

- (instancetype)initWithString:(NSString *)badgeString
               withStringColor:(UIColor *)stringColor
                withInsetColor:(UIColor *)insetColor
                withBadgeFrame:(BOOL)badgeFrameYesNo
           withBadgeFrameColor:(UIColor *)frameColor
                     withScale:(CGFloat)scale
                   withShining:(BOOL)shining
                    withShadow:(BOOL)shadow
{
	self = [super initWithFrame:CGRectMake(0.0f, 0.0f, IC_DEFAULTCONTENTSIZE, IC_DEFAULTCONTENTSIZE)];
    
	if (self)
    {
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(badgeText)) options:0 context:nil];
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) options:0 context:nil];
		self.contentScaleFactor = [[UIScreen mainScreen] scale];
		self.backgroundColor = [UIColor clearColor];
		self.badgeTextColor = stringColor;
		self.badgeFrame = badgeFrameYesNo;
		self.badgeFrameColor = frameColor;
		self.badgeInsetColor = insetColor;
		self.badgeCornerRoundness = IC_DEFAULTCORNERROUNDNESS;
		self.badgeScaleFactor = scale;
		self.badgeShining = shining;
        self.badgeShadow = shadow;
        self.badgeText = badgeString;
	}
    
	return self;
}

#pragma mark - Class initializers

+ (JSCustomBadge *)customBadgeWithString:(NSString *)badgeString
{
	return [[JSCustomBadge alloc] initWithString:badgeString withScale:1.0f withShining:NO];
}

+ (JSCustomBadge *)customBadgeWithString:(NSString *)badgeString
                         withStringColor:(UIColor *)stringColor
                          withInsetColor:(UIColor *)insetColor
                          withBadgeFrame:(BOOL)badgeFrameYesNo
                     withBadgeFrameColor:(UIColor *)frameColor
                               withScale:(CGFloat)scale
                             withShining:(BOOL)shining
                              withShadow:(BOOL)shadow
{
	return [[JSCustomBadge alloc] initWithString:badgeString
                                 withStringColor:stringColor
                                  withInsetColor:insetColor
                                  withBadgeFrame:badgeFrameYesNo
                             withBadgeFrameColor:frameColor
                                       withScale:scale
                                     withShining:shining
                                      withShadow:shadow];
}

#pragma mark - Autolayout Support

- (CGSize)intrinsicContentSize
{
    return self.contentSize;
}

- (void)updateContentSize:(CGSize)contentSize
{
    // Sets our internal content size property and once set our internal listener will receive notification and tell invalidate the intrinsic content size.
    self.contentSize = contentSize;
    
    // Set our frame for non-Autolayout support. If we are on Autolayout, the system will over ride our set and so this setthing of the frame should be harmless.
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, contentSize.width, contentSize.height);
}

#pragma mark - Observation

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:NSStringFromSelector(@selector(contentSize))])
    {
        // Tell Autolayout that our current intrinsic content size is no longer valid.
        [self invalidateIntrinsicContentSize];
    }
    else if (object == self && [keyPath isEqualToString:NSStringFromSelector(@selector(badgeText))])
    {
        [self autoBadgeSizeWithString:self.badgeText];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Utilities

- (void)autoBadgeSizeWithString:(NSString *)badgeString
{
	CGSize retValue;
	CGFloat rectWidth, rectHeight;
	CGSize stringSize = [badgeString sizeWithAttributes:@{ NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0f] }];
	CGFloat flexSpace;
	
    if ([badgeString length] >= 2.0f) {
		flexSpace = [badgeString length];
		rectWidth = IC_DEFAULTCONTENTSIZE + (stringSize.width + flexSpace); rectHeight = IC_DEFAULTCONTENTSIZE;
		retValue = CGSizeMake(rectWidth * self.badgeScaleFactor, rectHeight * self.badgeScaleFactor);
	}
    else {
		retValue = CGSizeMake(IC_DEFAULTCONTENTSIZE * self.badgeScaleFactor, IC_DEFAULTCONTENTSIZE * self.badgeScaleFactor);
	}
	
    _badgeText = badgeString;
    [self updateContentSize:retValue];
    [self setNeedsDisplay];
}

#pragma mark - Drawing Methods

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	[self drawRoundedRectWithContext:context inRect:self.bounds];
	
	if (self.badgeShining) {
		[self drawShineWithContext:context inRect:self.bounds];
    }
	
	if (self.badgeFrame) {
		[self drawFrameWithContext:context inRect:self.bounds];
    }
	
	if ([self.badgeText length] > 0.0f) {
        
		[self.badgeTextColor set];
		CGFloat sizeOfFont = 13.5f * self.badgeScaleFactor;
		
        if ([self.badgeText length] < 2.0f) {
			sizeOfFont += sizeOfFont * 0.2f;
		}
        
		UIFont *textFont = [UIFont boldSystemFontOfSize:sizeOfFont];
        NSDictionary *textAttributes = @{ NSFontAttributeName : textFont, NSForegroundColorAttributeName : self.badgeTextColor };
		CGSize textSize = [self.badgeText sizeWithAttributes:textAttributes];
		
        NSStringDrawingContext *drawingContext = [[NSStringDrawingContext alloc] init];
        drawingContext.minimumScaleFactor = 0.5;
        
        [self.badgeText drawWithRect:CGRectMake(self.bounds.size.width / 2.0f - textSize.width / 2.0f,
                                                self.bounds.size.height / 2.0f - textSize.height / 2.0f,
                                                self.bounds.size.width,
                                                self.bounds.size.height)
                             options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:textAttributes
                             context:drawingContext];
	}
}

- (void)drawRoundedRectWithContext:(CGContextRef)context inRect:(CGRect)rect
{
	CGContextSaveGState(context);
	
	CGFloat radius = CGRectGetMaxY(rect) * self.badgeCornerRoundness;
	CGFloat puffer = CGRectGetMaxY(rect) * 0.1f;
	CGFloat maxX = CGRectGetMaxX(rect) - puffer;
	CGFloat maxY = CGRectGetMaxY(rect) - puffer;
	CGFloat minX = CGRectGetMinX(rect) + puffer;
	CGFloat minY = CGRectGetMinY(rect) + puffer;
    
    CGContextBeginPath(context);
	CGContextSetFillColorWithColor(context, [self.badgeInsetColor CGColor]);
	CGContextAddArc(context, maxX-radius, minY+radius, radius, M_PI+(M_PI/2.0f), 0.0f, 0.0f);
	CGContextAddArc(context, maxX-radius, maxY-radius, radius, 0.0f, M_PI/2.0f, 0.0f);
	CGContextAddArc(context, minX+radius, maxY-radius, radius, M_PI/2.0f, M_PI, 0.0f);
	CGContextAddArc(context, minX+radius, minY+radius, radius, M_PI, M_PI+M_PI/2.0f, 0.0f);
    
    if (self.badgeShadow) {
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(0.0f, 1.0f),
                                    2.0f,
                                    [UIColor colorWithWhite:0.0f alpha:0.75f].CGColor);
    }
    
    CGContextFillPath(context);
    
	CGContextRestoreGState(context);
}

- (void)drawShineWithContext:(CGContextRef)context inRect:(CGRect)rect
{
	CGContextSaveGState(context);
    
	CGFloat radius = CGRectGetMaxY(rect) * self.badgeCornerRoundness;
	CGFloat puffer = CGRectGetMaxY(rect) * 0.1f;
	CGFloat maxX = CGRectGetMaxX(rect) - puffer;
	CGFloat maxY = CGRectGetMaxY(rect) - puffer;
	CGFloat minX = CGRectGetMinX(rect) + puffer;
	CGFloat minY = CGRectGetMinY(rect) + puffer;
    
	CGContextBeginPath(context);
	CGContextAddArc(context, maxX-radius, minY+radius, radius, M_PI+(M_PI/2.0f), 0.0f, 0.0f);
	CGContextAddArc(context, maxX-radius, maxY-radius, radius, 0.0f, M_PI/2.0f, 0.0f);
	CGContextAddArc(context, minX+radius, maxY-radius, radius, M_PI/2.0f, M_PI, 0.0f);
	CGContextAddArc(context, minX+radius, minY+radius, radius, M_PI, M_PI+M_PI/2.0f, 0.0f);
	CGContextClip(context);
	
	size_t num_locations = 2.0f;
	CGFloat locations[2] = { 0.0f, 0.4f };
	CGFloat components[8] = { 0.92f, 0.92f, 0.92f, 1.0f, 0.82f, 0.82f, 0.82f, 0.4f };
    
	CGColorSpaceRef cspace;
	CGGradientRef gradient;
	cspace = CGColorSpaceCreateDeviceRGB();
	gradient = CGGradientCreateWithColorComponents(cspace, components, locations, num_locations);
	
	CGPoint sPoint, ePoint;
	sPoint.x = 0.0f;
	sPoint.y = 0.0f;
	ePoint.x = 0.0f;
	ePoint.y = maxY;
	CGContextDrawLinearGradient(context, gradient, sPoint, ePoint, 0.0f);
	
	CGColorSpaceRelease(cspace);
	CGGradientRelease(gradient);
	
	CGContextRestoreGState(context);
}

- (void)drawFrameWithContext:(CGContextRef)context inRect:(CGRect)rect
{
	CGFloat radius = CGRectGetMaxY(rect) * self.badgeCornerRoundness;
	CGFloat puffer = CGRectGetMaxY(rect) * 0.1f;
	
	CGFloat maxX = CGRectGetMaxX(rect) - puffer;
	CGFloat maxY = CGRectGetMaxY(rect) - puffer;
	CGFloat minX = CGRectGetMinX(rect) + puffer;
	CGFloat minY = CGRectGetMinY(rect) + puffer;
	
    CGContextBeginPath(context);
	CGFloat lineSize = 2.0f;
    
	if (self.badgeScaleFactor > IC_DEFAULTSCALEFACTOR) {
		lineSize += self.badgeScaleFactor * IC_QUARTERFACTOR;
	}
    
	CGContextSetLineWidth(context, lineSize);
	CGContextSetStrokeColorWithColor(context, [self.badgeFrameColor CGColor]);
	CGContextAddArc(context, maxX-radius, minY+radius, radius, M_PI + (M_PI/2.0f), 0.0f, 0.0f);
	CGContextAddArc(context, maxX-radius, maxY-radius, radius, 0.0f, M_PI/2.0f, 0.0f);
	CGContextAddArc(context, minX+radius, maxY-radius, radius, M_PI/2.0f, M_PI, 0.0f);
	CGContextAddArc(context, minX+radius, minY+radius, radius, M_PI, M_PI+M_PI/2.0f, 0.0f);
	
    CGContextClosePath(context);
	CGContextStrokePath(context);
}

@end