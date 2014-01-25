//
//  MJMStyleSheet.m
//  FrienDare
//
//  Created by Maciej Lobodzinski on 25/01/14.
//
//

#import "MJMStyleSheet.h"

@interface MJMStyleSheet()

/**
 Main colors
 */
@property (nonatomic, readwrite, strong) UIColor *color0; // gray
@property (nonatomic, readwrite, strong) UIColor *color1; // green

- (void)_applyAppearanceProxies;

@end

@implementation MJMStyleSheet

- (id)init
{
    if (self = [super init]) {
        self.color0 = [UIColor colorWithWhite:190./255. alpha:1.];
        self.color1 = [UIColor colorWithRed:23./255.
                                      green:162./255.
                                       blue:81./255.
                                      alpha:1.];
        
        [self _applyAppearanceProxies];
    }
    return self;
}

#pragma mark - + MLStyleSheet

+ (MJMStyleSheet *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[[self class] alloc] init];
    });
    return _sharedObject;
}

- (void)_applyAppearanceProxies
{
//    [UISlider appearance] set
}

#pragma mark Colors

- (UIColor *)backgroundColor
{
    return self.color0;
}

- (UIColor *)proveButtonBackgroundColor
{
    return self.color1;
}

#pragma mark Fonts colors

- (UIColor *)textColor
{
    return self.color0;
}

#pragma mark Fonts

- (UIFont *)font
{
    return [UIFont fontWithName:@"Futura-CondensedMedium" size:18];
}

- (UIFont *)boldFont
{
    return [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
}


@end