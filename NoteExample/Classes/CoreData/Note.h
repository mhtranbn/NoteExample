//
//  Note.h
//  NoteExample
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * content;

@end
