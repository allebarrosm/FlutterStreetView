package com.easymart.flutter_street_view

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class StreetViewFactory(
    private val onViewCreated: (StreetView) -> Unit
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        val creationParams = args as? Map<String?, Any?>
        return StreetView(context, creationParams).also {
            onViewCreated(it)
        }
    }
}