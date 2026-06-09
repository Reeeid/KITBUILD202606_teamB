package godatabase

import (
	"database/sql"
	_ "github.com/lib/pq"
	"log"
)

func main() {
	dsn := "host=localhost port=5432 user=postgres password=password dbname=sampledb sslmode=disable"

	db, err := sql.Open("postgres", dsn)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	if err = db.Ping(); err != nil {
		log.Fatal("DB接続失敗: ", err)
	}

	log.Println("DB接続成功")
}
