package db

import (
	"database/sql"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
)

var DB *gorm.DB

// データベース接続の初期化関数
func InitDB() *sql.DB {
	var err error

	DB, err = gorm.Open(mysql.Open(os.Getenv("DATABASE_URL")), &gorm.Config{})
	if err != nil {
		log.Fatal("データベスの取得に失敗しました:", err)
	}

	DB.AutoMigrate(&models.Category{}, &models.Product{}, &models.Store{})
	sql, _ := DB.DB()
	return sql
}
