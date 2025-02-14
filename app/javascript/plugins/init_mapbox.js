import mapboxgl from '!mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/jsuay/ckwgaz6fn05aj14lhe45rxbck',
      center: [10.673147, 30.599413],
      zoom: 1.3
    });

    const markers = JSON.parse(mapElement.dataset.markers);

    addMarkersToMap(map, markers);
    // console.log(markers);
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
