#import "ActitoPushUIPlugin.h"
#if __has_include(<actito_push_ui/actito_push_ui-Swift.h>)
#import <actito_push_ui/actito_push_ui-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "actito_push_ui-Swift.h"
#endif

@implementation ActitoPushUIPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftActitoPushUIPlugin registerWithRegistrar:registrar];
}
@end
