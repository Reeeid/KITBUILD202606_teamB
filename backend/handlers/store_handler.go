package handlers

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/internal/db"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
)

var store models.Store
var storeList []models.Store

// 店舗一覧表示
func GetStoreList(r *gin.Context) {
	result := db.DB.Find(&storeList)
	if result.Error != nil {
		log.Fatal("店舗の一覧出力に失敗しました。：", result.Error)
	}
	r.JSON(http.StatusOK, &storeList)

	fmt.Println("店舗の一覧が正常に出力されました：", result.RowsAffected)
}

// 店舗個別表示
func GetStore(r *gin.Context) {
	id := r.Param("id")
	result := db.DB.Where("id = ?", id).First(&store)
	if result.Error != nil {
		log.Fatal("店舗の個別出力に失敗しました。：", result.Error)
	}
	r.JSON(http.StatusOK, &store)

	fmt.Println("店舗の個別表示が正常に出力されました：", result.RowsAffected)
}

// 店舗新規作成
func CreateStore(r *gin.Context) {
	if err := r.ShouldBindJSON(&store); err != nil {
		r.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	//受け取ったJSONファイルの出力
	fmt.Println("受け取ったJSONファイル：", store)
	result := db.DB.Create(&store)
	if result.Error != nil {
		log.Fatal("店舗の登録に失敗しました：", result.Error)
	}
	fmt.Println("店舗が正常に登録されました：", result.RowsAffected)
}

// 店舗情報更新
func UpdateStore(r *gin.Context) {
	if err := r.ShouldBindJSON(&store); err != nil {
		r.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	id := r.Param("id")
	result := db.DB.Where("id = ?", id).Save(&store)
	if result.Error != nil {
		log.Fatal("店舗の更新に失敗しました：", result.Error)
	}
	fmt.Println("店舗が正常に更新されました：", result.RowsAffected)
}

// 店舗削除
func DeleteStore(r *gin.Context) {
	id := r.Param("id")
	result := db.DB.Where("id = ?", id).Delete(&store)
	if result.Error != nil {
		log.Fatal("店舗の削除に失敗しました：", result.Error)
	}
	fmt.Println("店舗が正常に削除されました：", result.RowsAffected)
}
