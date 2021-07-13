#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ios_image_load.h"
#import "TflitePlugin.h"

FOUNDATION_EXPORT double tfliteVersionNumber;
FOUNDATION_EXPORT const unsigned char tfliteVersionString[];

