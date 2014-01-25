//
//  MJMStyleSheet.h
//  FrienDare
//
//  Created by Maciej Lobodzinski on 25/01/14.
//
//

#import <Foundation/Foundation.h>

@interface MJMStyleSheet : NSObject

+ (MJMStyleSheet *)sharedInstance;

/**
 UI Colors
 */
- (UIColor *)backgroundColor;
- (UIColor *)proveButtonBackgroundColor;

/**
 Fonts colors
 */
- (UIColor *)textColor;

/**
 Fonts
 */

- (UIFont *)font;
- (UIFont *)boldFont;

@end
