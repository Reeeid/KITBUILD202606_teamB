package handlers

import (
	"github.com/gin-gonic/gin"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/utils"
)

// カテゴリ一覧表示
func GetCategoryList(c *gin.Context) {

}

// カテゴリ個別表示
func GetCategory(c *gin.Context) {

}

// カテゴリ新規作成
func CreateCategory(c *gin.Context) {
	var Category models.Category
	utils.CreateItem(c, Category)
}

// カテゴリ情報更新
func UpdateCategory(c *gin.Context) {

}

// カテゴリ削除
func DeleteCategory(c *gin.Context) {

}
