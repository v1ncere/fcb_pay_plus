package com.example.fcb_pay_plus

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import com.example.fcb_pay_plus.FaceLivenessActivity
import androidx.annotation.NonNull

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.fcb_pay_plus/liveness"
    private var pendingResult: MethodChannel.Result? = null
    private val FACE_LIVENESS_REQUEST_CODE = 1001

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
            if (call.method == "startFaceLiveness") {
                val sessionId = call.argument<String>("sessionId")
                val region = call.argument<String>("region")
                pendingResult = result
                
                // Launch the native FaceLivenessActivity
                val intent = Intent(this, FaceLivenessActivity::class.java)
                intent.putExtra("sessionId", sessionId)
                intent.putExtra("region", region)
                startActivityForResult(intent, FACE_LIVENESS_REQUEST_CODE)
            } else {
                result.notImplemented()
            }
        }
    }
    
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == FACE_LIVENESS_REQUEST_CODE) {
            // Extract the structured result from the Intent extras
            val status = data?.getStringExtra("status") ?: "error"
            val message = data?.getStringExtra("message") ?: "Unknown result"
            val resultMap = mapOf("status" to status, "message" to message)
            pendingResult?.success(resultMap)
            pendingResult = null
        }
    }
}