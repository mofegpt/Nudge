package main

import "fmt"

type UserLocation struct {
	NudgerID   int     `json:"nudger_id"`
	SmallImage string  `json:"small_image"`
	Longitude  float64 `json:"longitude"`
	Latitude   float64 `json:"latitude"`
}

type DetailedUser struct {
	NudgerID    int     `json:"nudger_id"`
	FirstName   string  `json:"first_name"`
	LastName    string  `json:"last_name"`
	Bio         string  `json:"bio"`
	MediumImage string  `json:"medium_image"`
	Distance    float64 `json:"distance"`
}

// Get location of users that are less than 100 meters away
func getNearbyUsers(lon float64, lat float64) (result []UserLocation) {
	stmt := `
	SELECT nudger_id, small_image, ST_Y(location) AS latitude, ST_X(location) AS longitude
	FROM user_location
	WHERE ST_Distance_Sphere(location, ST_GeomFromText(?)) <= 100;
	`
	// Construct POINT string
	point := fmt.Sprintf("POINT(%f %f)", lon, lat)

	rows, err := mdb.db.Query(stmt, point)
	if err != nil {
		fmt.Printf("\n\nERROR WITH QUERY %s\n\n", err)
		panic(err)
	}
	defer rows.Close()

	for rows.Next() {
		var user UserLocation
		err = rows.Scan(&user.NudgerID, &user.SmallImage, &user.Latitude, &user.Longitude)
		if err != nil {
			panic(err)
		}
		result = append(result, user)
	}
	return result
}

// Get distance and bio of users that are less than 100 meters away
func getDetailedNearbyUsers(lon float64, lat float64) (result []DetailedUser) {
	stmt := `
	SELECT  b.nudger_id, p.first_name, p.last_name, p.bio, p.image, ST_Distance_Sphere(
		b.location, 
        ST_GeomFromText(?)) AS distance
	FROM user_location AS b
	JOIN user_profile AS p ON b.nudger_id = p.nudger_id
	WHERE ST_Distance_Sphere(b.location, ST_GeomFromText(?)) <= 100
	ORDER BY distance;`

	// Construct POINT string
	point := fmt.Sprintf("POINT(%f %f)", lon, lat)

	rows, err := mdb.db.Query(stmt, point, point)
	if err != nil {
		panic(err)
	}
	defer rows.Close()

	for rows.Next() {
		var user DetailedUser
		err = rows.Scan(&user.NudgerID, &user.FirstName, &user.LastName, &user.Bio, &user.MediumImage, &user.Distance)
		if err != nil {
			panic(err)
		}
		result = append(result, user)
	}
	return result
}
