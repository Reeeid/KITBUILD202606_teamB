package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	//店舗のCRUDエンドポイント
	store := r.Group("/store")
	{
		store.GET("")
		store.GET("/:id")
		store.POST("")
		store.PATCH("/:id")
		store.DELETE("/:id")
	}

	//カテゴリーのCRUDエンドポイント
	category := r.Group("/category")
	{
		category.GET("")
		category.GET("/:id")
		category.POST("")
		category.PATCH("/:id")
		category.DELETE("/:id")
	}

	//商品のCRUDエンドポイント
	product := r.Group("/product")
	{
		product.GET("")
		product.GET("/:id")
		product.POST("")
		product.PATCH("/:id")
		product.DELETE("/:id")
	}

	r.Run() // デフォルトでは localhost:8080 で起動
}
