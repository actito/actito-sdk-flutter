#import "ActitoScannablesPlugin.h"
#if __has_include(<actito_scannables/actito_scannables-Swift.h>)
#import <actito_scannables/actito_scannables-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "actito_scannables-Swift.h"
#endif

@implementation ActitoScannablesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftActitoScannablesPlugin registerWithRegistrar:registrar];
}
@end
