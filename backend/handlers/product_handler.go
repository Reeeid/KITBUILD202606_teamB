package handlers

import (
	"fmt"

	"github.com/gin-gonic/gin"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/internal/db"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/internal/response"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
)

// 商品一覧表示
func GetProductList(r *gin.Context) {
	var productList []models.Product
	result := db.DB.Find(&productList)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "failed to fetch product list", result.Error)
		return
	}

	fmt.Println("プロダクトの一覧が正常に出力されました：", result.RowsAffected)
	response.SuccessResponse(r, &productList)
}

// 商品個別表示
func GetProduct(r *gin.Context) {
	var product models.Product
	id := r.Param("id")

	result := db.DB.Where("id = ?", id).First(&product)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "failed to fetch product", result.Error)
		return
	}

	fmt.Println("プロダクトの個別表示が正常に出力されました：", result.RowsAffected)
	response.SuccessResponse(r, &product)
}

// 商品新規作成
func CreateProduct(r *gin.Context) {
	var product models.Product
	if err := r.ShouldBindJSON(&product); err != nil {
		response.ErrorResponse(r, 400, "invalid request product data", err)
		return
	}
	//受け取ったJSONファイルの出力
	fmt.Println("受け取ったJSONファイル：", product)

	result := db.DB.Create(&product)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "invalid create product data", result.Error)
		return
	}

	fmt.Println("プロダクトが正常に登録されました：", result.RowsAffected)
	response.SuccessResponse(r, nil)
}

// 商品情報更新
func UpdateProduct(r *gin.Context) {
	var product models.Product
	if err := r.ShouldBindJSON(&product); err != nil {
		response.ErrorResponse(r, 400, "invalid request product data", err)
		return
	}

	id := r.Param("id")

	result := db.DB.Where("id = ?", id).Save(&product)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "invalid update product data", result.Error)
		return
	}

	fmt.Println("プロダクトが正常に更新されました：", result.RowsAffected)
	response.SuccessResponse(r, nil)
}

// 商品削除
func DeleteProduct(r *gin.Context) {
	var product models.Product
	id := r.Param("id")

	result := db.DB.Where("id = ?", id).Delete(&product)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "invalid delete product data", result.Error)
		return
	}

	fmt.Println("プロダクトが正常に削除されました：", result.RowsAffected)
	response.SuccessResponse(r, nil)
}
