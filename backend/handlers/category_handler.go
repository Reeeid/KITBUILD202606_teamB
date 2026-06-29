package handlers

import (
	"fmt"

	"github.com/gin-gonic/gin"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/internal/db"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/internal/response"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
)

// カテゴリ一覧表示
func GetCategoryList(r *gin.Context) {
	var categoryList []models.Category
	result := db.DB.Find(&categoryList)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "failed to fetch category list", result.Error)
		return
	}

	fmt.Println("カテゴリーの一覧が正常に出力されました：", result.RowsAffected)
	response.SuccessResponse(r, &categoryList)
}

// カテゴリ個別表示
func GetCategory(r *gin.Context) {
	var category models.Category
	id := r.Param("id")

	result := db.DB.First(&category, id)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "failed to fetch category", result.Error)
		return
	}

	fmt.Println("カテゴリーの個別表示が正常に出力されました：", result.RowsAffected)
	response.SuccessResponse(r, &category)
}

// カテゴリ新規作成
func CreateCategory(r *gin.Context) {
	var category models.Category
	if err := r.ShouldBindJSON(&category); err != nil {
		response.ErrorResponse(r, 400, "invalid request category data", err)
		return
	}

	//受け取ったJSONファイルの出力
	fmt.Println("受け取ったJSONファイル：", category)
	result := db.DB.Create(&category)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "invalid update category data", result.Error)
		return
	}

	fmt.Println("カテゴリーが正常に登録されました：", result.RowsAffected)
	response.SuccessResponse(r, nil)
}

// カテゴリ情報更新
func UpdateCategory(r *gin.Context) {
	var category models.Category
	if err := r.ShouldBindJSON(&category); err != nil {
		response.ErrorResponse(r, 400, "invalid request category data", err)
		return
	}

	id := r.Param("id")

	result := db.DB.Where("id = ?", id).Save(&category)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "invalid update category data", result.Error)
		return
	}

	fmt.Println("カテゴリーが正常に更新されました：", result.RowsAffected)
	response.SuccessResponse(r, nil)
}

// カテゴリ削除
func DeleteCategory(r *gin.Context) {
	var category models.Category
	id := r.Param("id")

	result := db.DB.Where("id = ?", id).Delete(&category)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "invalid delete category data", result.Error)
		return
	}

	fmt.Println("カテゴリーが正常に削除されました：", result.RowsAffected)
	response.SuccessResponse(r, nil)
}
