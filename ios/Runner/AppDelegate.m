// #include "AppDelegate.h"
// #include "GeneratedPluginRegistrant.h"
// @import Firebase;

// @import UserNotifications;

// // Implement UNUserNotificationCenterDelegate to receive display notification via APNS for devices
// // running iOS 10 and above.
// @interface AppDelegate () <UNUserNotificationCenterDelegate>
// @end

// @implementation AppDelegate

// NSString *const kGCMMessageIDKey = @"gcm.message_id";

// - (BOOL)application:(UIApplication *)application
// didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//     // [START configure_firebase]
//     [FIRApp configure];
//     // [END configure_firebase]
    
//     // [START set_messaging_delegate]
//     [FIRMessaging messaging].delegate = self;
//     // [END set_messaging_delegate]
    
//     // Register for remote notifications. This shows a permission dialog on first run, to
//     // show the dialog at a more appropriate time move this registration accordingly.
//     // [START register_for_notifications]
//     if ([UNUserNotificationCenter class] != nil) {
//         // iOS 10 or later
//         // For iOS 10 display notification (sent via APNS)
//         [UNUserNotificationCenter currentNotificationCenter].delegate = self;
//         UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
//         UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
//         [[UNUserNotificationCenter currentNotificationCenter]
//          requestAuthorizationWithOptions:authOptions
//          completionHandler:^(BOOL granted, NSError * _Nullable error) {
//              // ...
//          }];
//     } else {
//         // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
//         UIUserNotificationType allNotificationTypes =
//         (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
//         UIUserNotificationSettings *settings =
//         [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
//         [application registerUserNotificationSettings:settings];
//     }
    
//     [application registerForRemoteNotifications];
//     // [END register_for_notifications]
    
//     return YES;
// }

// // [START receive_message]
// - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//     // If you are receiving a notification message while your app is in the background,
//     // this callback will not be fired till the user taps on the notification launching the application.
//     // TODO: Handle data of notification
    
//     // With swizzling disabled you must let Messaging know about the message, for Analytics
//     // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
//     // Print message ID.
//     if (userInfo[kGCMMessageIDKey]) {
//         NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//     }
    
//     // Print full message.
//     NSLog(@"%@", userInfo);
// }

// - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
// fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//     // If you are receiving a notification message while your app is in the background,
//     // this callback will not be fired till the user taps on the notification launching the application.
//     // TODO: Handle data of notification
    
//     // With swizzling disabled you must let Messaging know about the message, for Analytics
//     // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
//     // Print message ID.
//     if (userInfo[kGCMMessageIDKey]) {
//         NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//     }
    
//     // Print full message.
//     NSLog(@"%@", userInfo);
    
//     completionHandler(UIBackgroundFetchResultNewData);
// }
// // [END receive_message]

// // [START ios_10_message_handling]
// // Receive displayed notifications for iOS 10 devices.
// // Handle incoming notification messages while app is in the foreground.
// - (void)userNotificationCenter:(UNUserNotificationCenter *)center
//        willPresentNotification:(UNNotification *)notification
//          withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
//     NSDictionary *userInfo = notification.request.content.userInfo;
    
//     // With swizzling disabled you must let Messaging know about the message, for Analytics
//     // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
//     // Print message ID.
//     if (userInfo[kGCMMessageIDKey]) {
//         NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//     }
    
//     // Print full message.
//     NSLog(@"%@", userInfo);
    
//     // Change this to your preferred presentation option
//     completionHandler(UNNotificationPresentationOptionNone);
// }

// // Handle notification messages after display notification is tapped by the user.
// - (void)userNotificationCenter:(UNUserNotificationCenter *)center
// didReceiveNotificationResponse:(UNNotificationResponse *)response
//          withCompletionHandler:(void(^)(void))completionHandler {
//     NSDictionary *userInfo = response.notification.request.content.userInfo;
//     if (userInfo[kGCMMessageIDKey]) {
//         NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//     }
    
//     // Print full message.
//     NSLog(@"%@", userInfo);
    
//     completionHandler();
// }

// // [END ios_10_message_handling]

// // [START refresh_token]
// - (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
//     NSLog(@"FCM registration token: %@", fcmToken);
//     // Notify about received token.
//     NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
//     [[NSNotificationCenter defaultCenter] postNotificationName:
//      @"FCMToken" object:nil userInfo:dataDict];
//     // TODO: If necessary send token to application server.
//     // Note: This callback is fired at each app startup and whenever a new token is generated.
// }
// // [END refresh_token]

// // [START ios_10_data_message]
// // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
// // To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
// - (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
//     NSLog(@"Received data message: %@", remoteMessage.appData);
// }
// // [END ios_10_data_message]

// - (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//     NSLog(@"Unable to register for remote notifications: %@", error);
// }

// // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// // If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// // the FCM registration token.
// - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//     NSLog(@"APNs device token retrieved: %@", deviceToken);
    
//     // With swizzling disabled you must set the APNs device token here.
//     // [FIRMessaging messaging].APNSToken = deviceToken;
// }
// @end
#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end

