#import "ActitoAssetsPlugin.h"
#if __has_include(<actito_assets/actito_assets-Swift.h>)
#import <actito_assets/actito_assets-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "actito_assets-Swift.h"
#endif

@implementation ActitoAssetsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftActitoAssetsPlugin registerWithRegistrar:registrar];
}
@end
