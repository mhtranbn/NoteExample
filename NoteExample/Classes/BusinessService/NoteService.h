//
//  NoteService.h
//  NoteExample
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteModel.h"

@protocol NoteServiceDelegate;

@interface NoteService : NSObject

@property (nonatomic, weak) id<NoteServiceDelegate> delegate;

- (void)loadAllNoteFromCoreData;

- (void)addNoteWithModel:(NoteModel *)noteModel;

@end

@protocol NoteServiceDelegate <NSObject>

@optional
- (void)serviceBeginSaveNote:(NoteService *)service;
- (void)serviceDidCompleteSaveNote:(NoteService *)service;

- (void)serviceBeginGetNote:(NoteService *)service;
- (void)serviceDidCompleteGetNote:(NoteService *)service
                       withModels:(NSArray *)models;

@end
