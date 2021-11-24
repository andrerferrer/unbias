import mapboxgl from '!mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/dark-v10',
      center: [-28.673147, 10.599413],
      zoom: 2
    });

    const markers = JSON.parse(mapElement.dataset.markers);

    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);

  }
};


const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    //const popup = new mapboxgl.Popup().setHTML(marker.info_window); // add this

    new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      //.setPopup(popup) // add this
      .addTo(map);
  });
};





export { initMapbox };
