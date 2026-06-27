package handlers

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/internal/db"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
)

var category models.Category
var categoryList []models.Category

// カテゴリ一覧表示
func GetCategoryList(r *gin.Context) {
	result := db.DB.Find(&categoryList)
	if result.Error != nil {
		log.Fatal("カテゴリーの一覧出力に失敗しました。：", result.Error)
	}
	r.JSON(http.StatusOK, &categoryList)

	fmt.Println("カテゴリーの一覧が正常に出力されました：", result.RowsAffected)
}

// カテゴリ個別表示
func GetCategory(r *gin.Context) {
	id := r.Param("id")
	result := db.DB.Where("id = ?", id).First(&category)
	if result.Error != nil {
		log.Fatal("カテゴリーの個別出力に失敗しました。：", result.Error)
	}
	r.JSON(http.StatusOK, &category)

	fmt.Println("カテゴリーの個別表示が正常に出力されました：", result.RowsAffected)
}

// カテゴリ新規作成
func CreateCategory(r *gin.Context) {
	if err := r.ShouldBindJSON(&category); err != nil {
		r.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	//受け取ったJSONファイルの出力
	fmt.Println("受け取ったJSONファイル：", category)
	result := db.DB.Create(&category)
	if result.Error != nil {
		log.Fatal("カテゴリーの登録に失敗しました：", result.Error)
	}
	fmt.Println("カテゴリーが正常に登録されました：", result.RowsAffected)
}

// カテゴリ情報更新
func UpdateCategory(r *gin.Context) {
	if err := r.ShouldBindJSON(&category); err != nil {
		r.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	id := r.Param("id")
	result := db.DB.Where("id = ?", id).Save(&category)
	if result.Error != nil {
		log.Fatal("カテゴリーの更新に失敗しました：", result.Error)
	}
	fmt.Println("カテゴリーが正常に更新されました：", result.RowsAffected)
}

// カテゴリ削除
func DeleteCategory(r *gin.Context) {
	id := r.Param("id")
	result := db.DB.Where("id = ?", id).Delete(&category)
	if result.Error != nil {
		log.Fatal("カテゴリーの削除に失敗しました：", result.Error)
	}
	fmt.Println("カテゴリーが正常に削除されました：", result.RowsAffected)
}
