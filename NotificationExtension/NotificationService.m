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
    NSString *dateStr = self.bestAttemptContent.userInfo[@"aps"][@"date"];
    
    
    
    
    // Modify the notification content here...
    self.bestAttemptContent.title = @"Warning";
    self.bestAttemptContent.body = dateStr;// @"Danger ahead";
    self.bestAttemptContent.sound = [UNNotificationSound soundNamed:@"coindrop.wav"] ;
    self.contentHandler(self.bestAttemptContent);
    
   
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
