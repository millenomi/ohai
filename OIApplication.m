//
//  OIApplication.m
//  Ohai
//
//  Created by ∞ on 09/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIApplication.h"

#import <Ecore.h>

static inline BOOL _OIHasEnvSetting(NSString* name) {
	NSAutoreleasePool* pool = [NSAutoreleasePool new];

	const char* utf8 = [name UTF8String];
	const char* var = getenv(utf8);
	BOOL has = (var && strcmp(var, "YES") == 0);
	
	fprintf(stderr, "Ohai: Setting is %d for %s.\n", has, utf8);
	
	[pool release];
	
	return has;
}

void OIInitializeProcess(int argc, const char* argv[]) {
//	char* allowTracing = getenv("OBJCEnableMsgTracing");
//	if (allowTracing && strcmp(allowTracing, "YES") == 0)
//		OBJCEnableMsgTracing();
	
	if (_OIHasEnvSetting(@"OBJCEnableMsgTracing"))
		OBJCEnableMsgTracing();
	
	if (_OIHasEnvSetting(OIResponderEventLog))
		fprintf(stderr, "Ohai: Responder event log enabled.\n");
	
	fprintf(stderr, "Ohai: Initializing the process for Cocoa.\n");
	NSInitializeProcess(argc, argv);
	
	fprintf(stderr, "Ohai: Initializing the process for Ecore.\n");
	ecore_init();
	ecore_app_args_set(argc, argv);
}

NSString* const OIApplicationWillTerminateNotification = @"OIApplicationWillTerminateNotification";


@interface OIApplication ()

- (void) scheduleEcoreEventLoopStep;
- (void) stepThroughEcoreEventLoop:(id) nothing;
- (void) terminateIfRequired;

@end



@implementation OIApplication

static id OIAppInstance = nil;

+ sharedApplication;
{
	if (!OIAppInstance) {
		OIAppInstance = [self new];
		NSLog(@"Created the application object: %@", OIAppInstance);
	}
	
	return OIAppInstance;
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		if (OIAppInstance) {
			[NSException raise:@"OIApplicationMustRemainSingletonException" format:@"Cannot create another instance of OIApplication while one exists already (new: %@, old: %@).", self, OIAppInstance];
			return nil;
		}
	}
	
	return self;
}

@synthesize delegate;

- (void) dealloc;
{
	[delegate release];
	[super dealloc];
}

static int OIRunLoopHandleEcoreExitEvent(void* myself, int eventType, void* event) {
	NSLog(@"%@, Received an Ecore exit event.", (id) myself);
	[(OIApplication*)myself terminateWhenPossible];
	return ECORE_CALLBACK_CANCEL;
}

- (void) runWithDelegateClass:(Class) c;
{
	self.delegate = [[c new] autorelease];
	[self run];
}

- (void) run;
{
	NSLog(@"%@: About to run...", self);
	[self.delegate applicationDidFinishLaunching:self];
	
	NSLog(@"%@: Setting up exit event handler...", self);
	ecore_event_handler_add(ECORE_EVENT_SIGNAL_EXIT, &OIRunLoopHandleEcoreExitEvent, self);
	
	[self scheduleEcoreEventLoopStep];
	
	NSLog(@"Preparing to run the run loop."); fflush(stderr); fflush(stdout);
	NSRunLoop* it = [NSRunLoop currentRunLoop];
	NSLog(@"The loop is: %@ -- running!", it); fflush(stderr); fflush(stdout);
	while([it runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
		;
}

- (void) terminate;
{
	[loopTasker invalidate];
	[loopTasker release]; loopTasker = nil;
	
	NSLog(@"%@: Terminating the app.", self);
	
	if ([self.delegate respondsToSelector:@selector(applicationWillTerminate:)])
		[self.delegate applicationWillTerminate:self];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:OIApplicationWillTerminateNotification object:self];
	ecore_shutdown();
	exit(0);
}

- (void) scheduleEcoreEventLoopStep;
{
	//[[NSRunLoop currentRunLoop] performSelector:@selector(stepThroughEcoreEventLoop:) target:self argument:nil order:0 modes:[NSArray arrayWithObject:NSDefaultRunLoopMode]];
	//[[NSRunLoop currentRunLoop] performSelector:@selector(terminateIfRequired:) target:self argument:nil order:1 modes:[NSArray arrayWithObject:NSDefaultRunLoopMode]];
	[self performSelector:@selector(stepThroughEcoreEventLoop:) withObject:nil afterDelay:0.001];
}

- (void) stepThroughEcoreEventLoop:(id) nothing;
{
	@try {
		ecore_main_loop_iterate();
	} @catch (id ex) {
		NSLog(@"An exception happened while running the Ecore run loop: %@", ex);
		abort();
	}
	
	[self terminateIfRequired];
	[self scheduleEcoreEventLoopStep];
}

- (void) terminateWhenPossible;
{
	shouldTerminate = YES;
}

- (void) terminateIfRequired;
{
	if (shouldTerminate)
		[self terminate];
}

@end
