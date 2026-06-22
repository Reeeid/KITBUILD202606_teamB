package main

import (
	"database/sql"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/handlers"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/internal/db"

	"github.com/gin-gonic/gin"
)

func DatabaseMiddleware(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Set("db", db)
		c.Next()
	}
}

func main() {
	// データベース接続の初期化
	database := db.InitDB()
	defer database.Close() // 最後にデータベースを閉じる

	r := gin.Default()

	//店舗のCRUDエンドポイント
	store := r.Group("/store")
	{
		store.GET("", handlers.GetStoreList)
		store.GET("/:id", handlers.GetStore)
		store.POST("", handlers.CreateStore)
		store.PATCH("/:id", handlers.UpdateStore)
		store.DELETE("/:id", handlers.DeleteStore)
	}

	//カテゴリーのCRUDエンドポイント
	category := r.Group("/category")
	{
		category.GET("", handlers.GetCategoryList)
		category.GET("/:id", handlers.GetCategory)
		category.POST("", handlers.CreateCategory)
		category.PATCH("/:id", handlers.UpdateCategory)
		category.DELETE("/:id", handlers.DeleteCategory)
	}

	//商品のCRUDエンドポイント
	product := r.Group("/product")
	{
		product.GET("", handlers.GetProductList)
		product.GET("/:id", handlers.GetProduct)
		product.POST("", handlers.CreateProduct)
		product.PATCH("/:id", handlers.UpdateProduct)
		product.DELETE("/:id", handlers.DeleteProduct)
	}

	r.Run() // デフォルトでは localhost:8080 で起動
}
