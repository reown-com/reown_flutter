# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.sun.jna.Callback
-dontwarn com.sun.jna.Library
-dontwarn com.sun.jna.Native
-dontwarn com.sun.jna.Pointer
-dontwarn com.sun.jna.Structure$ByValue
-dontwarn com.sun.jna.Structure$FieldOrder
-dontwarn com.sun.jna.Structure
-dontwarn com.sun.jna.internal.Cleaner$Cleanable
-dontwarn com.sun.jna.internal.Cleaner

# Preserve JNA classes and native methods
-keep class com.sun.jna.** { *; }
-keepclassmembers class com.sun.jna.** { *; }

# Preserve JNI-related classes (if your plugin uses them directly)
-keep class * { native <methods>; }

# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

-dontwarn java.awt.Component
-dontwarn java.awt.GraphicsEnvironment
-dontwarn java.awt.HeadlessException
-dontwarn java.awt.Window

-dontwarn javax.lang.model.element.Modifier

# Keep all plugin-related classes
-keep class com.reown.reown_yttrium.** { *; }
#-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }
-keep class io.flutter.embedding.engine.plugins.** { *; }

# Ensure FlutterPlugin classes are not stripped
-keep class io.flutter.plugin.common.MethodChannel { *; }
-keep class io.flutter.embedding.engine.FlutterEngine { *; }

# Avoid stripping Pigeon-generated bindings (if used)
-keep class dev.flutter.pigeon.** { *; }

#### From Kotlin SDK

# Preserve all annotations (JNA and other libraries)
-keepattributes *Annotation*

# Preserve the uniffi generated classes
-keep class uniffi.** { *; }

# Preserve all public and protected fields and methods
-keepclassmembers class ** {
    public *;
    protected *;
}