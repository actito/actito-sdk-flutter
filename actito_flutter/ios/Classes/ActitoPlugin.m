#import "ActitoPlugin.h"
#if __has_include(<actito_flutter/actito_flutter-Swift.h>)
#import <actito_flutter/actito_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "actito_flutter-Swift.h"
#endif

@implementation ActitoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftActitoPlugin registerWithRegistrar:registrar];
}
@end
