package com.example.fcb_pay_plus

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.material3.MaterialTheme
import androidx.core.content.ContextCompat
import android.os.Bundle
import android.Manifest
import android.util.Log
import com.amplifyframework.ui.liveness.ui.LivenessColorScheme
import com.amplifyframework.ui.liveness.ui.FaceLivenessDetector

class FaceLivenessActivity : ComponentActivity() {
    private val cameraPermissionLauncher = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { granted ->
        if (granted) {
            // Permission granted, continue with face liveness flow
            startFaceLivenessFlow()
        } else {
            // Permission denied, inform the user and handle gracefully
            finish() // or show a message and close the activity
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        checkCameraPermissionAndProceed()
    }

    private fun checkCameraPermissionAndProceed() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA)
            != PackageManager.PERMISSION_GRANTED
        ) {
            // Request camera permission
            cameraPermissionLauncher.launch(Manifest.permission.CAMERA)
        } else {
            // Permission already granted
            startFaceLivenessFlow()
        }
    }

    private fun startFaceLivenessFlow() {
        setContent {
            MaterialTheme(
                colorScheme = LivenessColorScheme.default()
            ) {
                FaceLivenessDetector(
                    sessionId = intent.getStringExtra("sessionId") ?: "",
                    region = intent.getStringExtra("region") ?: "us-east-1",
                    onComplete = {
                        val message = "Face liveness session completed successfully"
                        val resultIntent = Intent().apply {
                            putExtra("status", "complete")
                            putExtra("message", message)
                        }
                        setResult(Activity.RESULT_OK, resultIntent)
                        finish()
                    },
                    onError = { error ->
                        val resultIntent = Intent().apply {
                            putExtra("status", "error")
                            putExtra("message", error.message)
                        }
                        setResult(Activity.RESULT_CANCELED, resultIntent)
                        finish()
                    }
                )
            }
        }
    }
}
