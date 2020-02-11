//___FILEHEADER___

#import "___FILEBASENAME___.h"
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface ___FILEBASENAMEASIDENTIFIER___ () <UNUserNotificationCenterDelegate>

@property (nonatomic, strong) UNUserNotificationCenter *notificationCenter;

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

- (instancetype)init {
    self = [super init];
    if (self) {
        _notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        _notificationCenter.delegate = self;
    }
    return self;
}

- (void)registerForRemoteNotification {
    UNAuthorizationOptions authOptions = UNAuthorizationOptionBadge + UNAuthorizationOptionSound + UNAuthorizationOptionAlert;
    
    __weak typeof(self) weakSelf = self;
    
    [self.notificationCenter requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            [weakSelf.notificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                    });
                }
            }];
        }
    }];
}

- (void)handleRemoteNotification:(NSDictionary *)notification {
    
}

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

}

#pragma mark - UNUserNotificationCenterDelegate -

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
}

@end
