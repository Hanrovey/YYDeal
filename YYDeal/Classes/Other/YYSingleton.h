
// .h 文件
#define YYSingletonH(name) + (instancetype)shared##name;

// .m 文件
#define YYSingletonM(name) \
static id _instance = nil;\
+ (instancetype)sharedAPITool\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [[self alloc] init];\
    });\
    return _instance;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
    return _instance;\
}