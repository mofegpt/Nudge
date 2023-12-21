package main

type UserLocation struct {
	NudgerID   int     `json:"nudger_id"`
	SmallImage string  `json:"small_image"`
	Longtitude float64 `json:"longtitude"`
	Latitude   float64 `json:"latitude"`
}

// Get location of users that are less than 100 meters away
func getNearbyUsers() (result []UserLocation) {
	stmt := `
	SELECT nudger_id, small_image, ST_Y(location) AS longitude, ST_X(location) AS latitude
	FROM user_location
	WHERE ST_Distance_Sphere(location, ST_GeomFromText('POINT(-122.0312186 37.33233141)')) <= 100;
	`
	rows, err := mdb.db.Query(stmt)
	if err != nil {
		panic(err)
	}
	defer rows.Close()

	for rows.Next() {
		var user UserLocation
		err = rows.Scan(&user.NudgerID, &user.SmallImage, &user.Longtitude, &user.Latitude)
		if err != nil {
			panic(err)
		}
		result = append(result, user)
	}
	return result
}
