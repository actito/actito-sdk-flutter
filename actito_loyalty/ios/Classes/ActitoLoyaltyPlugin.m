#import "ActitoLoyaltyPlugin.h"
#if __has_include(<actito_loyalty/actito_loyalty-Swift.h>)
#import <actito_loyalty/actito_loyalty-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "actito_loyalty-Swift.h"
#endif

@implementation ActitoLoyaltyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftActitoLoyaltyPlugin registerWithRegistrar:registrar];
}
@end
