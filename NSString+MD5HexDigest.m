//
//  NSString+MD5HexDigest.m
//  ShareNew
//
//  Created by WHZ12037 on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+MD5HexDigest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5HexDigest)

- (NSString*)md5EncodeString
{
    const char* str = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(str, strlen(str), result);
	
	return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
			];
}

@end
