//
//  CognitoAdapter.m
//  Wassail-Client-iOS
//
//  Created by Chuan Ren on 10/8/14.
//  Copyright (c) 2014 Haile. All rights reserved.
//

#import "CognitoAdapter.h"

@implementation CognitoAdapter

- (void)docognito {
    
    _credentialsProvider = [AWSCognitoCredentialsProvider
                            credentialsWithRegionType:AWSRegionUSEast1
                            accountId:@"904179507614"
                            identityPoolId:@"us-east-1:1994fb86-c0d9-4b08-b93e-4fe9f68fde63"
                            unauthRoleArn:@"arn:aws:iam::904179507614:role/Cognito_WassailUnauth_DefaultRole"
                            authRoleArn:@"arn:aws:iam::904179507614:role/Cognito_WassailAuth_DefaultRole"];
    
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSEast1 credentialsProvider:_credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    printf("%s", _credentialsProvider.identityId);
}

@end
