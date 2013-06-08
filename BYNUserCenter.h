//
//  BYNUserCenter.h
//  wanxiangerweima
//
//  Created by usr on 13-4-15.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BYNUserCenter : NSObject 
{
	
	NSString   *_newsID;
	NSString   *_title;
	NSString   *_contents;
	
}

@property (nonatomic,copy) NSString   *newsID;
@property (nonatomic,copy) NSString   *title;
@property (nonatomic,copy) NSString   *contents;

-(id)initWithDictionary:(NSDictionary *)aboutUsDictionary;
+ (id)aboutUsWithDictionary:(NSDictionary *)aboutUsDictionary;

@end
