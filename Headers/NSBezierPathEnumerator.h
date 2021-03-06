//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSFastEnumeration.h"

@class NSArray, NSBezierPath;

@interface NSBezierPathEnumerator : NSObject <NSFastEnumeration>
{
    BOOL _reverse;
    NSBezierPath *_bezierPath;
    NSArray *_pathItems;
}

@property(copy, nonatomic) NSArray *pathItems; // @synthesize pathItems=_pathItems;
@property(nonatomic) BOOL reverse; // @synthesize reverse=_reverse;
@property(retain, nonatomic) NSBezierPath *bezierPath; // @synthesize bezierPath=_bezierPath;
- (void).cxx_destruct;
- (id)objectAtIndex:(unsigned long long)arg1;
- (unsigned long long)countByEnumeratingWithState:(CDStruct_70511ce9 *)arg1 objects:(id *)arg2 count:(unsigned long long)arg3;

@end

