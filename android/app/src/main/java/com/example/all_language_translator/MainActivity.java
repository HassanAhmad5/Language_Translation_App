package com.example.all_language_translator;

import android.os.Bundle;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;
import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.ArrayList;
public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "all_language_translator/speech";
    private SpeechRecognizer speechRecognizer;
    private Intent speechIntent;
    private MethodChannel.Result resultCallback;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("startListening")) {
                        String language = call.argument("language"); // Get language from arguments
                        resultCallback = result;
                        startListening(language);
                    } else if (call.method.equals("stopListening")) {
                        stopListening();
                        result.success("Listening Stopped");
                    } else {
                        result.notImplemented();
                    }
                });
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        speechRecognizer = SpeechRecognizer.createSpeechRecognizer(this);
        speechRecognizer.setRecognitionListener(new RecognitionListener() {
            @Override
            public void onReadyForSpeech(Bundle params) {
                // Ready to start listening
            }

            @Override
            public void onBeginningOfSpeech() {
                // Speech input detected
            }

            @Override
            public void onRmsChanged(float rmsdB) {
                // Volume change (can be ignored)
            }

            @Override
            public void onBufferReceived(byte[] buffer) {
                // Buffer received (can be ignored)
            }

            @Override
            public void onEndOfSpeech() {
                // Speech ended
            }

            @Override
            public void onError(int error) {
                if (resultCallback != null) {
                    resultCallback.error("SpeechError", "Error Code: " + error, null);
                }
            }

            @Override
            public void onResults(Bundle results) {
                if (resultCallback != null) {
                    ArrayList<String> matches = results.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);
                    if (matches != null && !matches.isEmpty()) {
                        resultCallback.success(matches.get(0));
                    } else {
                        resultCallback.success("");
                    }
                }
            }

            @Override
            public void onPartialResults(Bundle partialResults) {
                // Partial results received
            }

            @Override
            public void onEvent(int eventType, Bundle params) {
                // Other events
            }
        });

        // Initialize the speech intent with default values
        speechIntent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        speechIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
    }

    private void startListening(String language) {
        if (language != null && !language.isEmpty()) {
            speechIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, language); // Set target language
        }
        speechRecognizer.startListening(speechIntent);
    }

    private void stopListening() {
        speechRecognizer.stopListening();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (speechRecognizer != null) {
            speechRecognizer.destroy();
        }
    }
}