package handlers

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/internal/db"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/utils"
)

var product models.Product
var productList []models.Product

// 商品一覧表示
func GetProductList(r *gin.Context) {
	result := db.DB.Find(&productList)
	if result.Error != nil {
		utils.ErrorResponse(r, 500, "failed to fetch product list", result.Error)
		return
	}
	r.JSON(http.StatusOK, &productList)

	fmt.Println("プロダクトの一覧が正常に出力されました：", result.RowsAffected)
}

// 商品個別表示
func GetProduct(r *gin.Context) {
	id := r.Param("id")

	result := db.DB.Where("id = ?", id).First(&product)
	if result.Error != nil {
		utils.ErrorResponse(r, 500, "failed to fetch category", result.Error)
		return
	}
	r.JSON(http.StatusOK, &product)

	fmt.Println("プロダクトの個別表示が正常に出力されました：", result.RowsAffected)
}

// 商品新規作成
func CreateProduct(r *gin.Context) {
	if err := r.ShouldBindJSON(&product); err != nil {
		utils.ErrorResponse(r, 400, "invalid request category data", err)
		return
	}
	//受け取ったJSONファイルの出力
	fmt.Println("受け取ったJSONファイル：", product)

	result := db.DB.Create(&product)
	if result.Error != nil {
		utils.ErrorResponse(r, 500, "invalid create category data", result.Error)
		return
	}
	fmt.Println("プロダクトが正常に登録されました：", result.RowsAffected)
}

// 商品情報更新
func UpdateProduct(r *gin.Context) {
	if err := r.ShouldBindJSON(&product); err != nil {
		utils.ErrorResponse(r, 400, "invalid request category data", err)
		return
	}

	id := r.Param("id")

	result := db.DB.Where("id = ?", id).Save(&store)
	if result.Error != nil {
		utils.ErrorResponse(r, 500, "invalid update store data", result.Error)
		return
	}
	fmt.Println("店舗が正常に更新されました：", result.RowsAffected)
}

// 商品削除
func DeleteProduct(r *gin.Context) {
	id := r.Param("id")

	result := db.DB.Where("id = ?", id).Delete(&product)
	if result.Error != nil {
		utils.ErrorResponse(r, 500, "invalid delete category data", result.Error)
		return
	}
	fmt.Println("プロダクトが正常に削除されました：", result.RowsAffected)
}
