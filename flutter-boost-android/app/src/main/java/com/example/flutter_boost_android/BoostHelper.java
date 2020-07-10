package com.example.flutter_boost_android;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.FlutterBoostPlugin;
import com.idlefish.flutterboost.Platform;
import com.idlefish.flutterboost.Utils;
import com.idlefish.flutterboost.interfaces.INativeRouter;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformViewRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.TextureRegistry;


public class BoostHelper {

    public static void initBoost(Application application) {
        INativeRouter router = new INativeRouter() {
            @Override
            public void openContainer(Context context, String url, Map<String, Object> urlParams, int requestCode, Map<String, Object> exts) {
                String assembleUrl = Utils.assembleUrl(url, urlParams);
                PageRouter.openPageByUrl(context, assembleUrl, urlParams);
            }
        };

        FlutterBoost.BoostLifecycleListener boostLifecycleListener = new FlutterBoost.BoostLifecycleListener() {
            @Override
            public void beforeCreateEngine() {

            }

            @Override
            public void onEngineCreated() {
//                FlutterBoost.instance().engineProvider().getPlugins().add(new FlutterPlugin() {
//                    @Override
//                    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
//                        //GeneratedPluginRegistrant.registerWith(binding.getFlutterEngine());
//
//                        FlutterBoostPlugin.singleton().addEventListener("FlutterBoostToiOS", new FlutterBoostPlugin.EventListener() {
//                            @Override
//                            public void onEvent(String name, Map args) {
//                                Log.i("FlutterBoostToiOS",args.toString());
//                            }
//                        });
//                    }
//
//                    @Override
//                    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
//
//                    }
//                });

                FlutterBoostPlugin.singleton().addEventListener("FlutterBoostToiOS", new FlutterBoostPlugin.EventListener() {
                    @Override
                    public void onEvent(String name, Map args) {
                        HashMap params = new HashMap<String, String>();
                        params.put("native", "Flutter 打开 native");
                        PageRouter.openPageByUrl(MyApplication.getContext(), PageRouter.NativePage, params);
                    }
                });
                
                // 注册MethodChannel，监听flutter侧的getPlatformVersion调用
//                MethodChannel methodChannel = new MethodChannel(FlutterBoost.instance().engineProvider().getDartExecutor(), "flutter_native_channel");
//                methodChannel.setMethodCallHandler((call, result) -> {
//
//                    if (call.method.equals("getPlatformVersion")) {
//                        result.success(Build.VERSION.RELEASE);
//                    } else {
//                        result.notImplemented();
//                    }
//
//                });
//
//                // 注册PlatformView viewTypeId要和flutter中的viewType对应
//                FlutterBoost
//                        .instance()
//                        .engineProvider()
//                        .getPlatformViewsController()
//                        .getRegistry()
//                        .registerViewFactory("plugins.test/view", new TextPlatformViewFactory(StandardMessageCodec.INSTANCE));

            }

            @Override
            public void onPluginsRegistered() {

            }

            @Override
            public void onEngineDestroy() {

            }
        };

        Platform platform = new FlutterBoost
                .ConfigBuilder(application, router)
                .isDebug(true)
                .whenEngineStart(FlutterBoost.ConfigBuilder.ANY_ACTIVITY_CREATED)
                .renderMode(FlutterView.RenderMode.texture)
                .lifecycleListener(boostLifecycleListener)
                .build();
        FlutterBoost.instance().init(platform);
    }
}

