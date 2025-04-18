#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <unistd.h>

NSString* getWallpaperFromConfig(NSString *configPath) {
    NSData *data = [NSData dataWithContentsOfFile:configPath];
    if (!data) return nil;

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error || ![json isKindOfClass:[NSDictionary class]]) return nil;

    NSString *wallpaperPath = json[@"wallpaper"];
    if (![wallpaperPath isKindOfClass:[NSString class]]) return nil;

    return [wallpaperPath stringByExpandingTildeInPath];
}

int main() {
    @autoreleasepool {
        NSString *configPath = [@"~/.config/wallpaper/config.json" stringByExpandingTildeInPath];
        NSWorkspace *workspace = [NSWorkspace sharedWorkspace];

        while (1) {
            NSString *imagePath = getWallpaperFromConfig(configPath);
            if (imagePath) {
                NSURL *imageURL = [NSURL fileURLWithPath:imagePath];
                for (NSScreen *screen in [NSScreen screens]) {
                    [workspace setDesktopImageURL:imageURL forScreen:screen options:@{} error:nil];
                }
            }

            usleep(100000); // 0.1 second delay
        }
    }

    return 0;
}
