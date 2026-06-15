          Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      markers: _markers,
                      style: '''[
                            {
                            "featureType": "poi",
                            "stylers": [{"visibility": "off"}]
                            }
                            ]''',
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                      onTap: (LatLng latLng) {
                        if (_isPinMode && !_isTogglingMode) {
                          _addMarker(latLng);
                        }
                      },
                    ),
                    Align(
                      alignment: AlignmentGeometry.bottomCenter,
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _isTogglingMode = true;
                              _isPinMode = !_isPinMode;
                            });
                            Future.delayed(Duration(milliseconds: 300), () {
                              setState(() => _isTogglingMode = false);
                            });
                          },
                          child: Icon(
                            _isPinMode ? Icons.cancel : Icons.add_location,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),