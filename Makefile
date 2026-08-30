# MinisQQ — QQ悬浮球（标准 substrate，兼容 TrollFools 注入）
# ⚠️ 2026-08-30 关键修复：去掉 roothide 链接(-lroothide / .jbroot 路径)，
#    改为标准 @rpath/CydiaSubstrate.framework/CydiaSubstrate。
#    原因：roothide 编译的 dylib 链接 @loader_path/.jbroot/usr/lib/libroothide.dylib，
#     TrollFools 注入到 QQ 后该路径解析不了 → dyld 加载失败 → 闪退。
#    标准 substrate 依赖能被 QQ 进程解析，可正常注入使用。
export ARCHS = arm64 arm64e
export TARGET = iphone:clang:16.5:15.0

INSTALL_TARGET_PROCESSES = QQ

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = minisqq

minisqq_FILES = Tweak.xm
minisqq_CFLAGS = -fobjc-arc -Wno-unused-variable -Wno-deprecated-declarations -Wno-arc-retain-cycles -nostdinc++ -isystem "$(THEOS_SDK_PATH)/usr/include/c++/v1"
# 标准 substrate 链接：@rpath/CydiaSubstrate.framework/CydiaSubstrate（与 QQNotiAvatar 等可用插件一致）
minisqq_LDFLAGS = -L"$(THEOS_SDK_PATH)/usr/lib" -F"$(THEOS_VENDOR_LIBRARY_PATH)/iphone" -framework CydiaSubstrate

include $(THEOS_MAKE_PATH)/tweak.mk
