//
//  SessionContainer.h
//  Week 11-2 (Multipeer Connectivity)
//
//  Created by 김기범 on 2016. 8. 24..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@protocol SessionContainerDelegate;

@interface SessionContainer : NSObject <MCSessionDelegate>
@property (readonly, nonatomic) MCSession *session;
@property (assign, nonatomic) id<SessionContainerDelegate> delegate;
- (id)initWithDisplayName:(NSString *)displayName serviceType:(NSString *)serviceType;
- (BOOL)sendAttack;
@end

@protocol SessionContainerDelegate <NSObject>
- (void)receivedAttack;
@end
