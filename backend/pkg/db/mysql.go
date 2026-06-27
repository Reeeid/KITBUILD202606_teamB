package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
)

// データベース接続の初期化関数
func InitDB() {
	loadEnv()

	db, err := sql.Open("mysql", os.Getenv("DATABASE_URL"))
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	} else {
		log.Println("データベースに接続しました！")
	}
}

// .envファイルから環境変数を読み込む関数
func loadEnv() {
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatal(err)
	}

	databaseUrl := os.Getenv("DATABASE_URL")

	fmt.Println("DATABASE_URL:", databaseUrl)
}
