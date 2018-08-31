//
//  BackgroundSessionManager.h
//  RestAPI Sample
//
//  Created by Sebastin on 03/03/17.
//  Copyright © 2017 Cognizant. All rights reserved.
//

#import "AFNetworking.h"

@interface BackgroundSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@property (nonatomic, copy) void (^savedCompletionHandler)(void);

@end

