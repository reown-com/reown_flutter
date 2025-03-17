# Preserve JNA classes and native methods
-keep class com.sun.jna.** { *; }
-keepclassmembers class com.sun.jna.** { *; }
-dontwarn com.sun.jna.**

# Preserve JNI-related classes (if your plugin uses them directly)
-keep class * { native <methods>; }


# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.reown.reown_yttrium.ReownYttriumPlugin
-dontwarn javax.lang.model.element.Modifier

# Keep all plugin-related classes
-keep class com.reown.reown_yttrium.** { *; }
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }
-keep class io.flutter.embedding.engine.plugins.** { *; }

# Ensure FlutterPlugin classes are not stripped
-keep class io.flutter.plugin.common.MethodChannel { *; }
-keep class io.flutter.embedding.engine.FlutterEngine { *; }

# Avoid stripping Pigeon-generated bindings (if used)
-keep class dev.flutter.pigeon.** { *; }

#### From kotlins project

#### web3wallet-rules.pro
-keep class com.reown.walletkit.client.Wallet$Model$Cacao$Signature { *; }
-keep class com.reown.walletkit.client.Wallet$Model$Cacao { *; }
-keep class com.reown.walletkit.client.Wallet$Model { *; }
-keep class com.reown.walletkit.client.Wallet { *; }

# Preserve all annotations (JNA and other libraries)
-keepattributes *Annotation*

# Keep all JNA-related classes and methods
-keep class com.sun.jna.** { *; }
-keepclassmembers class com.sun.jna.** {
    native <methods>;
    *;
}

# Preserve the uniffi generated classes
-keep class uniffi.** { *; }

# Preserve all public and protected fields and methods
-keepclassmembers class ** {
    public *;
    protected *;
}

# Disable warnings for uniffi and JNA
-dontwarn uniffi.**
-dontwarn com.sun.jna.**

####

#### consumer-rules.pro
-dontwarn java8.util.**
-dontwarn jnr.posix.**
-dontwarn com.kenai.**

#-keep class org.bouncycastle.**
-dontwarn org.bouncycastle.jce.provider.X509LDAPCertStoreSpi
-dontwarn org.bouncycastle.x509.util.LDAPStoreHelper
-keep class org.bouncycastle.** { *; }

# Web3j
-keep class org.web3j.** { *; }

-keep class * extends org.web3j.abi.TypeReference
-keep class * extends org.web3j.abi.datatypes.Type

#-dontwarn java.lang.SafeVarargs
-dontwarn org.slf4j.**

### sdk-rules.pro

-allowaccessmodification
-keeppackagenames doNotKeepAThing

-dontobfuscate
-dontshrink
-dontoptimize
-dontusemixedcaseclassnames
-dontwarn java.lang.invoke.StringConcatFactory
