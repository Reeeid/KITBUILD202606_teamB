package handlers

import (
	"github.com/gin-gonic/gin"

	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/models"
	"github.com/tadanobutaaaaa/KITBUILD202606_teamB/utils"
)

// 商品一覧表示
func GetProductList(c *gin.Context) {

}

// 商品個別表示
func GetProduct(c *gin.Context) {

}

// 商品新規作成
func CreateProduct(c *gin.Context) {
	var Product models.Product
	utils.CreateItem(c, Product)
}

// 商品情報更新
func UpdateProduct(c *gin.Context) {

}

// 商品削除
func DeleteProduct(c *gin.Context) {

}
