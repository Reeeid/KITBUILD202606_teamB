package handlers

import (
	"github.com/gin-gonic/gin"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/utils"
)

// 店舗一覧表示
func GetStoreList(c *gin.Context) {

}

// 店舗個別表示
func GetStore(c *gin.Context) {

}

// 店舗新規作成
func CreateStore(c *gin.Context) {
	var Store models.Store
	utils.CreateItem(c, Store)
}

// 店舗情報更新
func UpdateStore(c *gin.Context) {

}

// 店舗削除
func DeleteStore(c *gin.Context) {

}
