package com.example.mobile_data_switcher

import android.content.Intent
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.mobile_data_switcher/network_settings"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openNetworkSettings") {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    // For Android 10 and above, ensure your app has a visible window.
                    if (isAppInForeground()) {
                        openMobileDataSettings()
                    } else {
                        // Optionally, show a notification to the user asking them to open your app.
                    }
                } else {
                    // For older versions, directly open the wireless settings.
                    openMobileDataSettings()
                }
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun isAppInForeground(): Boolean {
        // Check if app is in the foreground or has a visible window
        // Implement your logic here. Return true if in foreground.
        return true
    }

    private fun openMobileDataSettings() {
        val intent = Intent(Settings.ACTION_DATA_ROAMING_SETTINGS)
        startActivity(intent)
    }
}


