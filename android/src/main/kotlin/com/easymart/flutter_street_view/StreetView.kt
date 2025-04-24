package com.easymart.flutter_street_view

import android.content.Context
import android.view.View
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapView
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.StreetViewPanorama
import com.google.android.gms.maps.StreetViewPanoramaView
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.StreetViewPanoramaCamera
import com.google.android.gms.maps.model.StreetViewSource
import io.flutter.plugin.platform.PlatformView

class StreetView(
    context: Context,
    private var creationParams: Map<String?, Any?>?
) : PlatformView, OnMapReadyCallback {

    private val streetViewPanoramaView = StreetViewPanoramaView(context)
    private val mapView = MapView(context)
    private var streetViewPanorama: StreetViewPanorama? = null
    
    private var latitude = (creationParams?.get("latitude") as? Double) ?: 0.0
    private var longitude = (creationParams?.get("longitude") as? Double) ?: 0.0
    private var bearing = (creationParams?.get("bearing") as? Double)?.toFloat() ?: 0f
    private var tilt = (creationParams?.get("tilt") as? Double)?.toFloat() ?: 0f
    private var zoom = (creationParams?.get("zoom") as? Double)?.toFloat() ?: 1f

    init {
        // Inicializa o MapView (opcional, apenas se você realmente precisa dele)
        mapView.onCreate(null)
        mapView.getMapAsync(this)

        // Inicializa o StreetViewPanorama
        streetViewPanoramaView.onCreate(null)
        streetViewPanoramaView.getStreetViewPanoramaAsync { panorama ->
            streetViewPanorama = panorama
            configureStreetView()
        }
    }

    private fun configureStreetView() {
        streetViewPanorama?.apply {
            // Configurações essenciais para navegação
            isUserNavigationEnabled = true  // Permite navegar entre pontos
            isPanningGesturesEnabled = true // Habilita gestos de arrastar
            isZoomGesturesEnabled = true    // Habilita zoom com gestos
            isStreetNamesEnabled = true     // Mostra nomes de ruas
            
            // Configuração avançada para melhor navegação
            isZoomGesturesEnabled = true
            setPosition(LatLng(latitude, longitude), 100, StreetViewSource.OUTDOOR)

            // Configuração suave da câmera
            val camera = StreetViewPanoramaCamera.Builder()
                .bearing(bearing)
                .tilt(tilt)
                .zoom(zoom)
                .build()
            
            animateTo(camera, 1000)
        }
    }

    fun updateCoordinates(newLatitude: Double, newLongitude: Double) {
        latitude = newLatitude
        longitude = newLongitude
        streetViewPanorama?.setPosition(LatLng(latitude, longitude), 150)
    }

    override fun getView(): View {
        return streetViewPanoramaView
    }

    override fun dispose() {
        streetViewPanoramaView.onDestroy()
        mapView.onDestroy()
    }

    override fun onMapReady(googleMap: GoogleMap) {
        val latLng = LatLng(latitude, longitude)
        googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(latLng, 15f))
    }
}