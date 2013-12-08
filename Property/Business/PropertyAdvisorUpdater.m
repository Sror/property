 
#import "PropertyAdvisorUpdater.h"


@implementation PropertyAdvisorUpdater

@synthesize viewController;


-(id) init
{
    if ((self = [super init]))
    {
        theProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(390.0f, 470.0f, 250.0f, 10.0f)];
        downloading = [[UILabel alloc] initWithFrame:CGRectMake(410, 400, 300, 100)];
        return self;
    }
    return NULL;
}

-(BOOL) checkForInitialUpdate:(SplashView *) caller
{
    CallerController = caller;
    [self performSelector:@selector(doUpdate) withObject:Nil afterDelay:1.0];
    return TRUE;
}

-(void) doUpdate
{
    [self getCurrentLocalVersion];
    [self checkForNewVersion];
}

-(void)getCurrentLocalVersion
{
    DbAccessor * dbaccessor= [[DbAccessor alloc]init];
    localVersion= dbaccessor.GetContentVersion;
}

-(void)checkForNewVersion
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverBaseUrl customHeaderFields:nil];
    
    
    MKNetworkOperation *op = [engine operationWithPath:serverCheckVersionUrl params:Nil httpMethod:@"GET" ssl:NO];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation)
     {
         NSString *lversion = completedOperation.readonlyResponse.allHeaderFields[@"LastPAVersion"];
         serverVersion      = [lversion intValue];
         [self GetServerUpdate];
     }
             onError:^(NSError *error)
     {
         [self requestFailed];
     }];
    
    [engine enqueueOperation: op];
}

-(BOOL) decompressFile:(NSString*)sourceFilePath :(NSString*)destinationPath
{
    @try
    {
        ZipArchive* za = [[ZipArchive alloc] init];
        if( [za UnzipOpenFile:sourceFilePath] )
        {
            BOOL ret = [za UnzipFileTo:destinationPath overWrite:YES];
            [za UnzipCloseFile];
            if( ret == NO )
            {
                return FALSE;
            }
        }
        return TRUE;
    }
    @catch (NSException *exception)
    {
        
        return FALSE;
    }
}

-(void) processDownload
{
    NSArray *paths                = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir        = [paths objectAtIndex:0];
    NSString *magazineContentPath = [documentsDir stringByAppendingPathComponent:@"PAMagazine"];
    
    [self decompressFile:destination:magazineContentPath];
        
    NSFileManager * fm =[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:destination])
    {
        [fm removeItemAtPath:destination error:nil];
    }
     
    [self performSelector:@selector(doUpdate) withObject:Nil afterDelay:1.0];
}

-(void)FinishRequest
{
    [CallerController FinishLoading];
}

- (void)requestFailed
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Error"];
    [alert setMessage:@"An error occurred while downloading file, please make sure your iPad is connected to the Internet click and try again."];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Try Again"];
    [alert setTag:1];
    [alert show];
}

-(void)GetServerUpdate
{
    if (serverVersion == 0 || localVersion == serverVersion)
    {
        [self FinishRequest];
        return;
    }
    int updateVersion = localVersion + 1;
  
    theProgressView.progress = 0;
    [theProgressView setProgressViewStyle: UIProgressViewStyleDefault];
    [self.viewController.view addSubview:theProgressView];
    
    [downloading setTextColor:[UIColor whiteColor]];
    [downloading setFont:[UIFont systemFontOfSize:12]];
    [downloading setText:[NSString stringWithFormat:@"Downloading Version %d , Please wait...",localVersion + 1]];
    [self.viewController.view addSubview:downloading];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *tempPath = [documentsDir stringByAppendingPathComponent:@"Temp"];
    
    BOOL isDir, success;
    if (![fileManager fileExistsAtPath: tempPath isDirectory:&isDir])
    {
        success =  [fileManager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    destination = [tempPath stringByAppendingPathComponent:@"pamagazine.zip"];
  
    NSString  *downloadLink = [NSString stringWithFormat:serverDownloadUpdateFileUrl, updateVersion];

    MKNetworkEngine* engine = [[MKNetworkEngine alloc] initWithHostName:serverBaseUrl customHeaderFields:nil];
    
    MKNetworkOperation* op  = [engine operationWithPath:downloadLink params:nil httpMethod:@"GET" ssl:NO];
    
     [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:destination append:YES]];
    
     [op onCompletion:^(MKNetworkOperation *completedOperation)
     {
         [self processDownload];
     }
     onError:^(NSError *error)
     {
        [self requestFailed];
     }];
    
     [op onDownloadProgressChanged:^(double progress)
     {
        theProgressView.progress = progress;
     }];
    
     [engine enqueueOperation: op];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        if (buttonIndex==0)
        {
            [self performSelector:@selector(doUpdate) withObject:Nil afterDelay:1.0];
            return;
        }
    } 
    
    if (buttonIndex == 0)
    {
        [self doUpdate];
        return;
    }
}

@end

