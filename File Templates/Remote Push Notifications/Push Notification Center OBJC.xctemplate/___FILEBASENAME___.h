//___FILEHEADER___

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Registers the application for receiving remote push notifications, processes the receipt of the device token and push notifications
@interface ___FILEBASENAMEASIDENTIFIER___ : NSObject

/// Registers the current application to receive push notifications
- (void)registerForRemoteNotification;

/// Handles remote notification
/// @param notification User info received in the application delegate (application:didReceiveRemoteNotification:)
- (void)handleRemoteNotification:(NSDictionary *)notification;

/// Handles device token
/// @param deviceToken Device token received in the application delegate (application:didRegisterForRemoteNotificationsWithDeviceToken:)
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

@end

NS_ASSUME_NONNULL_END
