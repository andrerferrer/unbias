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
      zoom: 1.3,
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    console.log(markers);

    addMarkersToMap(map, markers);
    // console.log(markers);
    addClusters(map, markers);
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

const addClusters = (map, markers) => {
  const coordinates = markers.map((marker) => {
    return [marker.lng, marker.lat]
  })
  map.on('load', () => {
    map.addSource('my-markers', {
      "type": "geojson",
      "data": {
        "type": "Feature",
        "geometry": {
          "type": "Point",
          "coordinates": coordinates,
          cluster: true,
          clusterMaxZoom: 14, // Max zoom to cluster points on
          clusterRadius: 50,
        },
        // "properties": {
        //   "title": "Mapbox DC",
        //   "marker-symbol": "monument"
        // }
      }
    });

    map.addLayer({
      id: 'clusters',
      type: 'circle',
      source: 'my-markers',
      filter: ['has', 'point_count'],
      paint: {
        'circle-color': [
          'step',
          ['get', 'point_count'],
          '#51bbd6',
          100,
          '#f1f075',
          750,
          '#f28cb1'
        ],
        'circle-radius': [
          'step',
          ['get', 'point_count'],
          20,
          100,
          30,
          750,
          40
        ]
      }
    });
  });

}



export { initMapbox };
