package main

import (
	"fmt"
	"context"
//	"github.com/google/uuid"
)

type UserLocation struct {
	NudgerID   string  `json:"nudger_id"`
	SmallImage string  `json:"small_image"`
	Longitude  float64 `json:"longitude"`
	Latitude   float64 `json:"latitude"`
	Distance   float64 `json:"distance"`
}

type DetailedUser struct {
	NudgerID    string  `json:"nudger_id"`
	FirstName   string  `json:"first_name"`
	LastName    string  `json:"last_name"`
	Bio         string  `json:"bio"`
	MediumImage string  `json:"medium_image"`
	Distance    float64 `json:"distance"`
}

// type NudgerInfo struct {
// 	NudgerID  uuid.UUID `json:"nudger_id"`
// 	FirstName string `json:"first_name"`
// 	LastName  string `json:"last_name"`
// 	Bio       string `json:"bio"`
// 	Image     string `json:"image"`
// 	Age       string `json:"age"`
// 	Email     string `json:"email"`
// }

type NudgerInfo struct {
	// NudgerID    uuid.UUID
	NudgerID    string
	FirstName   string
	LastName    string
	Age         string
	PicturePath string
	Bio       	string
	Email     	string
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
	SELECT  b.nudger_id, p.first_name, p.last_name, p.bio, p.image, ST_Distance_Sphere(b.location, ST_GeomFromText(?)) AS distance
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

// SELECT b.nudger_id, p.first_name, p.last_name, p.bio, p.image, TIMESTAMPDIFF(YEAR, p.born, CURDATE()) AS age, p.email
// 	FROM user_location AS b
// 	JOIN user_profile AS p ON b.nudger_id = p.nudger_id
// 	WHERE b.nudger_id = ?
func getNudgerInfo(id string) (result NudgerInfo) {
	stmt := `
	SELECT nudger_id, first_name, last_name, bio, image, TIMESTAMPDIFF(YEAR, born, CURDATE()) AS age, email FROM user_profile
	WHERE nudger_id = ?`

	rows, err := mdb.db.Query(stmt, id)
	if err != nil {
		panic(err)
	}
	defer rows.Close()

	for rows.Next() {
		var user NudgerInfo
		err = rows.Scan(&user.NudgerID, &user.FirstName, &user.LastName, &user.Bio, &user.PicturePath, &user.Age, &user.Email)
		if err != nil {
			fmt.Printf("\n\nERROR WITH  GETTING NUDGERINFO %s\n\n", err)
			panic(err)
		}
		result = user
	}
	return result
}

func createNudger(user NudgerInfo) (err error) {

	_, err = mdb.stmtInsertUser.Exec(user.NudgerID, user.FirstName, user.LastName, user.Age, user.Bio, user.PicturePath, user.Email)
	if err != nil {
		return err
	}
	return nil
}

func updateNudger(user NudgerInfo) (err error) {

	_, err = mdb.stmtUpdateUser.Exec(user.FirstName, user.LastName, user.Age, user.Bio, user.PicturePath, user.Email, user.NudgerID)
	if err != nil {
		return err
	}
	return nil
}

func CreateUser(ctx context.Context, arg NudgerInfo) (NudgerInfo, error) {

	_, err := mdb.stmtInsertUser.Exec(arg.NudgerID, arg.FirstName, arg.LastName, arg.Age, arg.Bio, arg.PicturePath, arg.Email)
	if err != nil {
		return NudgerInfo{} , err
	}

	var i NudgerInfo
	i.NudgerID = arg.NudgerID
	i.FirstName = arg.FirstName
	i.LastName = arg.LastName
	i.Age = arg.Age
	i.PicturePath = arg.PicturePath
	i.Bio = arg.Bio
	i.Email = arg.Email

	fmt.Printf("New user created")

	return i, nil
}
