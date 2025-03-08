package com.example.fcb_pay_plus

import android.app.Application
import android.util.Log
import com.amplifyframework.core.Amplify
import com.amplifyframework.AmplifyException
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.predictions.aws.AWSPredictionsPlugin

class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        try {
            // Add the required Amplify plugins. In this example, we're adding Auth and Predictions.
            Amplify.addPlugin(AWSCognitoAuthPlugin())
            // Configure Amplify using the amplifyconfiguration.json file located in res/raw.
            Amplify.configure(applicationContext)
            Log.i("MyApplication", "Amplify configured successfully.")
        } catch (error: AmplifyException) {
            Log.e("MyApplication", "Error initializing Amplify", error)
        }
    }
}
