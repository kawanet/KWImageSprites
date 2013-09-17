//
//  KWImageSprites.h
//  KWImageSprites
//
//  Created by Yusuke Kawasaki on 2013/09/17.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWImageSprites : NSObject

@property NSDictionary *map;
@property UIImage *image;
@property NSMutableDictionary *cache;

- (NSDictionary *)loadMapWithPath:(NSString *)name error:(NSError **)errorPtr;
- (NSDictionary *)loadMapWithURL:(NSURL *)url error:(NSError **)errorPtr;
- (UIImage *)loadImageWithPath:(NSString *)name error:(NSError **)errorPtr;
- (UIImage *)loadImageWithURL:(NSURL *)url error:(NSError **)errorPtr;
- (UIImage *)spriteForName:(NSString *)name;

@end
