//
//  Note.h
//  ExampleNotes
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * imageUrl;

@end
