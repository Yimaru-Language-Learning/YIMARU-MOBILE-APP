############################################
# Flutter
############################################
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

############################################
# Firebase (General Safe Rules)
############################################
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

############################################
# Google Sign-In
############################################
-keep class com.google.android.gms.auth.api.signin.** { *; }
-keep class com.google.android.gms.common.api.** { *; }
-dontwarn com.google.android.gms.**

############################################
# Play Services
############################################
-keep class com.google.android.gms.** { *; }

############################################
# flutter_inappwebview
############################################
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }
-dontwarn com.pichillilorenzo.flutter_inappwebview.**

############################################
# Keep annotations
############################################
-keepattributes *Annotation*


############################################
# Google Play Core
############################################
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**