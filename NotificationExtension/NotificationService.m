//
//  NotificationService.m
//  NotificationExtension
//
//  Created by Anshuman Dahale on 17/01/19.
//  Copyright © 2019 Anshuman Dahale. All rights reserved.
//

#import "NotificationService.h"
#import <AVFoundation/AVFoundation.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Get the User Info Dictionary.
    NSMutableDictionary* userInfo = [self.bestAttemptContent.userInfo mutableCopy];
    NSMutableDictionary* aps = [[userInfo objectForKey:@"aps"] mutableCopy];
    [aps setObject:@"coindrop.caf" forKey:@"sound"];
   // [aps setObject:@"" forKey:@"sound"];
    [userInfo setObject:aps forKey:@"aps"];
  //  self.bestAttemptContent.userInfo = userInfo;
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"Title Set by Extension"];
    self.bestAttemptContent.sound = [UNNotificationSound soundNamed:@"coindrop.caf"] ;
    self.contentHandler(self.bestAttemptContent);
    
   
   
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
