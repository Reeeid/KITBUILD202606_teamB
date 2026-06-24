package db

import (
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
)

// データベース接続の初期化関数
func InitDB() *gorm.DB {
	loadEnv()

	db, err := gorm.Open(mysql.Open(os.Getenv("DATABASE_URL")), &gorm.Config{})
	if err != nil {
		log.Fatal(err)
	}

	db.AutoMigrate(&models.Category{}, &models.Product{}, &models.Store{})
	return db
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
