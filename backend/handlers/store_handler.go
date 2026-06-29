package handlers

import (
	"fmt"

	"github.com/gin-gonic/gin"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/internal/db"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/internal/response"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
)

// 店舗一覧表示
func GetStoreList(r *gin.Context) {
	var storeList []models.Store
	result := db.DB.Find(&storeList)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "failed to fetch store list", result.Error)
		return
	}

	fmt.Println("店舗の一覧が正常に出力されました：", result.RowsAffected)
	response.SuccessResponse(r, &storeList)
}

// 店舗個別表示
func GetStore(r *gin.Context) {
	var store models.Store
	id := r.Param("id")

	result := db.DB.First(&store, id)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "failed to fetch store", result.Error)
		return
	}

	fmt.Println("店舗の個別表示が正常に出力されました：", result.RowsAffected)
	response.SuccessResponse(r, &store)
}

// 店舗新規作成
func CreateStore(r *gin.Context) {
	var store models.Store
	if err := r.ShouldBindJSON(&store); err != nil {
		response.ErrorResponse(r, 400, "invalid request store data", err)
		return
	}
	//受け取ったJSONファイルの出力
	fmt.Println("受け取ったJSONファイル：", store)

	result := db.DB.Create(&store)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "invalid create store data", result.Error)
		return
	}

	fmt.Println("店舗が正常に登録されました：", result.RowsAffected)
	response.SuccessResponse(r, nil)
}

// 店舗情報更新
func UpdateStore(r *gin.Context) {
	var store models.Store
	if err := r.ShouldBindJSON(&store); err != nil {
		response.ErrorResponse(r, 400, "invalid request store data", err)
		return
	}

	id := r.Param("id")

	result := db.DB.Where("id = ?", id).Save(&store)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "invalid update store data", result.Error)
		return
	}

	fmt.Println("店舗が正常に更新されました：", result.RowsAffected)
	response.SuccessResponse(r, nil)
}

// 店舗削除
func DeleteStore(r *gin.Context) {
	var store models.Store
	id := r.Param("id")

	result := db.DB.Where("id = ?", id).Delete(&store)
	if result.Error != nil {
		response.ErrorResponse(r, 500, "invalid delete store data", result.Error)
		return
	}

	fmt.Println("店舗が正常に削除されました：", result.RowsAffected)
	response.SuccessResponse(r, nil)
}
