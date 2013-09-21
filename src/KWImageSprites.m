//
//  KWImageSprites.m
//  KWImageSprites
//
//  Created by Yusuke Kawasaki on 2013/09/17.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "KWImageSprites.h"

@implementation KWImageSprites

- (id)init {
    self = [super init];
    self.cache = [[NSMutableDictionary alloc] init];
    return self;
}

- (NSDictionary *)loadMapWithPath:(NSString *)name error:(NSError **)errorPtr {
    NSURL *resourceURL = [[NSBundle mainBundle] resourceURL];
    NSURL *url = [NSURL URLWithString:name relativeToURL:resourceURL];
    return [self loadMapWithURL:url error:errorPtr];
}

- (NSDictionary *)loadMapWithURL:(NSURL *)url error:(NSError **)errorPtr {
    NSError *err = nil;
    NSData *json = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&err];
    if (err) {
        *errorPtr = err;
        return nil;
    }

    self.map = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        *errorPtr = err;
        return nil;
    }
    return self.map;
}

- (UIImage *)loadImageWithPath:(NSString *)name error:(NSError **)errorPtr {
    NSURL *resourceURL = [[NSBundle mainBundle] resourceURL];
    NSURL *url = [NSURL URLWithString:name relativeToURL:resourceURL];
    return [self loadImageWithURL:url error:errorPtr];
}

- (UIImage *)loadImageWithURL:(NSURL *)url error:(NSError **)errorPtr {
    NSError *err = nil;
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&err];
    if (err) {
        *errorPtr = err;
        return nil;
    }

    self.image = [UIImage imageWithData:data];

    return self.image;
}

- (UIImage *)spriteForName:(NSString *)name {
    UIImage *cache = self.cache[name];
    if (cache) {
        return cache;
    }

    NSMutableArray *array = self.map[name];
    CGFloat x = ((NSNumber *) (array[0])).floatValue;
    CGFloat y = ((NSNumber *) (array[1])).floatValue;
    CGFloat w = ((NSNumber *) (array[2])).floatValue;
    CGFloat h = ((NSNumber *) (array[3])).floatValue;
    CGRect rect = CGRectMake(x, y, w, h);

    CGImageRef cgimage = CGImageCreateWithImageInRect(self.image.CGImage, rect);
    UIImage *sprite = [UIImage imageWithCGImage:cgimage];
    CGImageRelease(cgimage);

    self.cache[name] = sprite;
    return sprite;
}

@end
