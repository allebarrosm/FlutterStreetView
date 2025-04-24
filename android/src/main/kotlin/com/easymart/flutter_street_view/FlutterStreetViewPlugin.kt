package com.easymart.flutter_street_view

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FlutterStreetViewPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var streetView: StreetView? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "flutter_street_view")
        channel.setMethodCallHandler(this)
        
        binding.platformViewRegistry.registerViewFactory(
            "flutter_street_view/native",
            StreetViewFactory { view -> streetView = view }
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "updatePosition" -> {
                val lat = call.argument<Double>("latitude") ?: 0.0
                val lng = call.argument<Double>("longitude") ?: 0.0
                streetView?.updateCoordinates(lat, lng)
                result.success(null)
            }
            "positionChanged" -> {
                // Esta parte será implementada no lado do Flutter
                result.notImplemented()
            }
            else -> result.notImplemented()
        }
    }
}