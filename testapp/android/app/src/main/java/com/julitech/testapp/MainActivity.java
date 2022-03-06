package com.julitech.testapp;

import android.content.Intent;
import android.net.Uri;
import android.widget.Toast;
import androidx.core.content.FileProvider;


import java.io.File;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
    new  MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),"openfile").setMethodCallHandler(
            (methodCall, result) -> {
                String txt = methodCall.argument("file");

                Uri uri = FileProvider.getUriForFile(getContext(), "com.julitech.testapp.fileprovider", new File(txt));

                if (methodCall.method.equals("openTorrentFile")){
                    Intent intent = new Intent(Intent.ACTION_VIEW);
                    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                    intent.setDataAndType(uri,"application/x-bittorrent");
//                        Toast.makeText(MainActivity.this, txt, Toast.LENGTH_SHORT).show();
                    startActivity(intent);
                }else {
                    result.notImplemented();
                }
            }
    );
    }


//    @Override
//    public void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        new  FlutterMethodChannel()
//    }
}
