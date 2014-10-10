var markers = [];
var socket = io()
var map;
var count = 0;

GoogleMapsLoader.KEY = '';

GoogleMapsLoader.load(function(google) {
	var myLatlng = new google.maps.LatLng(48.8534100,2.3488000);
	var mapOptions = {
		zoom: 2,
		center: myLatlng
	}

	map = new google.maps.Map(document.getElementById('map'), mapOptions);

	socket.on('tweet', function (tweet) {
		createMarker(tweet, google);
	});
});

function createMarker(tweet, google) {
	if (markers.length > 10) {
		removed_marker = markers.shift();
		removed_marker.setMap(null);
	}
	if (tweet.coordinates !== null && typeof google != null) {
		var myLatlng = new google.maps.LatLng(tweet.coordinates.coordinates[1],tweet.coordinates.coordinates[0]);
	  	markers.push(
	  		new google.maps.Marker({
				position: myLatlng,
				map: map,
				title: 'Hello World!'
	  		})
	  	);
	  	if (typeof tweet.text != 'undefined'); {
	  		var infowindow = new google.maps.InfoWindow({
			    content: tweet.text
			});
			
	  		infowindow.open(map,markers[markers.length - 1]);
  		}

		document.getElementById('count').innerHTML = ++count;
	}
};
