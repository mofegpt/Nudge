package main

import "fmt"

type UserLocation struct {
	NudgerID   int     `json:"nudger_id"`
	SmallImage string  `json:"small_image"`
	Longitude  float64 `json:"longitude"`
	Latitude   float64 `json:"latitude"`
	Distance   float64 `json:"distance"`
}

type DetailedUser struct {
	NudgerID    int     `json:"nudger_id"`
	FirstName   string  `json:"first_name"`
	LastName    string  `json:"last_name"`
	Bio         string  `json:"bio"`
	MediumImage string  `json:"medium_image"`
	Distance    float64 `json:"distance"`
}

type NudgerInfo struct {
	NudgerID  int    `json:"nudger_id"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
	Bio       string `json:"bio"`
	Image     string `json:"image"`
	Age       string `json:"age"`
	Email     string `json:"email"`
}

// Get location of users that are less than 100 meters away
func getNearbyUsers(lon float64, lat float64) (result []UserLocation) {
	stmt := `
	SELECT a.nudger_id, a.small_image, ST_Y(a.location) AS latitude, ST_X(a.location) AS longitude, ST_Distance_Sphere(
		a.location, 
        ST_GeomFromText(?)) AS distance
	FROM user_location AS a
	WHERE ST_Distance_Sphere(location, ST_GeomFromText(?)) <= 100;
	`
	// Construct POINT string
	point := fmt.Sprintf("POINT(%f %f)", lon, lat)

	rows, err := mdb.db.Query(stmt, point, point)
	if err != nil {
		fmt.Printf("\n\nERROR WITH QUERY %s\n\n", err)
		panic(err)
	}
	defer rows.Close()

	for rows.Next() {
		var user UserLocation
		err = rows.Scan(&user.NudgerID, &user.SmallImage, &user.Latitude, &user.Longitude, &user.Distance)
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

func getNudgerInfo(id int) (result NudgerInfo) {
	stmt := `
	SELECT b.nudger_id, p.first_name, p.last_name, p.bio, p.image, TIMESTAMPDIFF(YEAR, p.born, CURDATE()) AS age, p.email
	FROM user_location AS b
	JOIN user_profile AS p ON b.nudger_id = p.nudger_id
	WHERE b.nudger_id = ?`

	rows, err := mdb.db.Query(stmt, id)
	if err != nil {
		panic(err)
	}
	defer rows.Close()

	for rows.Next() {
		var user NudgerInfo
		err = rows.Scan(&user.NudgerID, &user.FirstName, &user.LastName, &user.Bio, &user.Image, &user.Age, &user.Email)
		if err != nil {
			fmt.Printf("\n\nERROR WITH  GETTING NUDGERINFO %s\n\n", err)
			panic(err)
		}
		result = user
	}
	return result

}
