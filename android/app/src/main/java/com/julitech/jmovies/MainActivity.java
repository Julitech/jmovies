package com.julitech.jmovies;

import android.content.Intent;
import android.net.Uri;

import androidx.annotation.NonNull;
import androidx.core.content.FileProvider;

import java.io.File;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), "opentorrent").setMethodCallHandler(
                (methodCall, result) -> {
                    if (methodCall.method.equals("openTorrentFile")) {
                        String filePath = methodCall.argument("path");
                        Uri uri = FileProvider.getUriForFile(getContext(), "com.julitech.jmovies.fileprovider", new File(filePath));
                        Intent intent = new Intent(Intent.ACTION_VIEW);
                        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                        intent.setDataAndType(uri, "application/x-bittorrent");
                        startActivity(intent);
                    } else {
                        result.notImplemented();
                    }

                }
        );
    }
}
